Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030670AbWJKQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030670AbWJKQYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:24:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54204 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030670AbWJKQYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:24:36 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXgsl-0005YE-76@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:24:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m32r/kernel/setup_mappi.c |   16 ++++++++--------
 arch/m32r/kernel/smp.c         |    2 +-
 arch/m32r/kernel/traps.c       |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/m32r/kernel/setup_mappi.c b/arch/m32r/kernel/setup_mappi.c
index 67dbbdc..6b2d77d 100644
--- a/arch/m32r/kernel/setup_mappi.c
+++ b/arch/m32r/kernel/setup_mappi.c
@@ -86,7 +86,7 @@ #ifdef CONFIG_NE2000
 	/* INT0 : LAN controller (RTL8019AS) */
 	irq_desc[M32R_IRQ_INT0].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT0].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_INT0].action = 0;
+	irq_desc[M32R_IRQ_INT0].action = NULL;
 	irq_desc[M32R_IRQ_INT0].depth = 1;
 	icu_data[M32R_IRQ_INT0].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
 	disable_mappi_irq(M32R_IRQ_INT0);
@@ -95,7 +95,7 @@ #endif /* CONFIG_M32R_NE2000 */
 	/* MFT2 : system timer */
 	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_MFT2].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_MFT2].action = 0;
+	irq_desc[M32R_IRQ_MFT2].action = NULL;
 	irq_desc[M32R_IRQ_MFT2].depth = 1;
 	icu_data[M32R_IRQ_MFT2].icucr = M32R_ICUCR_IEN;
 	disable_mappi_irq(M32R_IRQ_MFT2);
@@ -104,7 +104,7 @@ #ifdef CONFIG_SERIAL_M32R_SIO
 	/* SIO0_R : uart receive data */
 	irq_desc[M32R_IRQ_SIO0_R].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_SIO0_R].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_SIO0_R].action = 0;
+	irq_desc[M32R_IRQ_SIO0_R].action = NULL;
 	irq_desc[M32R_IRQ_SIO0_R].depth = 1;
 	icu_data[M32R_IRQ_SIO0_R].icucr = 0;
 	disable_mappi_irq(M32R_IRQ_SIO0_R);
@@ -112,7 +112,7 @@ #ifdef CONFIG_SERIAL_M32R_SIO
 	/* SIO0_S : uart send data */
 	irq_desc[M32R_IRQ_SIO0_S].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_SIO0_S].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_SIO0_S].action = 0;
+	irq_desc[M32R_IRQ_SIO0_S].action = NULL;
 	irq_desc[M32R_IRQ_SIO0_S].depth = 1;
 	icu_data[M32R_IRQ_SIO0_S].icucr = 0;
 	disable_mappi_irq(M32R_IRQ_SIO0_S);
@@ -120,7 +120,7 @@ #ifdef CONFIG_SERIAL_M32R_SIO
 	/* SIO1_R : uart receive data */
 	irq_desc[M32R_IRQ_SIO1_R].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_SIO1_R].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_SIO1_R].action = 0;
+	irq_desc[M32R_IRQ_SIO1_R].action = NULL;
 	irq_desc[M32R_IRQ_SIO1_R].depth = 1;
 	icu_data[M32R_IRQ_SIO1_R].icucr = 0;
 	disable_mappi_irq(M32R_IRQ_SIO1_R);
@@ -128,7 +128,7 @@ #ifdef CONFIG_SERIAL_M32R_SIO
 	/* SIO1_S : uart send data */
 	irq_desc[M32R_IRQ_SIO1_S].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_SIO1_S].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_SIO1_S].action = 0;
+	irq_desc[M32R_IRQ_SIO1_S].action = NULL;
 	irq_desc[M32R_IRQ_SIO1_S].depth = 1;
 	icu_data[M32R_IRQ_SIO1_S].icucr = 0;
 	disable_mappi_irq(M32R_IRQ_SIO1_S);
@@ -138,7 +138,7 @@ #if defined(CONFIG_M32R_PCC)
 	/* INT1 : pccard0 interrupt */
 	irq_desc[M32R_IRQ_INT1].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT1].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_INT1].action = 0;
+	irq_desc[M32R_IRQ_INT1].action = NULL;
 	irq_desc[M32R_IRQ_INT1].depth = 1;
 	icu_data[M32R_IRQ_INT1].icucr = M32R_ICUCR_IEN | M32R_ICUCR_ISMOD00;
 	disable_mappi_irq(M32R_IRQ_INT1);
@@ -146,7 +146,7 @@ #if defined(CONFIG_M32R_PCC)
 	/* INT2 : pccard1 interrupt */
 	irq_desc[M32R_IRQ_INT2].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT2].chip = &mappi_irq_type;
-	irq_desc[M32R_IRQ_INT2].action = 0;
+	irq_desc[M32R_IRQ_INT2].action = NULL;
 	irq_desc[M32R_IRQ_INT2].depth = 1;
 	icu_data[M32R_IRQ_INT2].icucr = M32R_ICUCR_IEN | M32R_ICUCR_ISMOD00;
 	disable_mappi_irq(M32R_IRQ_INT2);
diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
index 722e21f..3601291 100644
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -231,7 +231,7 @@ void smp_flush_tlb_all(void)
 	local_irq_save(flags);
 	__flush_tlb_all();
 	local_irq_restore(flags);
-	smp_call_function(flush_tlb_all_ipi, 0, 1, 1);
+	smp_call_function(flush_tlb_all_ipi, NULL, 1, 1);
 	preempt_enable();
 }
 
diff --git a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
index c1daf2c..97e0b1c 100644
--- a/arch/m32r/kernel/traps.c
+++ b/arch/m32r/kernel/traps.c
@@ -268,7 +268,7 @@ static __inline__ void do_trap(int trapn
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	do_trap(trapnr, signr, 0, regs, error_code, NULL); \
+	do_trap(trapnr, signr, NULL, regs, error_code, NULL); \
 }
 
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-- 
1.4.2.GIT


