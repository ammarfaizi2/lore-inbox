Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932932AbWJIP0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbWJIP0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWJIP0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:26:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62657 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932932AbWJIP0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:26:51 -0400
Date: Mon, 9 Oct 2006 16:26:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mv64630_pic NULL noise removal
Message-ID: <20061009152647.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ppc/syslib/mv64360_pic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
index 3f6d162..5104386 100644
--- a/arch/ppc/syslib/mv64360_pic.c
+++ b/arch/ppc/syslib/mv64360_pic.c
@@ -380,7 +380,7 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register CPU interface error intr handler */
 	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR + mv64360_irq_base,
-		mv64360_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, 0)))
+		mv64360_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, NULL)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
 
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
@@ -389,7 +389,7 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register internal SRAM error intr handler */
 	mv64x60_write(&bh, MV64360_SRAM_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR + mv64360_irq_base,
-		mv64360_sram_error_int_handler,IRQF_DISABLED,SRAM_INTR_STR, 0)))
+		mv64360_sram_error_int_handler,IRQF_DISABLED,SRAM_INTR_STR, NULL)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
 	/* Clear old errors and register PCI 0 error intr handler */
-- 
1.4.2.GIT
