Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbUJ1XMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbUJ1XMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUJ1XIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:08:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52241 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262893AbUJ1XFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:05:54 -0400
Date: Fri, 29 Oct 2004 01:05:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/skfp/smt.c: remove an unused function
Message-ID: <20041028230522.GX3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/net/skfp/smt.c


diffstat output:
 drivers/net/skfp/smt.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/net/skfp/smt.c.old	2004-10-28 23:18:46.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/skfp/smt.c	2004-10-28 23:19:00.000000000 +0200
@@ -135,13 +135,6 @@
 		*(short *)(&smc->mib.m[MAC0].fddiMACSMTAddress.a[4])) ;
 }
 
- -static inline int is_zero(const struct fddi_addr *addr)
- -{
- -	return(*(short *)(&addr->a[0]) == 0 &&
- -	       *(short *)(&addr->a[2]) == 0 &&
- -	       *(short *)(&addr->a[4]) == 0 ) ;
- -}
- -
 static inline int is_broadcast(const struct fddi_addr *addr)
 {
 	return(*(u_short *)(&addr->a[0]) == 0xffff &&

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXsymfzqmE8StAARAhK0AJ40SOGXWcEsTBTsn5VT9QzBqogwxwCghiME
UKKBxu3t4KJqGbbsbcOLx2Q=
=Dxpv
-----END PGP SIGNATURE-----
