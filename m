Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUI0F2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUI0F2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUI0F2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:28:54 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:5047 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266009AbUI0F2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:28:51 -0400
Date: Mon, 27 Sep 2004 15:28:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH] PPC64: fix CONFIG check typo
Message-Id: <20040927152836.624c503d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__27_Sep_2004_15_28_36_+1000_UY1mZqle7kz0LNzF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__27_Sep_2004_15_28_36_+1000_UY1mZqle7kz0LNzF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This should allow sys_rtas to work again on PPC64 pSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.9-rc2-bk12/arch/ppc64/kernel/misc.S 2.6.9-rc2-bk12.sfr.1/arch/ppc64/kernel/misc.S
--- 2.6.9-rc2-bk12/arch/ppc64/kernel/misc.S	2004-09-27 12:10:57.000000000 +1000
+++ 2.6.9-rc2-bk12.sfr.1/arch/ppc64/kernel/misc.S	2004-09-27 15:11:39.000000000 +1000
@@ -687,7 +687,7 @@
 	ld	r30,-16(r1)
 	blr
 
-#ifndef CONFIG_PPC_PSERIE	/* hack hack hack */
+#ifndef CONFIG_PPC_PSERIES	/* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
 #endif
 

--Signature=_Mon__27_Sep_2004_15_28_36_+1000_UY1mZqle7kz0LNzF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBV6UN4CJfqux9a+8RAqumAJ0RBZjn7tnIZuxGB/+xvIgU4RCG8wCeO4Jq
NX4wPb5ppDUNtaC1bmsiXLk=
=I8WI
-----END PGP SIGNATURE-----

--Signature=_Mon__27_Sep_2004_15_28_36_+1000_UY1mZqle7kz0LNzF--
