Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVB0ANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVB0ANX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVB0ALJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:11:09 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4776
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261314AbVB0AAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:33 -0500
Message-ID: <20050227010029.10.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] IA64:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:43 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 irq.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/ia64/sn/kernel/irq.c 2.6.11-rc5/arch/ia64/sn/kernel/irq.c
--- 2.6.11-rc5.orig/arch/ia64/sn/kernel/irq.c	2005-02-14 11:01:04.000000000 +0100
+++ 2.6.11-rc5/arch/ia64/sn/kernel/irq.c	2005-02-26 20:54:19.000000000 +0100
@@ -194,14 +194,14 @@
 }
 
 struct hw_interrupt_type irq_type_sn = {
-	"SN hub",
-	sn_startup_irq,
-	sn_shutdown_irq,
-	sn_enable_irq,
-	sn_disable_irq,
-	sn_ack_irq,
-	sn_end_irq,
-	sn_set_affinity_irq
+	.typename = "SN hub",
+	.startup = sn_startup_irq,
+	.shutdown = sn_shutdown_irq,
+	.enable = sn_enable_irq,
+	.disable = sn_disable_irq,
+	.ack = sn_ack_irq,
+	.end = sn_end_irq,
+	.set_affinity = sn_set_affinity_irq
 };
 
 unsigned int sn_local_vector_to_irq(u8 vector)
