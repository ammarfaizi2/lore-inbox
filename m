Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVB0AC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVB0AC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVB0ABt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:01:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:65191
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261304AbVB0AAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:18 -0500
Message-ID: <20050227010015.4.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/10] PPC64:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:28 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 i8259.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/ppc64/kernel/i8259.c 2.6.11-rc5/arch/ppc64/kernel/i8259.c
--- 2.6.11-rc5.orig/arch/ppc64/kernel/i8259.c	2005-01-24 12:25:36.000000000 +0100
+++ 2.6.11-rc5/arch/ppc64/kernel/i8259.c	2005-02-26 20:54:19.000000000 +0100
@@ -131,14 +131,11 @@
 }
 
 struct hw_interrupt_type i8259_pic = {
-        " i8259    ",
-        NULL,
-        NULL,
-        i8259_unmask_irq,
-        i8259_mask_irq,
-        i8259_mask_and_ack_irq,
-        i8259_end_irq,
-        NULL
+	.typename = " i8259    ",
+	.enable = i8259_unmask_irq,
+	.disable = i8259_mask_irq,
+	.ack = i8259_mask_and_ack_irq,
+	.end = i8259_end_irq,
 };
 
 void __init i8259_init(int offset)
