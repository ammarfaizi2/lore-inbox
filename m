Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWEQATo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWEQATo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWEQATX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24017 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932382AbWEQATB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:01 -0400
Date: Wed, 17 May 2006 02:18:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 48/50] genirq: ARM drivers/pcmcia: Fixup includes
Message-ID: <20060517001856.GW12877@elte.hu>
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

Include the generic header file instead of the ARM specific one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/pcmcia/soc_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-genirq.q/drivers/pcmcia/soc_common.c
===================================================================
--- linux-genirq.q.orig/drivers/pcmcia/soc_common.c
+++ linux-genirq.q/drivers/pcmcia/soc_common.c
@@ -39,12 +39,12 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <linux/cpufreq.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/system.h>
 
 #include "soc_common.h"
