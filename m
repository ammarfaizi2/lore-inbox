Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVCYQ1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVCYQ1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCYQ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 11:27:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56476 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261686AbVCYQ1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 11:27:38 -0500
Subject: [PATCH] fix trivial alpha warning
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 08:27:35 -0800
Message-Id: <E1DEreq-0005Xn-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"bandwidth" variable is unused

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 kernel/spinlock.c                       |    0 
 memhotplug-dave/arch/alpha/kernel/smp.c |    1 -
 2 files changed, 1 deletion(-)

diff -puN arch/alpha/kernel/smp.c~A0-fix-alpha-warning arch/alpha/kernel/smp.c
--- memhotplug/arch/alpha/kernel/smp.c~A0-fix-alpha-warning	2005-03-25 08:25:38.000000000 -0800
+++ memhotplug-dave/arch/alpha/kernel/smp.c	2005-03-25 08:25:38.000000000 -0800
@@ -188,7 +188,6 @@ smp_tune_scheduling (int cpuid)
 	struct percpu_struct *cpu;
 	unsigned long on_chip_cache;	/* kB */
 	unsigned long freq;		/* Hz */
-	unsigned long bandwidth = 350;	/* MB/s */
 
 	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset
 				      + cpuid * hwrpb->processor_size);
diff -puN include/linux/list.h~A0-fix-alpha-warning include/linux/list.h
diff -puN kernel/sched.c~A0-fix-alpha-warning kernel/sched.c
diff -puN kernel/spinlock.c~A0-fix-alpha-warning kernel/spinlock.c
_
