Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVCSWIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVCSWIP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCSWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:08:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:33252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261870AbVCSWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:08:10 -0500
Date: Sat, 19 Mar 2005 14:07:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling changes in -mm tree
Message-Id: <20050319140754.23d76496.akpm@osdl.org>
In-Reply-To: <505920000.1111249137@[10.10.2.4]>
References: <505920000.1111249137@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I don't think these are doing much for performance. Or at least 
> *something* in your tree isn't ...
> 
> Kernbench: 
>                                      Elapsed    System      User       CPU
>  elm3b67      2.6.11                   50.24    146.60   1117.61   2516.67
>  elm3b67      2.6.11-mm1               52.27    141.14   1099.91   2374.33
>  elm3b67      2.6.11-mm2               51.88    142.41   1104.85   2403.67
>  elm3b67      2.6.11-mm4               51.23    145.04   1100.70   2431.00
> 
> (elm3b67 is a 16x x440 ia32 NUMA system + HT)

Sounds like the CPU scheduler, yes

> Is there an easy way to just test those sched changes alone?

Nick has tossed out and redone all the scheduler patches from -mm4, but I
assume it's all pretty much the same.

At http://www.zip.com.au/~akpm/linux/patches/stuff/mbligh.gz is a rollup
(against 2.6.12-rc1) of

sched2-fix-schedstats-warning.patch
sched2-cleanup-wake_idle.patch
sched2-improve-load-balancing-pinned-tasks.patch
sched2-reduce-active-load-balancing.patch
sched2-fix-smt-scheduling-problems.patch
sched2-add-debugging.patch
sched2-less-aggressive-idle-balancing.patch
sched2-balance-timers.patch
sched2-tweak-affine-wakeups.patch
sched2-no-aggressive-idle-balancing.patch
sched2-balance-on-fork.patch
sched2-schedstats-update-for-balance-on-fork.patch
sched2-sched-tuning.patch
sched2-sched-domain-sysctl.patch
add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch

