Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWEQAZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWEQAZA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEQASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:18:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16797 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932319AbWEQARw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:52 -0400
Date: Wed, 17 May 2006 02:17:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 31/50] genirq: ARM: Convert clps7500 to generic irq handling
Message-ID: <20060517001738.GF12877@elte.hu>
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
 arch/arm/mach-clps7500/core.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-genirq.q/arch/arm/mach-clps7500/core.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-clps7500/core.c
+++ linux-genirq.q/arch/arm/mach-clps7500/core.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/init.h>
