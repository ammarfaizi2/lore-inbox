Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUI0REK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUI0REK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUI0REK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:04:10 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:60680 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S266311AbUI0RDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:03:55 -0400
Subject: [PATCH] __VMALLOC_RESERVE export
From: Antony Suter <suterant@users.sourceforge.net>
To: List LKML <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fK25Nq18YKLoqGU8Y2go"
Message-Id: <1096304623.9430.8.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 03:03:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fK25Nq18YKLoqGU8Y2go
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

__VMALLOC_RESERVE itself is not exported but is used by something that
is. This patch is against 2.6.9-rc2-bk11

This is required by the nvidia binary driver 1.0.6111

(2 long lines are being wrapped by my emailer)

####

diff -u -pruaN linux-orig/arch/i386/mm/init.c
linux-new/arch/i386/mm/init.c
--- linux-orig/arch/i386/mm/init.c	2004-09-26 03:43:57.944613000 +1000
+++ linux-new/arch/i386/mm/init.c	2004-09-28 02:37:21.787922000 +1000
@@ -41,6 +41,7 @@
 #include <asm/sections.h>
=20
 unsigned int __VMALLOC_RESERVE =3D 128 << 20;
+EXPORT_SYMBOL(__VMALLOC_RESERVE);
=20
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "Facts do not cease to exist because they are ignored." - Aldous Huxley

--=-fK25Nq18YKLoqGU8Y2go
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWEfuZu6XKGV+xxoRAqdfAKCKRC49HBtKebAnGneJtxIvIwl0PwCgivc9
5chcXbjmLSefsJEF6Eshh+0=
=doLF
-----END PGP SIGNATURE-----

--=-fK25Nq18YKLoqGU8Y2go--

