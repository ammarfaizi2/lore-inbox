Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSKHQvS>; Fri, 8 Nov 2002 11:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266807AbSKHQvS>; Fri, 8 Nov 2002 11:51:18 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:10669 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S266806AbSKHQvP> convert rfc822-to-8bit; Fri, 8 Nov 2002 11:51:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: NUMA scheduler BK tree
Date: Fri, 8 Nov 2002 17:57:22 +0100
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <1036712788.3178.15.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1036712788.3178.15.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211081757.22876.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

thanks for the results, they look really good!

There's a problem with your script for Schedbench: the column labels
are permuted! Instead of
>                              Elapsed   TotalUser    TotalSys     AvgUser
you should have
>                              AvgUser   Elapsed      TotalUser    TotalSys

The numbers make more sense like that ;-)
Could you please send me your script for schedbench?

BTW: the bk repository has now two distinct changesets, one for the
"core" the other one for the initial balancing. Larry McVoy showed me
how to do things right with the names assigned to the changesets.

Thanks!

Regards,
Erich


On Friday 08 November 2002 00:46, Michael Hohnbaum wrote:
> On Wed, 2002-11-06 at 08:34, Erich Focht wrote:
> > in order to make it easier to keep up with the main Linux tree I've
> > set up a bitkeeper repository with our NUMA scheduler at
> >        bk://numa-ef.bkbits.net/numa-sched
> > (Web view:  http://numa-ef.bkbits.net/)
...
> Tested this on a 4 node NUMAQ.  Worked fine.  Results:
>
> $reportbench stock46 sched46
> Kernbench:
>                              Elapsed        User      System         CPU
>                  stock46      20.66s    194.062s      53.39s     1197.4%
>                  sched46     19.988s    191.302s     50.692s     1210.4%
>
> Schedbench 4:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>                  stock46       27.27       40.64      109.13        0.85
>                  sched46       23.10       41.32       92.42        0.76
>
> Schedbench 8:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>                  stock46       39.18       55.12      313.56        1.68
>                  sched46       34.45       51.24      275.63        2.28
>
> Schedbench 16:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>                  stock46       56.39       72.44      902.45        5.12
>                  sched46       56.73       71.31      907.88        4.19
>
> Schedbench 32:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>                  stock46       90.47      203.28     2895.41       10.39
>                  sched46       60.95      143.21     1950.72       10.31
>
> Schedbench 64:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>                  stock46      105.00      439.04     6720.90       25.02
>                  sched46       59.07      262.98     3781.06       19.59
>
> The schedbench runs were ran once each.  Kernbench is the average of
> 5 runs.
>
>           Michael

