Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRFYGxo>; Mon, 25 Jun 2001 02:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264424AbRFYGxe>; Mon, 25 Jun 2001 02:53:34 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:25605 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S263703AbRFYGxa>;
	Mon, 25 Jun 2001 02:53:30 -0400
Date: Mon, 25 Jun 2001 10:53:26 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i810-tco bugfix
Message-ID: <20010625105326.A1792@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
User-Agent: Mutt/1.0.1i
X-Uptime: 10:19am  up 25 days, 18:02,  2 users,  load average: 0.08, 0.06, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this small patch fixes stupid bug in i810 TCO watchdog driver.
This bug was created by me (ugh) along with i815/i8[2456]0 support.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i810tco-bugfix
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/char/i810-tco.c /linux/dri=
vers/char/i810-tco.c
--- /linux.vanilla/drivers/char/i810-tco.c	Mon Jun 25 23:45:39 2001
+++ /linux/drivers/char/i810-tco.c	Tue Jun 26 00:19:14 2001
@@ -261,12 +261,11 @@
 	 */
=20
 	pci_for_each_dev(dev) {
-		i810tco_pci =3D pci_match_device(i810tco_pci_tbl, dev);
-		if (i810tco_pci !=3D NULL)
+		if (pci_match_device(i810tco_pci_tbl, dev))
 			break;
 	}
=20
-	if (i810tco_pci) {
+	if ((i810tco_pci =3D dev)) {
 		/*
 		 *      Find the ACPI base I/O address which is the base
 		 *      for the TCO registers (TCOBASE=3DACPIBASE + 0x60)

--ibTvN161/egqYuK8--

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Nt/mBm4rlNOo3YgRAiYfAJ9mSc84Ho7esLbxmWkgBznIcgtETQCghiq/
/cTs+g5PFtV8KX0+SruMqxY=
=C0cd
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
