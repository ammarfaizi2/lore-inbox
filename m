Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263213AbUJ2Amr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUJ2Amr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbUJ2Akt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:40:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43782 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263194AbUJ2AXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:23:13 -0400
Date: Fri, 29 Oct 2004 02:22:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/skfp/smt.c: remove an unused function
Message-ID: <20041029002235.GR29142@stusta.de>
References: <20041028230522.GX3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028230522.GX3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from drivers/net/skfp/smt.c


diffstat output:
 drivers/net/skfp/smt.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/net/skfp/smt.c.old	2004-10-28 23:18:46.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/skfp/smt.c	2004-10-28 23:19:00.000000000 +0200
@@ -135,13 +135,6 @@
 		*(short *)(&smc->mib.m[MAC0].fddiMACSMTAddress.a[4])) ;
 }
 
-static inline int is_zero(const struct fddi_addr *addr)
-{
-	return(*(short *)(&addr->a[0]) == 0 &&
-	       *(short *)(&addr->a[2]) == 0 &&
-	       *(short *)(&addr->a[4]) == 0 ) ;
-}
-
 static inline int is_broadcast(const struct fddi_addr *addr)
 {
 	return(*(u_short *)(&addr->a[0]) == 0xffff &&
