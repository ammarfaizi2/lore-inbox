Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVB0ANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVB0ANX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVB0AKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:10:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:3496
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261313AbVB0AAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:30 -0500
Message-ID: <20050227010028.9.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] X86_64:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:40 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 i8259.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/x86_64/kernel/i8259.c 2.6.11-rc5/arch/x86_64/kernel/i8259.c
--- 2.6.11-rc5.orig/arch/x86_64/kernel/i8259.c	2005-01-24 12:25:39.000000000 +0100
+++ 2.6.11-rc5/arch/x86_64/kernel/i8259.c	2005-02-26 20:54:19.000000000 +0100
@@ -157,14 +157,13 @@
 }
 
 static struct hw_interrupt_type i8259A_irq_type = {
-	"XT-PIC",
-	startup_8259A_irq,
-	shutdown_8259A_irq,
-	enable_8259A_irq,
-	disable_8259A_irq,
-	mask_and_ack_8259A,
-	end_8259A_irq,
-	NULL
+	.typename = "XT-PIC",
+	.startup = startup_8259A_irq,
+	.shutdown = shutdown_8259A_irq,
+	.enable = enable_8259A_irq,
+	.disable = disable_8259A_irq,
+	.ack = mask_and_ack_8259A,
+	.end = end_8259A_irq,
 };
 
 /*
