Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSKUImM>; Thu, 21 Nov 2002 03:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSKUImM>; Thu, 21 Nov 2002 03:42:12 -0500
Received: from imap.laposte.net ([213.30.181.7]:37883 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S266425AbSKUImL>;
	Thu, 21 Nov 2002 03:42:11 -0500
Subject: Via KT400 agp support
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <Alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y15GtxBVNMMmNMwrtIuj"
Organization: 
Message-Id: <1037868507.5732.11.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 21 Nov 2002 09:48:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y15GtxBVNMMmNMwrtIuj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	This is a tiny patch to support agp on Via KT400 hardware. It basically
adds the KT400 pci ID and lists it as using Via generic setup routines.
This patch has been tested with all GL xscreensaver I could find, and
been reviewed by Dave Jones (full patch history at
http://bugzilla.kernel.org/show_bug.cgi?id=3D14).

	Please apply.

diff -uNr linux-2.5.47-ac6.orig/drivers/char/agp/agp.c
linux-2.5.47-ac6/drivers/char/agp/agp.c
--- linux-2.5.47-ac6.orig/drivers/char/agp/agp.c	2002-11-11 04:28:26.000000=
000 +0100
+++ linux-2.5.47-ac6/drivers/char/agp/agp.c	2002-11-20 22:07:32.000000000 +=
0100
@@ -1150,6 +1150,14 @@
 		.chipset_setup	=3D via_generic_setup
 	},
 	{
+		.device_id	=3D PCI_DEVICE_ID_VIA_8377_0,
+		.vendor_id	=3D PCI_VENDOR_ID_VIA,
+		.chipset	=3D VIA_APOLLO_KT400,
+		.vendor_name	=3D "Via",
+		.chipset_name	=3D "Apollo Pro KT400",
+		.chipset_setup	=3D via_generic_setup
+	},
+	{
 		.device_id	=3D PCI_DEVICE_ID_VIA_8653_0,
 		.vendor_id	=3D PCI_VENDOR_ID_VIA,
 		.chipset	=3D VIA_APOLLO_PRO,
diff -uNr linux-2.5.47-ac6.orig/include/linux/agp_backend.h linux-2.5.47-ac=
6/include/linux/agp_backend.h
--- linux-2.5.47-ac6.orig/include/linux/agp_backend.h	2002-11-11 04:28:29.0=
00000000 +0100
+++ linux-2.5.47-ac6/include/linux/agp_backend.h	2002-11-20 22:49:35.000000=
000 +0100
@@ -61,6 +61,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_KT400,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -uNr linux-2.5.47-ac6.orig/include/linux/pci_ids.h linux-2.5.47-ac6/in=
clude/linux/pci_ids.h
--- linux-2.5.47-ac6.orig/include/linux/pci_ids.h	2002-11-20 21:46:32.00000=
0000 +0100
+++ linux-2.5.47-ac6/include/linux/pci_ids.h	2002-11-20 22:28:37.000000000 =
+0100
@@ -1039,6 +1039,7 @@
 #define PCI_DEVICE_ID_VIA_8361		0x3112=20
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_8235		0x3177
+#define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235


--=20
Nicolas Mailhot <Nicolas.Mailhot@laposte.net>

--=-y15GtxBVNMMmNMwrtIuj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA93J3bI2bVKDsp8g0RArwwAJ4hmNBMGCVp8T1NEZqGuF6wuUwmEACgv1rE
4lYqQK+BTXQUWnB567476EY=
=1fHx
-----END PGP SIGNATURE-----

--=-y15GtxBVNMMmNMwrtIuj--

