Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945960AbWJSRA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945960AbWJSRA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946223AbWJSRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:00:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28427 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945960AbWJSRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:00:25 -0400
Date: Thu, 19 Oct 2006 19:00:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.19 patch] one more ARM IRQ fix
Message-ID: <20061019170021.GU3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes one more compile breakage caused by the post -rc1 IRQ 
changes.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/arch/arm/mach-lh7a40x/common.h.old	2006-10-19 17:32:38.000000000 +0200
+++ linux-2.6/arch/arm/mach-lh7a40x/common.h	2006-10-19 17:32:51.000000000 +0200
@@ -15,4 +15,4 @@
 extern void lh7a40x_clcd_init (void);
 extern void lh7a40x_init_board_irq (void);
 
-#define IRQ_DISPATCH(irq) desc_handle_irq((irq),(irq_desc + irq), regs)
+#define IRQ_DISPATCH(irq) desc_handle_irq((irq),(irq_desc + irq))

