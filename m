Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWCQQRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWCQQRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCQQRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030203AbWCQQRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:13 -0500
Subject: [Patch 1 of 8] Pack the x86-64 PDA structure
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 17:11:37 +0100
Message-Id: <1142611898.3033.101.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reorders the PDA on x86-64 such that there is optimal packing of the data structures
(patch previously sent to Andi already)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-x86_64/pda.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/include/asm-x86_64/pda.h
+++ linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
@@ -22,8 +22,8 @@ struct x8664_pda {
 	int nodenumber;		    /* number of current node */
 	unsigned int __softirq_pending;
 	unsigned int __nmi_count;	/* number of NMI on this CPUs */
-	struct mm_struct *active_mm;
 	int mmu_state;     
+	struct mm_struct *active_mm;
 	unsigned apic_timer_irqs;
 } ____cacheline_aligned_in_smp;
 


