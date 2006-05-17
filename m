Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWEQA3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWEQA3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWEQA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:28:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63184 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932334AbWEQARl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:41 -0400
Date: Wed, 17 May 2006 02:17:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 30/50] genirq: ARM: Convert clps711x to generic irq handling
Message-ID: <20060517001734.GE12877@elte.hu>
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
 arch/arm/mach-clps711x/time.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-genirq.q/arch/arm/mach-clps711x/time.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-clps711x/time.c
+++ linux-genirq.q/arch/arm/mach-clps711x/time.c
@@ -19,6 +19,7 @@
 #include <linux/timex.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/sched.h>
 
 #include <asm/hardware.h>
