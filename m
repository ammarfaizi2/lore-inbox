Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267838AbUHERul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267838AbUHERul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHERts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:49:48 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:34197 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267846AbUHERsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:48:21 -0400
Subject: [PATCH] Fix x86_64 build of mmconfig.c
From: Tom Duffy <tduffy@sun.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZHUMXLPDnBx2uveWhF9b"
Organization: Sun Microsystems
Date: Thu, 05 Aug 2004 10:48:16 -0700
Message-Id: <1091728096.10131.16.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZHUMXLPDnBx2uveWhF9b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Signed-by: Tom Duffy <tduffy@sun.com>

  gcc -Wp,-MD,arch/x86_64/pci/.mmconfig.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude -Iinclude2 -I/build1/tduffy/openib-work/linux-2.6.8-=
rc3-openib/include -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch=
/x86_64/pci -Iarch/x86_64/pci -Wall -Wstrict-prototypes -Wno-trigraphs -fno=
-strict-aliasing -fno-common -mno-red-zone -mcmodel=3Dkernel -pipe -fno-reo=
rder-blocks -Wno-sign-compare -fno-asynchronous-unwind-tables -O2 -fomit-fr=
ame-pointer -Wdeclaration-after-statement -I/build1/tduffy/openib-work/linu=
x-2.6.8-rc3-openib/ -I arch/i386/pci  -DKBUILD_BASENAME=3Dmmconfig -DKBUILD=
_MODNAME=3Dmmconfig -c -o arch/x86_64/pci/mmconfig.o /build1/tduffy/openib-=
work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.c
/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.=
c:10:17: pci.h: No such file or directory

--- arch/x86_64/pci/Makefile.orig	2004-08-05 09:54:24.932007000 -0700
+++ arch/x86_64/pci/Makefile	2004-08-05 09:53:53.171006000 -0700
@@ -3,7 +3,7 @@
 #
 # Reuse the i386 PCI subsystem
 #
-CFLAGS +=3D -I arch/i386/pci
+CFLAGS +=3D -Iarch/i386/pci
=20
 obj-y		:=3D i386.o
 obj-$(CONFIG_PCI_DIRECT)+=3D direct.o


--=-ZHUMXLPDnBx2uveWhF9b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEnLgdY502zjzwbwRAm4zAKCRkb+b76H6hxOnRwDK3lxReC18XQCgkLoj
xb3xJ4gbUUovek1DIrnIBsE=
=nUDf
-----END PGP SIGNATURE-----

--=-ZHUMXLPDnBx2uveWhF9b--
