Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSANRem>; Mon, 14 Jan 2002 12:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSANReX>; Mon, 14 Jan 2002 12:34:23 -0500
Received: from [66.89.142.2] ([66.89.142.2]:34878 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S287835AbSANReQ>;
	Mon, 14 Jan 2002 12:34:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 18:36:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87bsfx9led.fsf@fadata.bg> <20020114064548.D22065@hq.fsmlabs.com>
In-Reply-To: <20020114064548.D22065@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QB2Z-0000nG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 02:45 pm, yodaiken@fsmlabs.com wrote:
> POSIX makes no specification of how scheduling classes interact - unless something changed
> in the new version.
> 
> But more than that, the problem of preemption is much more complex when you have
> task that do not share the "goodness fade" with everything else. That is, given a
> set of SCHED_OTHER processes at time T0, it is reasonable to design the scheduler so
> that there is some D so that by time T0+D each process has become the highest priority
> and has received cpu up to either a complete time slice or a I/O block. Linux kind of
> has this property now, and I believe that making this more robust and easier to analyze
> is going to be an enormously important issue.  However, once you add SCHED_FIFO in the
> current scheme, this becomes more complex. And with preempt, you cannot even offer the
> assurance that once a process gets the cpu it will make _any_ advance at all.

So the prediction here is that SCHED_FIFO + preempt can livelock some set of correctly
designed processes, is that it?  I don't see exactly how that could happen, though that
may simply mean I didn't read closely enough.

--
Daniel
