Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDQNvm>; Tue, 17 Apr 2001 09:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRDQNvc>; Tue, 17 Apr 2001 09:51:32 -0400
Received: from orbita.don.sitek.net ([213.24.25.98]:37390 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S132555AbRDQNvW>; Tue, 17 Apr 2001 09:51:22 -0400
Date: Tue, 17 Apr 2001 17:51:07 +0400
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/at1700.c: missing __init and __initdata
Message-ID: <20010417175107.A20389@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch (2.4.3-ac7) adds some missing __init and __initdata=20
into at1700.c NIC driver.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-at1700
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/drivers/net/at1700.c linux/drivers/net/at1700.c
--- linux.vanilla/drivers/net/at1700.c	Tue Apr 17 10:54:07 2001
+++ linux/drivers/net/at1700.c	Tue Apr 17 11:17:37 2001
@@ -70,7 +70,7 @@
=20
 /* These unusual address orders are used to verify the CONFIG register. */
=20
-static int fmv18x_probe_list[] =3D {
+static int fmv18x_probe_list[] __initdata =3D {
 	0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x300, 0x340, 0
 };
=20
@@ -78,7 +78,7 @@
  *	ISA
  */
=20
-static int at1700_probe_list[] =3D {
+static int at1700_probe_list[] __initdata =3D {
 	0x260, 0x280, 0x2a0, 0x240, 0x340, 0x320, 0x380, 0x300, 0
 };
=20
@@ -86,15 +86,15 @@
  *	MCA
  */
 #ifdef CONFIG_MCA=09
-static int at1700_ioaddr_pattern[] =3D {
+static int at1700_ioaddr_pattern[] __initdata =3D {
 	0x00, 0x04, 0x01, 0x05, 0x02, 0x06, 0x03, 0x07
 };
=20
-static int at1700_mca_probe_list[] =3D {
+static int at1700_mca_probe_list[] __initdata =3D {
 	0x400, 0x1400, 0x2400, 0x3400, 0x4400, 0x5400, 0x6400, 0x7400, 0
 };
=20
-static int at1700_irq_pattern[] =3D {
+static int at1700_irq_pattern[] __initdata =3D {
 	0x00, 0x00, 0x00, 0x30, 0x70, 0xb0, 0x00, 0x00,
 	0x00, 0xf0, 0x34, 0x74, 0xb4, 0x00, 0x00, 0xf4, 0x00
 };
@@ -175,10 +175,10 @@
 };
 /* rEnE : maybe there are others I don't know off... */
=20
-static struct at1720_mca_adapters_struct at1720_mca_adapters[] =3D {
+static struct at1720_mca_adapters_struct at1720_mca_adapters[] __initdata =
=3D {
 	{ "Allied Telesys AT1720AT",	0x6410 },
 	{ "Allied Telesys AT1720BT", 	0x6413 },
-	{ "Allied Telesys AT1720T",		0x6416 },
+	{ "Allied Telesys AT1720T",	0x6416 },
 	{ NULL, 0 },
 };
 #endif
@@ -470,7 +470,7 @@
 #define EE_READ_CMD		(6 << 6)
 #define EE_ERASE_CMD	(7 << 6)
=20
-static int read_eeprom(int ioaddr, int location)
+static int __init read_eeprom(int ioaddr, int location)
 {
 	int i;
 	unsigned short retval =3D 0;

--a8Wt8u1KmwUX3Y2C--

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63EpLBm4rlNOo3YgRAtxhAJ0bYrkrxvAdlC3EDhRKAZUJzzeAzgCffS19
cr0uVAioyfiCzMWdcy9G1xE=
=X1qz
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
