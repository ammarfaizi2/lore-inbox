Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWFVKDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWFVKDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWFVKDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:03:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161045AbWFVKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:03:38 -0400
Date: Thu, 22 Jun 2006 12:03:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/printk.c: remove unused exports
Message-ID: <20060622100337.GE9111@stusta.de>
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

This patch was already sent on:
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

