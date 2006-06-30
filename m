Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWF3Lbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWF3Lbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWF3Lbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:31:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10760 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750904AbWF3Lbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:31:40 -0400
Date: Fri, 30 Jun 2006 13:31:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/printk.c: EXPORT_SYMBOL_UNUSED
Message-ID: <20060630113137.GJ19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks unused exports as EXPORT_SYMBOL_UNUSED.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/printk.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm4-full/kernel/printk.c.old	2006-06-30 02:30:47.000000000 +0200
+++ linux-2.6.17-mm4-full/kernel/printk.c	2006-06-30 02:32:07.000000000 +0200
@@ -53,7 +53,7 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
-EXPORT_SYMBOL(console_printk);
+EXPORT_UNUSED_SYMBOL(console_printk);  /*  June 2006  */
 
 /*
  * Low lever drivers may need that to know if they can schedule in
@@ -755,7 +755,7 @@
 {
 	return console_locked;
 }
-EXPORT_SYMBOL(is_console_locked);
+EXPORT_UNUSED_SYMBOL(is_console_locked);  /*  June 2006  */
 
 /**
  * release_console_sem - unlock the console system
@@ -1072,7 +1072,7 @@
 	spin_unlock_irqrestore(&ratelimit_lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL(__printk_ratelimit);
+EXPORT_UNUSED_SYMBOL(__printk_ratelimit);  /*  June 2006  */
 
 /* minimum time in jiffies between messages */
 int printk_ratelimit_jiffies = 5 * HZ;
