Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTDGXY6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTDGXYb (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:24:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4737
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263866AbTDGXNM (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:13:12 -0400
Date: Tue, 8 Apr 2003 01:32:06 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080032.h380W6Hf009194@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: and voyager
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-voyager/irq_vectors.h linux-2.5.67-ac1/include/asm-i386/mach-voyager/irq_vectors.h
--- linux-2.5.67/include/asm-i386/mach-voyager/irq_vectors.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-i386/mach-voyager/irq_vectors.h	2003-02-14 23:02:30.000000000 +0000
@@ -57,6 +57,12 @@
 
 #define NR_IRQS 224
 
+#define FPU_IRQ				13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #ifndef __ASSEMBLY__
 extern asmlinkage void vic_cpi_interrupt(void);
 extern asmlinkage void vic_sys_interrupt(void);
