Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRJYHD4>; Thu, 25 Oct 2001 03:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279715AbRJYHDi>; Thu, 25 Oct 2001 03:03:38 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:19466 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S279700AbRJYHDS>;
	Thu, 25 Oct 2001 03:03:18 -0400
Date: Thu, 25 Oct 2001 11:03:40 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for zoran framegrabber drivers
Message-ID: <20011025110340.A16717@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:36pm  up 11 days,  4:46,  3 users,  load average: 0.18, 0.13, 0.13
X-Uname: Linux orbita1.ru 2.2.20pre2
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Two MODULE_DEVICE_TABLE patches attached.
Please consider applying.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-zr36067

diff -u -X /usr/dontdiff /linux.vanilla/drivers/media/video/zr36067.c /linux/drivers/media/video/zr36067.c
--- /linux.vanilla/drivers/media/video/zr36067.c	Wed Oct 17 11:26:26 2001
+++ /linux/drivers/media/video/zr36067.c	Sat Oct 20 08:36:50 2001
@@ -245,6 +245,13 @@
 MODULE_PARM(lml33dpath, "i");
 MODULE_PARM(video_nr, "i");
 
+static struct pci_device_id zr36067_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ZORAN, PCI_DEVICE_ID_ZORAN_36057, 
+	  PCI_ANY_ID, PCI_ANY_ID,  0, 0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, zr36067_pci_tbl);
+
 /* Anybody who uses more than four? */
 #define BUZ_MAX 4
 

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-zr36120

diff -u -X /usr/dontdiff /linux.vanilla/drivers/media/video/zr36120.c /linux/drivers/media/video/zr36120.c
--- /linux.vanilla/drivers/media/video/zr36120.c	Wed Oct 17 11:26:25 2001
+++ /linux/drivers/media/video/zr36120.c	Sat Oct 20 08:44:39 2001
@@ -60,6 +60,13 @@
 static int video_nr = -1;
 static int vbi_nr = -1;
 
+static struct pci_device_id zr36120_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ZORAN,PCI_DEVICE_ID_ZORAN_36120,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, zr36120_pci_tbl);
+
 MODULE_AUTHOR("Pauline Middelink <middelin@polyware.nl>");
 MODULE_DESCRIPTION("Zoran ZR36120 based framegrabber");
 MODULE_LICENSE("GPL");

--ZPt4rx8FFjLCG7dd--

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE717lMBm4rlNOo3YgRAodWAJ9Rk4SfYmPTGZ4JZDjA9WB7PN9nHgCfViUp
xciOUDx3+wvAWSuPaFUcziA=
=9jMz
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
