Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVCYBRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVCYBRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVCYBOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:14:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261372AbVCYBLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:15 -0500
Date: Fri, 25 Mar 2005 02:11:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2.6 patch] unexport console_unblank
Message-ID: <20050325011114.GU3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage of console_unblank in the 
kernel.

This patch was already ACK'ed by Alan Cox.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Mar 2005
- 3 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/printk.c.old	2005-03-03 17:04:18.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/printk.c	2005-03-03 17:04:24.000000000 +0100
@@ -757,7 +757,6 @@
 			c->unblank();
 	release_console_sem();
 }
-EXPORT_SYMBOL(console_unblank);
 
 /*
  * Return the console tty driver structure and its associated index

