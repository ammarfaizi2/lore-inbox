Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288999AbSAUX54>; Mon, 21 Jan 2002 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286403AbSAUX5r>; Mon, 21 Jan 2002 18:57:47 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:19730 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288999AbSAUX5c>;
	Mon, 21 Jan 2002 18:57:32 -0500
Date: Mon, 21 Jan 2002 16:56:59 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121165659.A20501@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <1011647882.8596.466.camel@phantasy> <20020121144937.A18422@hq.fsmlabs.com> <1011650506.850.483.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1011650506.850.483.camel@phantasy>; from rml@tech9.net on Mon, Jan 21, 2002 at 05:01:45PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:01:45PM -0500, Robert Love wrote:
> On Mon, 2002-01-21 at 16:49, yodaiken@fsmlabs.com wrote:
> 
> > > (average of 4 runs of `dbench 16')
> > > 2.5.3-pre1:		25.7608 MB/s
> > > 2.5.3-pre1-preempt:	32.341 MB/s
> > > 
> > > (old, average of 4 runs of `dbench 16')
> > > 2.5.2-pre11:		24.5364 MB/s
> > > 2.5.2-pre11-preempt:	27.5192 MB/s
> 
> > Robert, with all due respect, my tests of dbench show such high
> > variation that 4 miserable runs prove exactly nothing.
> 
> Well you asked for dbench.  Would you prefer 10 runs each?  There were,

50. And I'd like standard deviation as well as average, best, worst.

And then I'd like to see the same test done with a RT task running in
the background - since I assume preempt has as its main purpose
to enable SCHED_FIFO.

> I guess the point is, everyone argues preemption is detrimental to
> throughput.  I'm not going to argue that we aren't adding complexity,

I have not seen that argued - certainly I have not argued it myself.
My argument is:
	It makes the kernel _much_ more complex
	It has known costs e.g. by making the lockless 
		per-processor caching  more difficult if not impossible
	It seems to lead to a requirement for inheritance
	It has no demonstrated benefits.

> > Did these even come on the same filesystem?
> 
> Yes, why would you suspect otherwise?
> 

Because the prior cited benchmark was a kernel compile on different trees.
Was the filesystem unchanged between runs?
I'm not suggesting you are cheating, it's easy to overlook something 
critical when there are so many variables.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

