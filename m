Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbULHBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbULHBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbULHBRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:17:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62090 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261997AbULHBPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:15:46 -0500
Date: Wed, 8 Dec 2004 02:14:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused macro (fwd)
Message-ID: <20041208011424.GE5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 13:31:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused macro

On Fri, Oct 29, 2004 at 11:30:48AM +1000, Peter Williams wrote:
> 
> You missed some :-).  The cpu_to_node_mask() macros don't seem to be 
> used either.

I only searched for unused static inline functions (since this was 
relatively easy).


But your comment seems to be correct, and below is the patch that 
removes the cpu_to_node_mask macros.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

