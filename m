Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWDKDu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDKDu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDKDu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:50:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28676 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751218AbWDKDuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:50:55 -0400
Date: Tue, 11 Apr 2006 05:50:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/printk.c: remove unused exports
Message-ID: <20060411035054.GC3190@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused EXPORT_SYMBOL's:
- console_printk
- is_console_locked
- __printk_ratelimit

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/printk.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.17-rc1-mm2-full/kernel/printk.c.old	2006-04-11 01:20:32.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/kernel/printk.c	2006-04-11 01:21:54.000000000 +0200
@@ -52,8 +52,6 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
-EXPORT_SYMBOL(console_printk);
-
 /*
  * Low lever drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
@@ -728,7 +726,6 @@
 {
 	return console_locked;
 }
-EXPORT_SYMBOL(is_console_locked);
 
 /**
  * release_console_sem - unlock the console system
@@ -1033,7 +1030,6 @@
 	spin_unlock_irqrestore(&ratelimit_lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL(__printk_ratelimit);
 
 /* minimum time in jiffies between messages */
 int printk_ratelimit_jiffies = 5 * HZ;

