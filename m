Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVCIBuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVCIBuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVCIBpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:45:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42509 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262297AbVCIBoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:44:30 -0500
Date: Wed, 9 Mar 2005 02:44:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2.6 patch] unexport console_unblank
Message-ID: <20050309014415.GH3146@stusta.de>
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

