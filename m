Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S282016AbRKZShm>; Mon, 26 Nov 2001 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S282037AbRKZSgT>; Mon, 26 Nov 2001 13:36:19 -0500
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:44051 "HELO email04.aon.at") by vger.kernel.org with SMTP id <S282039AbRKZSfY>; Mon, 26 Nov 2001 13:35:24 -0500
Date: Mon, 26 Nov 2001 19:35:14 +0100
From: Andreas Krennmair <a.krennmair@aon.at>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for a few annoying "no license" warnings
Message-ID: <20011126193514.A914@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160; protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marcelo,
the following patch fixes these annoying "no license" warning from
insmod for af_packet.o, msdos.o, vfat.o, inflate_fs.o by adding the
MODULE_LICENSE. The patch is against 2.4.16.

diff -uNr linux-2.4.16.orig/fs/inflate_fs/inflate_syms.c linux-2.4.16/fs/in=
flate_fs/inflate_syms.c
--- linux-2.4.16.orig/fs/inflate_fs/inflate_syms.c	Thu Oct 25 22:53:53 2001
+++ linux-2.4.16/fs/inflate_fs/inflate_syms.c	Mon Nov 26 19:17:33 2001
@@ -19,3 +19,4 @@
 EXPORT_SYMBOL(zlib_fs_inflateReset);
 EXPORT_SYMBOL(zlib_fs_adler32);
 EXPORT_SYMBOL(zlib_fs_inflateSyncPoint);
+MODULE_LICENSE("GPL");
diff -uNr linux-2.4.16.orig/fs/msdos/msdosfs_syms.c linux-2.4.16/fs/msdos/m=
sdosfs_syms.c
--- linux-2.4.16.orig/fs/msdos/msdosfs_syms.c	Mon Mar 13 21:35:39 2000
+++ linux-2.4.16/fs/msdos/msdosfs_syms.c	Mon Nov 26 19:16:32 2001
@@ -40,3 +40,4 @@
=20
 module_init(init_msdos_fs)
 module_exit(exit_msdos_fs)
+MODULE_LICENSE("GPL");
diff -uNr linux-2.4.16.orig/fs/vfat/vfatfs_syms.c linux-2.4.16/fs/vfat/vfat=
fs_syms.c
--- linux-2.4.16.orig/fs/vfat/vfatfs_syms.c	Fri Oct 12 22:48:42 2001
+++ linux-2.4.16/fs/vfat/vfatfs_syms.c	Mon Nov 26 19:16:53 2001
@@ -33,3 +33,4 @@
=20
 module_init(init_vfat_fs)
 module_exit(exit_vfat_fs)
+MODULE_LICENSE("GPL");
diff -uNr linux-2.4.16.orig/net/packet/af_packet.c linux-2.4.16/net/packet/=
af_packet.c
--- linux-2.4.16.orig/net/packet/af_packet.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.16/net/packet/af_packet.c	Mon Nov 26 19:15:45 2001
@@ -1902,3 +1902,4 @@
=20
 module_init(packet_init);
 module_exit(packet_exit);
+MODULE_LICENSE("GPL");

Regards,
Andreas Krennmair
--=20
I know I could use the "mem=3D6M" switch to test it out myself, but I keep
telling myself that I have a lot of testers who have nothing better to do
than make me happy. Right? ("Yes Master").
  -- Linus Torvalds

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEeBAEUAwAGBQI8AotiAAoJECw98mPKmtL6b34EAMRpj+aIYTYyMz+VD2Z8ZrDZ
MwAlzj3IWxpTpygwnIyuLtWvs8ezSuQpQS2uV5wo+k+EJklLgg0JkuCHot1EQerd
QSAK0JKgI1SKM97ad7PwdnvVsUZ0HbERhg6El2E/Z0wo+MvMPxbTZc1JbcFUT01u
kvEvGB2bNig0Er2ey16jA/wOIhcl/ArSpgyteDOlgnOxY730E6LwQ29yA384uRG+
3EnI0J01C+AXPy516/3pblk6pC/qRCKEBtjgy1zBCeGl7V+kkgUC+xc8w7yCEEpq
UlNaHK9R3/2P9ULE6cP2ABmMDVdDgGDnunP7SwaPVZfhQQYAYeub9ruDHxAMVuMp
XA==
=/M1D
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
