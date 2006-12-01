Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031113AbWLAMeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031113AbWLAMeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031156AbWLAMeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:34:09 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10869 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1031113AbWLAMeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:34:08 -0500
Message-ID: <45702037.1030701@openvz.org>
Date: Fri, 01 Dec 2006 15:29:43 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixed formatting in ia64_process_pending_irq()
Content-Type: multipart/mixed;
 boundary="------------090402000904030001040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402000904030001040004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A trivial issue found during code examining.
Someone typed unneeded extra spaces.

Signed-off-by: Pavel Emelianov <xemul@openvz.org>

--------------090402000904030001040004
Content-Type: text/plain;
 name="diff-ia64-irq-typo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ia64-irq-typo"

--- ./arch/ia64/kernel/irq_ia64.c.irqtypo	2006-11-23 11:45:25.000000000 +0300
+++ ./arch/ia64/kernel/irq_ia64.c	2006-12-01 15:19:12.000000000 +0300
@@ -219,16 +219,16 @@ void ia64_process_pending_intr(void)
 
 	vector = ia64_get_ivr();
 
-	 irq_enter();
-	 saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
-	 ia64_srlz_d();
-
-	 /*
-	  * Perform normal interrupt style processing
-	  */
+	irq_enter();
+	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
+	ia64_srlz_d();
+
+	/*
+	 * Perform normal interrupt style processing
+	 */
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (unlikely(IS_RESCHEDULE(vector)))
-			 kstat_this_cpu.irqs[vector]++;
+			kstat_this_cpu.irqs[vector]++;
 		else {
 			struct pt_regs *old_regs = set_irq_regs(NULL);
 

--------------090402000904030001040004--
