Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUFKNDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUFKNDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUFKNDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:03:09 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:7418 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263885AbUFKNDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:03:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] s390: fix kmem_bufctl_t definition
Date: Fri, 11 Jun 2004 15:02:28 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_k1ayA6b/gWU8PtM";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111502.28599.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_k1ayA6b/gWU8PtM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On s390, kmem_bufctl_t was added inside of an #ifdef, breaking
64 bit builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D include/asm-s390/types.h 1.8 vs edited =3D=3D=3D=3D=3D
=2D-- 1.8/include/asm-s390/types.h	Wed May 19 18:02:49 2004
+++ edited/include/asm-s390/types.h	Sat Jun  5 18:02:16 2004
@@ -79,6 +79,8 @@
=20
 typedef u32 dma_addr_t;
=20
+typedef unsigned int kmem_bufctl_t;
+
 #ifndef __s390x__
 typedef union {
 	unsigned long long pair;
@@ -92,8 +94,6 @@
 typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif
=2D
=2Dtypedef unsigned int kmem_bufctl_t;
=20
 #endif /* ! __s390x__   */
 #endif /* __ASSEMBLY__  */

--Boundary-02=_k1ayA6b/gWU8PtM
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAya1k5t5GS2LDRf4RAtEiAJ415jlbS6Yy+W+clsjsXCyQGMwuuQCfeclh
NtexlSFIhtjVMWsTGaI8CRI=
=H3T+
-----END PGP SIGNATURE-----

--Boundary-02=_k1ayA6b/gWU8PtM--
