Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKZWAX>; Tue, 26 Nov 2002 17:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSKZWAX>; Tue, 26 Nov 2002 17:00:23 -0500
Received: from imap.laposte.net ([213.30.181.7]:52102 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S261317AbSKZWAV>;
	Tue, 26 Nov 2002 17:00:21 -0500
Subject: [PATCH] [2.5] Via KT400 agp support II (cosmetic)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <Alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1037869042.5728.16.camel@ulysse.olympe.o2t>
References: <1037869042.5728.16.camel@ulysse.olympe.o2t>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mysIAGfa0RYBJX9O4fxb"
Organization: 
Message-Id: <1038348412.1075.7.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 26 Nov 2002 23:06:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mysIAGfa0RYBJX9O4fxb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	This little patch adds some cosmetic changes to the one that went in
mainline (found when I did the 2.4 port) :=20
- corrects the drm startup message so it doesn't print unknown chip for
the kt400
- adds a bunch of ids to the pci database (started with the kt400, ended
with all unreferenced chips on my box)

	This is purely cosmetic ; the necessary part to get the kt400 was in
the first patch. Anyway this is nice to have.

	Please apply,

diff -uNr linux-2.5.49-bk1.orig/drivers/char/drm/drm_agpsupport.h
linux-2.5.49-bk1/drivers/char/drm/drm_agpsupport.h
--- linux-2.5.49-bk1.orig/drivers/char/drm/drm_agpsupport.h	2002-11-22
22:40:12.000000000 +0100
+++ linux-2.5.49-bk1/drivers/char/drm/drm_agpsupport.h	2002-11-26
22:27:52.000000000 +0100
@@ -286,9 +286,11 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset =3D "VIA Apollo KT133";
 			break;
-
+		case VIA_APOLLO_KT400:  head->chipset =3D "VIA Apollo KT400";
+			break;
 		case VIA_APOLLO_PRO: 	head->chipset =3D "VIA Apollo Pro";
 			break;
+
 		case SIS_GENERIC:	head->chipset =3D "SiS";           break;
 		case AMD_GENERIC:	head->chipset =3D "AMD";           break;
 		case AMD_IRONGATE:	head->chipset =3D "AMD Irongate";  break;
diff -uNr linux-2.5.49-bk1.orig/drivers/pci/pci.ids
linux-2.5.49-bk1/drivers/pci/pci.ids
--- linux-2.5.49-bk1.orig/drivers/pci/pci.ids	2002-11-26
22:15:27.000000000 +0100
+++ linux-2.5.49-bk1/drivers/pci/pci.ids	2002-11-26 22:25:45.000000000
+0100
@@ -582,6 +582,7 @@
 	6003  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
 		1013 4280  Crystal SoundFusion PCI Audio Accelerator
 		1681 0050  Hercules Game Theater XP
+		1681 a011  Hercules Fortissimo III 7.1
 	6004  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
 	6005  Crystal CS4281 PCI Audio
 		1013 4281  Crystal CS4281 PCI Audio
@@ -2687,6 +2688,7 @@
 	0505  VT82C505
 	0561  VT82C561
 	0571  VT82C586B PIPC Bus Master IDE
+		1458 5002 GA-7VAX Mainboard
 	0576  VT82C576 3V [Apollo Master]
 	0585  VT82C585VP [Apollo VP1/VPX]
 	0586  VT82C586/A/B PCI-to-ISA [Apollo VP]
@@ -2735,6 +2737,7 @@
 		1462 3091  MS-6309 Onboard Audio
 		15dd 7609  Onboard Audio
 	3059  VT8233 AC97 Audio Controller
+		1458 a002  GA-7VAX Onboard Audio (Realtek ALC650)
 	3065  VT6102 [Rhine-II]
 		1186 1400  DFE-530TX rev A
 		1186 1401  DFE-530TX rev B
@@ -2748,6 +2751,7 @@
 	3102  VT8662 Host Bridge
 	3103  VT8615 Host Bridge
 	3104  USB 2.0
+		1458 5004  GA-7VAX Mainboard
 	3109  VT8233C PCI to ISA Bridge
 	3112  VT8361 [KLE133] Host Bridge
 	3128  VT8753 [P4X266 AGP]
@@ -2756,6 +2760,9 @@
 	3148  P4M266 Host Bridge
 	3156  P/KN266 Host Bridge
 	3177  VT8233A ISA Bridge
+		1458 5001 GA-7VAX Mainboard
+	3189  VT8377 [KT400 AGP] Host Bridge
+		1458 5000 GA-7VAX Mainboard
 	5030  VT82C596 ACPI [Apollo PRO]
 	6100  VT85C100A [Rhine II]
 	8231  VT8231 [PCI-to-ISA Bridge]
@@ -2776,6 +2783,7 @@
 	b102  VT8362 AGP Bridge
 	b103  VT8615 AGP Bridge
 	b112  VT8361 [KLE133] AGP Bridge
+	b168  VT8235 PCI Bridge
 1107  Stratus Computers
 	0576  VIA VT82C570MV [Apollo] (Wrong vendor ID!)
 1108  Proteon, Inc.

--=20
Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>

--=-mysIAGfa0RYBJX9O4fxb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA94/B8I2bVKDsp8g0RAlQ1AKDFhXM/KOdHM4fgGwilVgOr32fwugCgktVJ
8639OAwi8ZmFzGD22x8OFkk=
=Enx7
-----END PGP SIGNATURE-----

--=-mysIAGfa0RYBJX9O4fxb--

