Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWF1RAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWF1RAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWF1Q7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40452 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751437AbWF1Qy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:59 -0400
Date: Wed, 28 Jun 2006 18:54:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/printk.c: remove unused exports
Message-ID: <20060628165458.GU13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused EXPORT_SYMBOL's:
- console_printk
- is_console_locked
- __printk_ratelimit

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@Andrew:
If anyone is considered maintainer of this code, please tell me who it 
is so that I can send this patch to him instead of you.

This patch was already sent on:
- 22 Jun 2006
- 16 May 2006
- 1 May 2006
- 18 Apr 2006
- 11 Apr 2006

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

