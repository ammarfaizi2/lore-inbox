Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWEQAWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWEQAWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWEQAS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:18:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24477 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932340AbWEQAST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:19 -0400
Date: Wed, 17 May 2006 02:18:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 36/50] genirq: ARM: Convert ixp4xx to generic irq handling
Message-ID: <20060517001800.GK12877@elte.hu>
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
 arch/arm/mach-ixp4xx/coyote-pci.c    |    1 +
 arch/arm/mach-ixp4xx/ixdp425-pci.c   |    1 +
 arch/arm/mach-ixp4xx/ixdpg425-pci.c  |    2 +-
 arch/arm/mach-ixp4xx/nas100d-pci.c   |    1 +
 arch/arm/mach-ixp4xx/nas100d-power.c |    1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-genirq.q/arch/arm/mach-ixp4xx/coyote-pci.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp4xx/coyote-pci.c
+++ linux-genirq.q/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
Index: linux-genirq.q/arch/arm/mach-ixp4xx/ixdp425-pci.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ linux-genirq.q/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/config.h>
+#include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
Index: linux-genirq.q/arch/arm/mach-ixp4xx/ixdpg425-pci.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ linux-genirq.q/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -16,10 +16,10 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
-#include <asm/irq.h>
 
 #include <asm/mach/pci.h>
 
Index: linux-genirq.q/arch/arm/mach-ixp4xx/nas100d-pci.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ linux-genirq.q/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -18,6 +18,7 @@
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
Index: linux-genirq.q/arch/arm/mach-ixp4xx/nas100d-power.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp4xx/nas100d-power.c
+++ linux-genirq.q/arch/arm/mach-ixp4xx/nas100d-power.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/mach-types.h>
 
