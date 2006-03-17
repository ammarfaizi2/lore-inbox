Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWCQQSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWCQQSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWCQQRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:43 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:49806 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030206AbWCQQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:31 -0500
Subject: [Patch 2 of 8] annotate the PDA structure with offsets
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:13:09 +0100
Message-Id: <1142611989.3033.107.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comments in the pda structure to make the first fields to have
their offset documented (the rest of the fields follows in a later patch)
and to have the comments aligned

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-x86_64/pda.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/include/asm-x86_64/pda.h
+++ linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
@@ -9,14 +9,12 @@
 
 /* Per processor datastructure. %gs points to it while the kernel runs */ 
 struct x8664_pda {
-	struct task_struct *pcurrent;	/* Current process */
-	unsigned long data_offset;	/* Per cpu data offset from linker address */
-	unsigned long kernelstack;  /* top of kernel stack for current */ 
-	unsigned long oldrsp; 	    /* user rsp for system call */
-#if DEBUG_STKSZ > EXCEPTION_STKSZ
-	unsigned long debugstack;   /* #DB/#BP stack. */
-#endif
-        int irqcount;		    /* Irq nesting counter. Starts with -1 */  	
+	struct task_struct *pcurrent;	/*  0 */  /* Current process */
+	unsigned long data_offset;	/*  8 */  /* Per cpu data offset from linker address */
+	unsigned long kernelstack;	/* 16 */  /* top of kernel stack for current */
+	unsigned long oldrsp;		/* 24 */  /* user rsp for system call */
+	unsigned long debugstack;	/* 32 */  /* #DB/#BP stack. */
+	int irqcount;			/* 40 */  /* Irq nesting counter. Starts with -1 */
 	int cpunumber;		    /* Logical CPU number */
 	char *irqstackptr;	/* top of irqstack */
 	int nodenumber;		    /* number of current node */

