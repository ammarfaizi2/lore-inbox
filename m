Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWCQQTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWCQQTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWCQQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:39 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:51854 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030211AbWCQQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:35 -0500
Subject: [Patch 7 of 8] Finish PDA offset annotations
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:16:03 +0100
Message-Id: <1142612163.3033.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finish annotating the PDA members with offsets

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-x86_64/pda.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/include/asm-x86_64/pda.h
+++ linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
@@ -19,14 +19,14 @@ struct x8664_pda {
 					/* Note: this canary MUST be at offset 40!!! */
 #endif
 	int irqcount;			/* 48 */  /* Irq nesting counter. Starts with -1 */
-	int cpunumber;		    /* Logical CPU number */
-	char *irqstackptr;	/* top of irqstack */
-	int nodenumber;		    /* number of current node */
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;	/* number of NMI on this CPUs */
-	int mmu_state;     
-	struct mm_struct *active_mm;
-	unsigned apic_timer_irqs;
+	int cpunumber;			/* 52 */  /* Logical CPU number */
+	char *irqstackptr;		/* 56 */  /* top of irqstack */
+	int nodenumber;			/* 64 */  /* number of current node */
+	unsigned int __softirq_pending; /* 68 */
+	unsigned int __nmi_count;	/* 72 */  /* number of NMI on this CPUs */
+	int mmu_state;			/* 76 */
+	struct mm_struct *active_mm;	/* 80 */
+	unsigned apic_timer_irqs;	/* 88 */
 } ____cacheline_aligned_in_smp;
 
 extern struct x8664_pda *_cpu_pda[];

