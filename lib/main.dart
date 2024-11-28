import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Membuat konfigurasi router dengan go_router
  final GoRouter _router = GoRouter(
    initialLocation: '/', // Menentukan lokasi awal
    routes: [
      // Rute untuk halaman beranda
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HalamanBeranda();
        },
      ),
      // Rute untuk halaman jelajah (koleksi)
      GoRoute(
        path: '/jelajah',
        builder: (BuildContext context, GoRouterState state) {
          return HalamanJelajah();
        },
      ),
      // Rute untuk halaman akun
      GoRoute(
        path: '/akun',
        builder: (BuildContext context, GoRouterState state) {
          return HalamanAkun();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Praktikum Navigasi',
      routerConfig: _router, // Menghubungkan router ke MaterialApp
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Praktikum Navigasi'),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Penting: Hilangkan semua padding dari ListView
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Lihat Koleksi'),
              onTap: () {
                // Navigasi ke halaman Jelajah (koleksi) menggunakan go_router
                context.go('/jelajah');
              },
            ),
            ListTile(
              leading: Icon(Icons.man_3),
              title: Text('Akun'),
              onTap: () {
                // Navigasi ke halaman Akun menggunakan go_router
                context.go('/akun');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Ini adalah tampilan Halaman Beranda'),
      ),
    );
  }
}

class HalamanJelajah extends StatefulWidget {
  @override
  _HalamanJelajahState createState() => _HalamanJelajahState();
}

class _HalamanJelajahState extends State<HalamanJelajah> {
  // Menyimpan index halaman yang dipilih
  int _selectedIndex = 0;

  // Daftar kategori untuk setiap pilihan
  List<String> _categories = ['Formal', 'Kasual', 'Vintage'];

  // Fungsi untuk mengganti tampilan berdasarkan pilihan kategori
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk menampilkan GridView berdasarkan kategori yang dipilih
  Widget _buildGridView() {
    // Menentukan jumlah gambar berdasarkan kategori
    List<String> images = List.generate(
        6, (index) => 'assets/pakaian.jpg'); // Sama untuk semua kategori

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Jumlah kolom dalam grid
        crossAxisSpacing: 10, // Spasi antar kolom
        mainAxisSpacing: 10, // Spasi antar baris
      ),
      itemCount: images.length, // Jumlah gambar yang akan ditampilkan
      itemBuilder: (context, index) {
        return Card(
          child: Image.asset(
            images[
                index], // Menggunakan gambar yang sama untuk seluruh kategori
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Koleksi'),
      ),
      body: Column(
        children: [
          // Menampilkan kategori yang dipilih
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Kategori: ${_categories[_selectedIndex]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Menampilkan GridView
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menampilkan pilihan yang sedang aktif
        onTap: _onItemTapped, // Menangani pemilihan item
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Formal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Kasual',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Vintage',
          ),
        ],
      ),
    );
  }
}

class HalamanAkun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Akun'),
      ),
      body: Center(
        child: Text('Ini adalah tampilan Halaman Akun'),
      ),
    );
  }
}
