Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSKLATi>; Mon, 11 Nov 2002 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKLATh>; Mon, 11 Nov 2002 19:19:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:46311 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262800AbSKLATg>; Mon, 11 Nov 2002 19:19:36 -0500
Subject: Re: [PATCH 2.5.47] NUMA scheduler (1/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200211111613.19175.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de> 
	<200211111613.19175.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 16:24:14 -0800
Message-Id: <1037060655.29537.52.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 07:13, Erich Focht wrote:
> Hi,
> 
> here come the NUMA scheduler patches for 2.5.47 which emerged from
> Michael's and my work on NUMA schedulers. As usual in two parts:
> 
> 01-numa-sched-core-2.5.47-21.patch: core NUMA scheduler infrastructure
>   providing a node aware load_balancer
> 
> 02-numa-sched-ilb-2.5.47-21.patch: initial load balancing, selects
>   least loaded node & CPU at exec()

Built, booted, tested on NUMAQ.  Results:

$ reportbench sched47 stock47
Kernbench:
                             Elapsed        User      System         CPU
                 sched47      20.39s    191.824s     50.358s     1187.6%
                 stock47     20.608s    194.536s         53s     1201.4%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 sched47       22.45       34.79       89.84        0.69
                 stock47       29.05       42.58      116.25        0.94

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 sched47       39.58       60.98      316.72        1.78
                 stock47       43.30       56.84      346.49        2.44

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 sched47       58.83       72.58      941.56        5.30
                 stock47       60.76       82.05      972.31        4.82

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 sched47       55.87      122.75     1788.32       11.02
                 stock47       77.93      179.68     2494.06       11.35

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 sched47       85.77      360.49     5490.28       21.13
                 stock47       94.31      398.85     6036.95       23.47


            Michael

> An up-to-date BK tree containing the whole NUMA scheduler can be found
> at bk://numa-ef.bkbits.net/numa-sched .
> 
> Regards,
> Erich

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

