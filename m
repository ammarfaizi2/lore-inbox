Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbTL2UUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTL2UUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:20:10 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:9527 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265114AbTL2URl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:17:41 -0500
Date: Mon, 29 Dec 2003 12:16:22 -0800 (PST)
From: John Hawkes <hawkes@google.engr.sgi.com>
Message-Id: <200312292016.MAA01670@google.engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>, John Hawkes <hawkes@google.engr.sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for
    "drifty ITC"
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       lse-tech@lists.sourceforge.net
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
    <200312291851.KAA25312@google.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ Martin Bligh writes: ]
> Is there any harm in dropping the first part of your patch, ie.
...
> > diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/arch/i386/kernel/timers/timer_tsc.c linux-2.6.0-schedclock2/arch/i386/kernel/timers/timer_tsc.c
...
> and leaving the rest of it? the CONFIG_NUMA affects both NUMA-Q and Summit,
> BTW, which uses the cyclone timer, so it gets even more complex ;-)

No, no harm.  Leaving out that timer_tsc.c part means only that i386
CONFIG_NUMA continues to use "jiffies" as the timebase, which is a
low-resolution timebase and may affect the quality of some of the
interactive scheduling decisions.

John Hawkes
