Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUKXAWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUKXAWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKXAUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:20:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14349 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261652AbUKXATu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:19:50 -0500
Date: Wed, 24 Nov 2004 01:19:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, ak@suse.de, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64 hardirq.h: no need to #ifdef CONFIG_X86
Message-ID: <20041124001941.GF2927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't see any reason for the #ifdef CONFIG_X86 introduced to the 
x86_64 hardirq.h as part of the generic irq subsystem changes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/include/asm-x86_64/hardirq.h.old	2004-11-23 23:18:20.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/asm-x86_64/hardirq.h	2004-11-23 23:18:35.000000000 +0100
@@ -21,7 +21,6 @@
  */
 static inline void ack_bad_irq(unsigned int irq)
 {
-#ifdef CONFIG_X86
 	printk("unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -34,6 +33,5 @@
 	 */
 	ack_APIC_irq();
 #endif
-#endif
 }
 #endif /* __ASM_HARDIRQ_H */

