Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTKZR1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTKZR1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:27:22 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:14854 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S264262AbTKZR1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:27:16 -0500
Date: Wed, 26 Nov 2003 17:36:28 +0100
From: David Jez <dave.jez@seznam.cz>
To: davej@redhat.com
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [patch] agpgart via KT400 cleanup & KM400 support
Message-ID: <20031126163628.GA13010@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi,

  this patch cleans double KT400 definition and adds support for KM400. Ple=
ase
aply.

  Regards,
--=20
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=3D[ ~EOF ]=3D------------------------------------

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="agpgart-km400.diff"
Content-Transfer-Encoding: quoted-printable


 linux/drivers/char/agp/agp.h        |    3 +++
 linux/drivers/char/agp/agpgart_be.c |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff -urN linux.orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux.orig/drivers/char/agp/agp.h	Mon Nov 24 16:19:35 2003
+++ linux/drivers/char/agp/agp.h	Mon Nov 24 16:48:48 2003
@@ -178,6 +178,9 @@
 #ifndef PCI_DEVICE_ID_VIA_8385_0
 #define PCI_DEVICE_ID_VIA_8385_0	0x3188
 #endif=20
+#ifndef PCI_DEVICE_ID_VIA_8378_0
+#define PCI_DEVICE_ID_VIA_8378_0      0x3205
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_0
 #define PCI_DEVICE_ID_INTEL_810_0       0x7120
 #endif
diff -urN linux.orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/a=
gpgart_be.c
--- linux.orig/drivers/char/agp/agpgart_be.c	Mon Nov 24 16:20:07 2003
+++ linux/drivers/char/agp/agpgart_be.c	Mon Nov 24 16:49:39 2003
@@ -6334,11 +6334,11 @@
 		"Via",
 		"Apollo Pro KT400",
 		via_generic_setup },
-        { PCI_DEVICE_ID_VIA_8377_0,
+        { PCI_DEVICE_ID_VIA_8378_0,
 		PCI_VENDOR_ID_VIA,
 		VIA_APOLLO_KT400,
 		"Via",
-		"Apollo Pro KT400",
+		"Apollo Pro KM400",
 		via_generic_setup },
         { PCI_DEVICE_ID_VIA_CLE266,
 		PCI_VENDOR_ID_VIA,

--ikeVEW9yuYc//A+q--

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/xNaIr2Hs6iMo1GgRAqVyAJ4u6KiWklKhtQxsKqe5q2jiqmxYkwCePVul
KuAq3HlvQWsq5D8uK93haz4=
=jbDh
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
