Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVBKS7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVBKS7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVBKS41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:56:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262309AbVBKSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:31 -0500
Date: Fri, 11 Feb 2005 19:54:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 io_apic.c: make two variables static
Message-ID: <20050211185426.GE3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Jan 2005

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/io_apic.c.old	2005-01-16 04:38:36.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/io_apic.c	2005-01-16 04:38:57.000000000 +0100
@@ -264,7 +264,7 @@
 static int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
 static int physical_balance = 0;
 
-struct irq_cpu_info {
+static struct irq_cpu_info {
 	unsigned long * last_irq;
 	unsigned long * irq_delta;
 	unsigned long irq;
@@ -286,7 +286,7 @@
 #define BALANCED_IRQ_MORE_DELTA		(HZ/10)
 #define BALANCED_IRQ_LESS_DELTA		(HZ)
 
-long balanced_irq_interval = MAX_BALANCED_IRQ_INTERVAL;
+static long balanced_irq_interval = MAX_BALANCED_IRQ_INTERVAL;
 
 static unsigned long move(int curr_cpu, cpumask_t allowed_mask,
 			unsigned long now, int direction)

