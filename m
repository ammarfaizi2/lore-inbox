Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUHTGaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUHTGaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267593AbUHTGaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:30:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:9952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267591AbUHTGam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:30:42 -0400
Date: Thu, 19 Aug 2004 23:28:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hawkes@sgi.com, mingo@elte.hu
Subject: Re: [PATCH] add scheduler domains for ia64
Message-Id: <20040819232855.5d919155.akpm@osdl.org>
In-Reply-To: <200408192222.35512.jbarnes@engr.sgi.com>
References: <200408131108.40502.jbarnes@engr.sgi.com>
	<200408171657.32357.jbarnes@engr.sgi.com>
	<41255DBA.3030909@yahoo.com.au>
	<200408192222.35512.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> Yep, it's been working ok so far.  There's still more we can do, but this is a 
>  good start I think.  Andrew, this version applies on top of 2.6.8.1-mm2 but 
>  overwrites most of the earlier node-span patch by moving bits from arch/ia64 
>  to kernel/sched.c, so let me know if you want the patch in a different 
>  format.

Is OK.  I wiggled it into the logical place so we'll end up with a sane
patch series.

Watch the warnings please...



kernel/sched.c:3732: warning: `sched_domain_node_span' defined but not used

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/sched.c |    5 -----
 1 files changed, 5 deletions(-)

diff -puN kernel/sched.c~sched-domain-node-span-4-update-warning-fix kernel/sched.c
--- 25/kernel/sched.c~sched-domain-node-span-4-update-warning-fix	2004-08-19 23:28:24.395974232 -0700
+++ 25-akpm/kernel/sched.c	2004-08-19 23:28:24.400973472 -0700
@@ -3727,11 +3727,6 @@ cpumask_t __init sched_domain_node_span(
 
 	return span;
 }
-#else /* !CONFIG_NUMA */
-static cpumask_t __init sched_domain_node_span(int node, int size)
-{
-	return cpu_possible_map;
-}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SCHED_SMT
_

