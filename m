Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTGJWST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbTGJWQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:16:30 -0400
Received: from relay.inway.cz ([212.24.128.3]:2962 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S269651AbTGJWQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:16:03 -0400
Date: Fri, 11 Jul 2003 00:29:12 +0200
From: Petr Sebor <petr@scssoft.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: [PATCH] via-agp.c - agp_try_unsupported typo
Message-ID: <20030710222912.GA6656@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

via-agp.c in 2.5.75 has the agp_try_unsupported test reverted

please apply,

thanks
-petr

diff -ur linux-2.5.75.old/drivers/char/agp/via-agp.c linux-2.5.75/drivers/char/agp/via-agp.c
--- linux-2.5.75.old/drivers/char/agp/via-agp.c	2003-07-11 00:17:44.000000000 +0200
+++ linux-2.5.75/drivers/char/agp/via-agp.c	2003-07-11 00:17:58.000000000 +0200
@@ -382,7 +382,7 @@
 		}
 	}
 
-	if (agp_try_unsupported) {
+	if (!agp_try_unsupported) {
 		printk(KERN_ERR PFX 
 		    "Unsupported VIA chipset (device id: %04x),"
 		    " you might want to try agp_try_unsupported=1.\n",
