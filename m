Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752338AbWCKDmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbWCKDmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbWCKDmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:42:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49157 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752338AbWCKDmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:42:54 -0500
Date: Sat, 11 Mar 2006 04:42:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tim@cyberelk.net
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/paride/pd.c: fix an off-by-one
Message-ID: <20060311034253.GI21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this off-by-one error.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c.old	2006-03-11 02:07:21.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c	2006-03-11 02:07:50.000000000 +0100
@@ -275,7 +275,7 @@
 	int i;
 
 	printk("%s: %s: status = 0x%x =", disk->name, msg, status);
-	for (i = 0; i < 18; i++)
+	for (i = 0; i < 17; i++)
 		if (status & (1 << i))
 			printk(" %s", pd_errs[i]);
 	printk("\n");

