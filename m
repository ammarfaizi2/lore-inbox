Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUK1XED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUK1XED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUK1XED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:04:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20753 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261593AbUK1XD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:03:59 -0500
Date: Mon, 29 Nov 2004 00:03:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 cyrix.c: make a function static
Message-ID: <20041128230358.GJ4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cyrix.c.old	2004-11-28 21:04:34.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cyrix.c	2004-11-28 21:04:42.000000000 +0100
@@ -12,7 +12,7 @@
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
 	unsigned long flags;

