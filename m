Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbSKGXlH>; Thu, 7 Nov 2002 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266635AbSKGXlH>; Thu, 7 Nov 2002 18:41:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38089 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266631AbSKGXlG>; Thu, 7 Nov 2002 18:41:06 -0500
Subject: Re: NUMA scheduler BK tree
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200211061734.42713.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Nov 2002 15:46:28 -0800
Message-Id: <1036712788.3178.15.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 08:34, Erich Focht wrote:
> Michael, Martin,
> 
> in order to make it easier to keep up with the main Linux tree I've
> set up a bitkeeper repository with our NUMA scheduler at
>        bk://numa-ef.bkbits.net/numa-sched
> (Web view:  http://numa-ef.bkbits.net/)
> 
> The tree is currently in sync with bk://linux.bkbits.net/linux-2.5 and
> I'll try to keep so.
> 
Tested this on a 4 node NUMAQ.  Worked fine.  Results:

$reportbench stock46 sched46 
Kernbench:
                             Elapsed        User      System         CPU
                 stock46      20.66s    194.062s      53.39s     1197.4%
                 sched46     19.988s    191.302s     50.692s     1210.4%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock46       27.27       40.64      109.13        0.85
                 sched46       23.10       41.32       92.42        0.76

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock46       39.18       55.12      313.56        1.68
                 sched46       34.45       51.24      275.63        2.28

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock46       56.39       72.44      902.45        5.12
                 sched46       56.73       71.31      907.88        4.19

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock46       90.47      203.28     2895.41       10.39
                 sched46       60.95      143.21     1950.72       10.31

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock46      105.00      439.04     6720.90       25.02
                 sched46       59.07      262.98     3781.06       19.59

The schedbench runs were ran once each.  Kernbench is the average of
5 runs.

          Michael

> Regards,
> Erich
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

