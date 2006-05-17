Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWEQAXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWEQAXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWEQAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:23:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26013 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932362AbWEQAS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:26 -0400
Date: Wed, 17 May 2006 02:18:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 39/50] genirq: ARM: Convert omap1 to generic irq handling
Message-ID: <20060517001814.GN12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/mach-omap1/board-osk.c |    2 +-
 arch/arm/mach-omap1/serial.c    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-genirq.q/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-omap1/board-osk.c
+++ linux-genirq.q/arch/arm/mach-omap1/board-osk.c
@@ -29,7 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
Index: linux-genirq.q/arch/arm/mach-omap1/serial.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-omap1/serial.c
+++ linux-genirq.q/arch/arm/mach-omap1/serial.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
