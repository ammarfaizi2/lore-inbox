Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSD1PBJ>; Sun, 28 Apr 2002 11:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSD1PBI>; Sun, 28 Apr 2002 11:01:08 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:39263 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310917AbSD1PBH>;
	Sun, 28 Apr 2002 11:01:07 -0400
Date: Sun, 28 Apr 2002 16:59:38 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [2.5.10] BTTV .text.exit link fix with newer binutils
Message-Id: <20020428165938.302e62fd.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="e(AGpp4J:=.BtE'm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--e(AGpp4J:=.BtE'm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
here's a simple patch to allow the bttv driver to be build with newer binutils...

Bye

--- linux-2.5.10/drivers/media/video/bttv-driver.c~     Sun Apr 28 16:57:00 2002
+++ linux-2.5.10/drivers/media/video/bttv-driver.c      Sun Apr 28 16:57:15 2002
@@ -3394,7 +3394,7 @@
         name:     "bttv",
         id_table: bttv_pci_tbl,
         probe:    bttv_probe,
-        remove:   bttv_remove,
+        remove:   __devexit_p(bttv_remove),
 };
 
 static int bttv_init_module(void)

--e(AGpp4J:=.BtE'm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8zA5de9FFpVVDScsRAvQ6AJ9gisXcRBc6/XcFbt9Uid1rIvZ1DgCgzAck
dRpOgfhTGDp0eH6HNlHa0HM=
=N2+q
-----END PGP SIGNATURE-----

--e(AGpp4J:=.BtE'm--

