Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSAUQvm>; Mon, 21 Jan 2002 11:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSAUQvc>; Mon, 21 Jan 2002 11:51:32 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:36618 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287401AbSAUQvU>;
	Mon, 21 Jan 2002 11:51:20 -0500
Date: Mon, 21 Jan 2002 09:50:51 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121095051.B14139@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16ShcU-0001ip-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 21, 2002 at 05:48:30PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:48:30PM +0100, Daniel Phillips wrote:
> On January 21, 2002 05:06 pm, yodaiken@fsmlabs.com wrote:
> > On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > > > I think of "benefit", perhaps naiively, in terms of something that can
> > > > be measured or demonstrated rather than just announced.
> > > 
> > > But you see why asap scheduling improves latency/throughput *in theory*, 
> > 
> > Nope. And I don't even see a relationship between preemption and asap I/O
> > schedulding. What make you think that I/O threads won't be preempted by
> > other threads?
> 
> Consider a thread reading from disk in such a way that readahead is no help, 
> i.e., perhaps the disk is fragmented.  At each step the IO thread schedules a 
> read and sleeps until the read completes, then schedules the next one.  At 
> the same time there is a hog in the kernel, or perhaps there is 
> competition from other tasks using the kernel.  In any event, it will 
> frequently transpire that at the time the disk IO completes there is somebody 
> in the kernel.  Without preemption the IO thread has to wait until the kernel 
> hog blocks, hits a scheduling point or exits the kernel.


So your claim is that:
	Preemption improves latency when there are both kernel cpu bound
	tasks and tasks that are I/O bound with very low cache hit
	rates?

Is that it?

Can you give me an example of a CPU bound task that runs
mostly in kernel? Doesn't that seem like a kernel bug?

> Naturally I constructed this case to show the effect most clearly.  There are 

How about a plausible case?

> many possible variations on the above scenario.  It does seem to explain the 
> latency/throughput improvements that have been reported in practice.

I still keep missing these reports. Can you help me here?
(Obviously "my laptop seems more effervescent" is not what I'm looking
 for.)





-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

