Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266668AbRGHGfb>; Sun, 8 Jul 2001 02:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGHGfW>; Sun, 8 Jul 2001 02:35:22 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:32520 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S266668AbRGHGfH>; Sun, 8 Jul 2001 02:35:07 -0400
Date: Sun, 8 Jul 2001 03:36:43 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: hfs bug (w/oops)
Message-ID: <20010708033643.A3956@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kernel is 2.4.6 on SMP p3 box.

hfs doesn't like moving files; it complains thus:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jul  8 03:26:12 burocracia kernel: kernel BUG at /usr/src/linux/include/lin=
ux/dcache.h:244!
Jul  8 03:26:12 burocracia kernel: invalid operand: 0000
Jul  8 03:26:12 burocracia kernel: CPU:    0
Jul  8 03:26:12 burocracia kernel: EIP:    0010:[<dd040fa9>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jul  8 03:26:12 burocracia kernel: EFLAGS: 00010286
Jul  8 03:26:12 burocracia kernel: eax: 00000039   ebx: cd478760   ecx: 000=
00002   edx: 02000000
Jul  8 03:26:12 burocracia kernel: esi: 00000000   edi: cc354c20   ebp: cb8=
4f220   esp: c5fa7eb0
Jul  8 03:26:12 burocracia kernel: ds: 0018   es: 0018   ss: 0018
Jul  8 03:26:12 burocracia kernel: Process mv (pid: 3613, stackpage=3Dc5fa7=
000)
Jul  8 03:26:12 burocracia kernel: Stack: dd049346 dd049320 000000f4 d3bf1e=
50 c2a1a6f0 d3bf1de0 c2a1a680 0Jul  8 03:26:12 burocracia kernel:        00=
000000 cb84f200 cb84f000 00000000 00006025 661f1800 74656572 2Jul  8 03:26:=
12 burocracia kernel:        6c6f6f74 2e315f73 2d312e33 6f705f31 70726577 0=
0002e63 c013ebee dJul  8 03:26:12 burocracia kernel: Call Trace: [vfs_renam=
e_other+618/712] [vfs_rename+61/136] [sys_rename+Jul  8 03:26:12 burocracia=
 kernel: Code: 0f 0b 83 c4 0c 89 f6 f0 ff 03 8b 53 08 66 c7 42 2c 00 00 a1=
=20

>>EIP; dd040fa9 <[hfs]hfs_rename+115/2ec>   <=3D=3D=3D=3D=3D
Code;  dd040fa9 <[hfs]hfs_rename+115/2ec>      00000000 <_EIP>:
Code;  dd040fa9 <[hfs]hfs_rename+115/2ec>         0:   0f 0b               =
      ud2a      <=3D=3D=3D=3D=3D
Code;  dd040fab <[hfs]hfs_rename+117/2ec>         2:   83 c4 0c            =
      add    $0xc,%esp
Code;  dd040fae <[hfs]hfs_rename+11a/2ec>         5:   89 f6               =
      mov    %esi,%esi
Code;  dd040fb0 <[hfs]hfs_rename+11c/2ec>         7:   f0 ff 03            =
      lock incl (%ebx)
Code;  dd040fb3 <[hfs]hfs_rename+11f/2ec>         a:   8b 53 08            =
      mov    0x8(%ebx),%edx
Code;  dd040fb6 <[hfs]hfs_rename+122/2ec>         d:   66 c7 42 2c 00 00   =
      movw   $0x0,0x2c(%edx)
Code;  dd040fbc <[hfs]hfs_rename+128/2ec>        13:   a1 00 00 00 00      =
      mov    0x0,%eax
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Yob if you need more info...

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:

O capital =E9 um animal muito sens=EDvel, e vai se alimentar onde se sente =
melhor protegido

--Wolfgang Sauer

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7R/97gPqu395ykGsRArASAKCKrUVAJk8UG6OHmP5PIBlU2wtWtACeMdl6
TuDAiVCBlChRsCAKxuPSGds=
=eC49
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
