Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRFUAwx>; Wed, 20 Jun 2001 20:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264205AbRFUAwn>; Wed, 20 Jun 2001 20:52:43 -0400
Received: from h24-66-233-243.ss.shawcable.net ([24.66.233.243]:14602 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S264173AbRFUAwa>; Wed, 20 Jun 2001 20:52:30 -0400
Date: Wed, 20 Jun 2001 18:53:05 -0400
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Threads FAQ entry incomplete
Message-ID: <20010620185305.B28999@twoflower.internal.do>
In-Reply-To: <20010620104800.D1174@w-mikek2.des.beaverton.ibm.com> <lx66drf04u.fsf@pixie.isr.ist.utl.pt> <20010620134221.C12357@qcc.sk.ca> <a05100306b756d7a9fdac@[130.161.115.44]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a05100306b756d7a9fdac@[130.161.115.44]>; from bakker@thorgal.et.tudelft.nl on Thu, Jun 21, 2001 at 01:00:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.D. Bakker <bakker@thorgal.et.tudelft.nl> wrote:
> At 13:42 -0600 20-06-2001, Charles Cazabon wrote:
> >Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
> > > BTW, I have a question: Can the availability of dual-CPU boards for
> > > intel and amd processors, rather then tri- or quadra-CPU boards, be
> > > explained with the fact that the performance degrades significantly for
> > > three or more CPUs?  Or is there a technological and/or comercial reason
> > > behind?
> >
> >Commercial reasons.  Cost per motherboard/chipset goes way up as the number
> >of CPUs supported goes up.  For each CPU that a chipset supports, it has to
> >add a lot of pins/lands, and chipsets are already typically land-limited.
> 
> That's not quite accurate. Most modern SMP-able processors have a common
> bus, where going from 1->2 CPUs adds just a handful of extra nets (usually
> bus request, bus grant and some IRQs). The actual issues are threefold.

Low-end Intel multi-CPU chipsets are like this (typical 2-CPU configurations,
and low-end 4-CPU configurations).  Higher-end systems (8-way, etc) typically
have multiple processor busses, with only one, two, or four processors per bus.
Processor bus contention costs performance even in 2-way systems, and at 4-way
and above, it becomes a serious bottleneck.  High end chipsets do the cache
coherency and snooping control between the busses.  Other N-way chipsets
(i.e., non-Intel) have point-to-point links between each CPU and the chipset.
The new AMD 760 chipset for Athlon is like this; so are N-way Alpha chipsets.
I can't swear to other hardware.

> First, most commodity chipsets simply support no more than two CPUs at best;
> most CPUs don't support having more (or any) siblings.  Adding more is cheap
> on the ASIC level, but nobody bothers because there is no demand.

Ask ServerWorks about this.  They make 16-way Intel chipsets.  It's possible,
just not cheap.

> Third, the more CPUs a bus holds, the higher the capacitance on the bus
> lines. Higher capacitance means lower maximum bus speed, which aggravates
> point two.

Which is one of the reasons for a pont-to-point "bus" with Alpha and Athlon
CPUs.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                     <linux-kernel@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
My opinions are just that -- my opinions.
-----------------------------------------------------------------------
