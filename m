Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287432AbSAUQqx>; Mon, 21 Jan 2002 11:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSAUQqh>; Mon, 21 Jan 2002 11:46:37 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34570 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287401AbSAUQqb>;
	Mon, 21 Jan 2002 11:46:31 -0500
Date: Mon, 21 Jan 2002 09:45:54 -0700
From: yodaiken@fsmlabs.com
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121094554.A14139@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <3C4C42EE.BAEBE8CB@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C4C42EE.BAEBE8CB@loewe-komp.de>; from pwaechtler@loewe-komp.de on Mon, Jan 21, 2002 at 05:33:50PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:33:50PM +0100, Peter Wächtler wrote:
> yodaiken@fsmlabs.com schrieb:
> > 
> > On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > > > I think of "benefit", perhaps naiively, in terms of something that can
> > > > be measured or demonstrated rather than just announced.
> > >
> > > But you see why asap scheduling improves latency/throughput *in theory*,
> > 
> > Nope. And I don't even see a relationship between preemption and asap I/O
> > schedulding. What make you think that I/O threads won't be preempted by
> > other threads?
> > 
> 
> I/O intensive threads block early voluntarily - while CPU hogs don't.

Since the preemption patch only allows additional preemption in kernel
mode, I'm curious to know what the compute bound tasks are doing in 
kernel mode. Did Linux add in-kernel matrix multiplication while
I was not looking?


> Statistically there is a higher chance, that a CPU hog gets preempted
> instead of an IO bound (that gives up the CPU in some useconds anyway)


"Statistically"?  As far as I know, most I/O in Linux does not block.
When you say "statistically", you should have some analysis with clearly
stated assumptions. 

> 
> The next IO request is hitting the device "earlier" - instead of waiting
> for the next schedule() - that makes sense to me.
> 
> With this scenario the system CPU utilization gets "bigger" for the benefit
> of "faster" IO. OTOH, seti@home needs longer to run.

Sorry. No sale.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

