Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWFKTtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFKTtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFKTtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:49:16 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:17637 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750885AbWFKTtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:49:16 -0400
Message-Id: <20060611194749.358928000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 11 Jun 2006 12:47:49 -0700
From: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] fix misspelled PREEMPT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing I noticed this .. It didn't effect me, but it
must effect someone .. The patch is untested ..

---
 arch/i386/kernel/io_apic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.16.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.16/arch/i386/kernel/io_apic.c
@@ -1297,7 +1297,7 @@ static void ioapic_register_intr(int irq
 
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
-#ifdef CONFIG_PREMMPT_HARDIRQS
+#ifdef CONFIG_PREEMPT_HARDIRQS
 		set_irq_chip_and_handler(idx, &ioapic_chip,
 					 handle_level_irq);
 #else
--
