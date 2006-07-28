Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752029AbWG1QGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbWG1QGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWG1QGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:44 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:30136 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752029AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 1/5] Add comments to the PDA structure to annotate offsets
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102546.6416.9.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:03:10 +0200
Message-Id: <1154102590.6416.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 1/5] Add comments to the PDA structure to annotate offsets
From: Arjan van de Ven <arjan@linux.intel.com>

Change the comments in the pda structure to make the first fields to have
their offset documented (the rest of the fields follows in a later patch)
and to have the comments aligned.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>
---
 include/asm-x86_64/pda.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc2-git5-stackprot/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/include/asm-x86_64/pda.h
+++ linux-2.6.18-rc2-git5-stackprot/include/asm-x86_64/pda.h
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

