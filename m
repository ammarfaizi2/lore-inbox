Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVADWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVADWtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVADWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:34:42 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:54923 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262392AbVADWdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:33:33 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104223352.21889.12240.53908@localhost.localdomain>
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Subject: [PATCH 4/4] mips: remove cli()/sti() in arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 16:33:32 -0600
Date: Tue, 4 Jan 2005 16:33:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c linux-2.6.10-mm1/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
--- linux-2.6.10-mm1-original/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.10-mm1/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2005-01-04 16:55:45.501173508 -0500
@@ -727,7 +727,7 @@
 	reg_wr08(RBTX4927_SW_RESET_DO, RBTX4927_SW_RESET_DO_SET);
 
 	/* do something passive while waiting for reset */
-	cli();
+	local_irq_disable();
 	while (1)
 		asm_wait();
 
@@ -738,7 +738,7 @@
 void toshiba_rbtx4927_halt(void)
 {
 	printk(KERN_NOTICE "System Halted\n");
-	cli();
+	local_irq_disable();
 	while (1) {
 		asm_wait();
 	}
