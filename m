Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTEaPLa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTEaPLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:11:30 -0400
Received: from [210.14.16.132] ([210.14.16.132]:5380 "HELO freeman.localdomain")
	by vger.kernel.org with SMTP id S264424AbTEaPL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:11:27 -0400
Date: Sat, 31 May 2003 23:31:40 +0800
From: "Nimrod A. Abing" <abing@redberger.com>
To: linux-kernel@vger.kernel.org
Subject: agpgart for P4M266
Message-ID: <20030531153140.GA10719@redberger.com>
Reply-To: "Nimrod A. Abing" <abing@redberger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: Kulitpuro Heavy Industries Ltd
X-Operating-System: RUDE-LFS Version 1.0 (based on LFS-4.0)
X-Crypto: gpg (GnuPG) 1.2.0 http://www.gnupg.org/
X-PGP-Key: http://www.redberger.com/~abing/abing_at_redberger_dot_com.asc
X-PGP-Fingerprint: 32FD 348C 3B69 92D0 6D4A  0074 B879 2FEF D77A EC4C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Below is a patch to 2.4.21-rc6 that adds agpgart support for Via Apollo=20
P4M266. This chipset is used by my EliteGroup P4VMM2 mainboard. It works
fine on my machine, e.g. I am able to run Quake III Arena and it runs more
smoothly after the patch was applied. I was only able to test on my
machine which has an NVIDIA TNT2 based gfx card (using drivers from
NVIDIA).

Please CC me when replying as I am currently not subscribed to the list.
--=20
_nimrod_a_abing_

PGP Public Key here:

http://www.redberger.com/~abing/abing_at_redberger_dot_com.asc

Key expires 2003-11-06

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.21-rc6.patch_P4M266"

diff -Naur linux-2.4.21-rc6/drivers/char/agp/agpgart_be.c linux-2.4.21-rc6_abing/drivers/char/agp/agpgart_be.c
--- linux-2.4.21-rc6/drivers/char/agp/agpgart_be.c	2003-05-31 22:31:24.000000000 +0800
+++ linux-2.4.21-rc6_abing/drivers/char/agp/agpgart_be.c	2003-05-31 21:30:08.000000000 +0800
@@ -4688,6 +4688,12 @@
 		"Via",
 		"Apollo Pro KT400",
 		via_generic_setup },
+	{ PCI_DEVICE_ID_VIA_P4M266,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_P4M266,
+		"Via",
+		"Apollo P4M266",
+		via_generic_setup },
 	{ PCI_DEVICE_ID_VIA_P4X333,
 		PCI_VENDOR_ID_VIA,
 		VIA_APOLLO_P4X400,
diff -Naur linux-2.4.21-rc6/include/linux/agp_backend.h linux-2.4.21-rc6_abing/include/linux/agp_backend.h
--- linux-2.4.21-rc6/include/linux/agp_backend.h	2003-05-31 22:31:51.000000000 +0800
+++ linux-2.4.21-rc6_abing/include/linux/agp_backend.h	2003-05-31 21:29:21.000000000 +0800
@@ -60,6 +60,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_P4M266,
 	VIA_APOLLO_P4X400,
 	VIA_APOLLO_KT400,
 	SIS_GENERIC,
diff -Naur linux-2.4.21-rc6/include/linux/pci_ids.h linux-2.4.21-rc6_abing/include/linux/pci_ids.h
--- linux-2.4.21-rc6/include/linux/pci_ids.h	2003-05-31 22:31:54.000000000 +0800
+++ linux-2.4.21-rc6_abing/include/linux/pci_ids.h	2003-05-31 21:29:37.000000000 +0800
@@ -1027,6 +1027,7 @@
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8375     0x3116
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_P4M266	0x3148
 #define PCI_DEVICE_ID_VIA_P4X333   0x3168
 #define PCI_DEVICE_ID_VIA_8235        0x3177
 #define PCI_DEVICE_ID_VIA_8377_0  0x3189

--O5XBE6gyVG5Rl6Rj--

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+2MrcuHkv79d67EwRAgiDAJ0W61XyGnu9RzSov/zwMIAdwq8jBQCfV2OA
xGCK5H9FdE480YZtjhwiZe0=
=w1k4
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
