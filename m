Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312417AbSCURVp>; Thu, 21 Mar 2002 12:21:45 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:8835 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312407AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [9/10]
Message-Id: <E16o6CB-0005ON-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One line addition to make the header match that of the i386.

-Chris


--- linux-2.5.7/include/asm-alpha/thread_info.h~	Wed Mar 20 05:07:15 2002
+++ linux-2.5.7/include/asm-alpha/thread_info.h	Wed Mar 20 11:38:27 2002
@@ -20,6 +20,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			cpu;		/* current CPU */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	int bpt_nsaved;
 	unsigned long bpt_addr[2];		/* breakpoint handling  */
