Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVCGJnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVCGJnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVCGJnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:43:42 -0500
Received: from ozlabs.org ([203.10.76.45]:14482 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261724AbVCGJnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:43:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.8807.314129.751945@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 20:44:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: tglx@linutronix.de, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: C99 initializers for hw_interrupt_type
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Thomas Gleixner <tglx@linutronix.de>.

Convert the initializers of hw_interrupt_type structures to C99
initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN 2.6.11-rc5.orig/arch/ppc64/kernel/i8259.c 2.6.11-rc5/arch/ppc64/kernel/i8259.c
--- 2.6.11-rc5.orig/arch/ppc64/kernel/i8259.c	2005-01-24 12:25:36.000000000 +0100
+++ 2.6.11-rc5/arch/ppc64/kernel/i8259.c	2005-02-26 20:54:19.000000000 +0100
@@ -131,14 +131,11 @@
 }
 
 struct hw_interrupt_type i8259_pic = {
-        " i8259    ",
-        NULL,
-        NULL,
-        i8259_unmask_irq,
-        i8259_mask_irq,
-        i8259_mask_and_ack_irq,
-        i8259_end_irq,
-        NULL
+	.typename = " i8259    ",
+	.enable = i8259_unmask_irq,
+	.disable = i8259_mask_irq,
+	.ack = i8259_mask_and_ack_irq,
+	.end = i8259_end_irq,
 };
 
 void __init i8259_init(int offset)
