Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263265AbUJ2Lcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbUJ2Lcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUJ2Lca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:32:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26632 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263239AbUJ2LcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:32:19 -0400
Date: Fri, 29 Oct 2004 13:31:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused macro
Message-ID: <20041029113147.GE6677@stusta.de>
References: <20041028231445.GE3207@stusta.de> <41819D48.7000005@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41819D48.7000005@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:30:48AM +1000, Peter Williams wrote:
> 
> You missed some :-).  The cpu_to_node_mask() macros don't seem to be 
> used either.

I only searched for unused static inline functions (since this was 
relatively easy).


But your comment seems to be correct, and below is the patch that 
removes the cpu_to_node_mask macros.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/kernel/sched.c.old	2004-10-29 13:28:14.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/kernel/sched.c	2004-10-29 13:28:24.000000000 +0200
@@ -51,12 +51,6 @@
 
 #include <asm/unistd.h>
 
-#ifdef CONFIG_NUMA
-#define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
-#else
-#define cpu_to_node_mask(cpu) (cpu_online_map)
-#endif
-
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],

