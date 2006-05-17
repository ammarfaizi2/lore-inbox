Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWEQAY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWEQAY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEQAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:24:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16081 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932367AbWEQASY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:24 -0400
Date: Wed, 17 May 2006 02:18:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 40/50] genirq: ARM: Convert pxa to generic irq handling
Message-ID: <20060517001818.GO12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/mach-pxa/idp.c        |    1 +
 arch/arm/mach-pxa/sharpsl_pm.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-genirq.q/arch/arm/mach-pxa/idp.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-pxa/idp.c
+++ linux-genirq.q/arch/arm/mach-pxa/idp.c
@@ -18,6 +18,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/fb.h>
 
Index: linux-genirq.q/arch/arm/mach-pxa/sharpsl_pm.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-pxa/sharpsl_pm.c
+++ linux-genirq.q/arch/arm/mach-pxa/sharpsl_pm.c
@@ -18,11 +18,11 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <asm/apm.h>
 #include <asm/arch/pm.h>
 #include <asm/arch/pxa-regs.h>
