Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUJ2Amr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUJ2Amr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbUJ2AlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:41:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263213AbUJ2AVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:21:17 -0400
Date: Fri, 29 Oct 2004 02:20:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ralf@linux-mips.org
Cc: linux-hams@vger.kernel.org, davem@davemloft.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] ax25_route.c: remove an unused function
Message-ID: <20041029002045.GO29142@stusta.de>
References: <20041028230032.GU3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028230032.GU3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from net/ax25/ax25_route.c


diffstat output:
 net/ax25/ax25_route.c |   16 ----------------
 1 files changed, 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/net/ax25/ax25_route.c.old	2004-10-28 23:50:25.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/ax25/ax25_route.c	2004-10-28 23:50:41.000000000 +0200
@@ -41,22 +41,6 @@
 
 static ax25_route *ax25_get_route(ax25_address *, struct net_device *);
 
-/*
- * small macro to drop non-digipeated digipeaters and reverse path
- */
-static inline void ax25_route_invert(ax25_digi *in, ax25_digi *out)
-{
-	int k;
-
-	for (k = 0; k < in->ndigi; k++)
-		if (!in->repeated[k])
-			break;
-
-	in->ndigi = k;
-
-	ax25_digi_invert(in, out);
-}
-
 void ax25_rt_device_down(struct net_device *dev)
 {
 	ax25_route *s, *t, *ax25_rt;
