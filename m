Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWEQAZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWEQAZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWEQASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:18:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17821 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932358AbWEQASA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:00 -0400
Date: Wed, 17 May 2006 02:17:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 32/50] genirq: ARM: Convert footbridge to generic irq handling
Message-ID: <20060517001743.GG12877@elte.hu>
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
 arch/arm/mach-footbridge/dc21285-timer.c |    1 +
 arch/arm/mach-footbridge/isa-timer.c     |    1 +
 2 files changed, 2 insertions(+)

Index: linux-genirq.q/arch/arm/mach-footbridge/dc21285-timer.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-footbridge/dc21285-timer.c
+++ linux-genirq.q/arch/arm/mach-footbridge/dc21285-timer.c
@@ -6,6 +6,7 @@
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/irq.h>
 
Index: linux-genirq.q/arch/arm/mach-footbridge/isa-timer.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-footbridge/isa-timer.c
+++ linux-genirq.q/arch/arm/mach-footbridge/isa-timer.c
@@ -6,6 +6,7 @@
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
