Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbTIDEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTIDEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:47:29 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:45804 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264658AbTIDEqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:46:37 -0400
Date: Wed, 03 Sep 2003 21:44:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Lang <david.lang@digitalinsight.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SSI clusters on NUMA (was Re: Scaling noise)
Message-ID: <21180000.1062650650@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0309031957500.17581-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309031957500.17581-100000@dlang.diginsite.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > how much of this need could be met with a native linux master and kernels
>> > running user-mode kernels? (your resource sharing would obviously not be
>> > that clean, but you could develop the tools to work across the kernel
>> > images this way)
>> 
>> I talked to Jeff and Andrea about this at KS & OLS this year ... the feeling
>> was that UML was too much overhead, but there were various ways to reduce
>> that, especially if the underlying OS had UML support (doesn't require it
>> right now).
>> 
>> I'd really like to see the performance proved to be better before basing
>> a design on UML, though that was my first instinct of how to do it ...
> 
> I agree that UML won't be able to show the performance advantages (the
> fact that the UML kernel can't control the cache footprint on the CPU's
> becouse it gets swapped from one to another at the host OS's convienience
> is just one issue here)
> 
> however with UML you should be able to develop the tools and features to
> start to weld the two different kernels into a single logical image. once
> people have a handle on how these tools work you can then try them on some
> hardware that has a lower level partitioning setup (i.e. the IBM
> mainframes) and do real speed comparisons between one kernel that's given
> X CPU's and Y memory and two kernels that are each given X/2 CPU's and Y/2
> memory.
> 
> the fact that common hardware doesn't nicly support the partitioning
> shouldn't stop people from solving the other problems.

Yeah, it's definitely an interesting development environment at least.
FYI, most of the discussions in Ottowa centered around system call 
overhead (4 TLB flushes per, IIRC), but the cache footprint is interesting
too ... with the O(1) sched in the underlying OS, it shouldn't flip-flop
around too easily, but interesting, nonetheless.

M.

