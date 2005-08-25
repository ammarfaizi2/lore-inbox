Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVHYF05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVHYF05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVHYFVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55499 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751534AbVHYFUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:20:54 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (3/22) static vs. extern in sun3ints.h
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADU-0005aa-2f@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-dmasound-extern/include/asm-m68k/sun3ints.h RC13-rc7-sun3ints/include/asm-m68k/sun3ints.h
--- RC13-rc7-dmasound-extern/include/asm-m68k/sun3ints.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-sun3ints/include/asm-m68k/sun3ints.h	2005-08-25 00:54:06.000000000 -0400
@@ -31,7 +31,6 @@
 		    );
 extern void sun3_init_IRQ (void);
 extern irqreturn_t (*sun3_default_handler[]) (int, void *, struct pt_regs *);
-extern irqreturn_t (*sun3_inthandler[]) (int, void *, struct pt_regs *);
 extern void sun3_free_irq (unsigned int irq, void *dev_id);
 extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
