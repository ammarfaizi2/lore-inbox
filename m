Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSAURJy>; Mon, 21 Jan 2002 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287490AbSAURJo>; Mon, 21 Jan 2002 12:09:44 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:59147 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S287425AbSAURJl>; Mon, 21 Jan 2002 12:09:41 -0500
Message-ID: <3C4C4C1A.9F7CE37@loewe-komp.de>
Date: Mon, 21 Jan 2002 18:12:58 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <3C4C42EE.BAEBE8CB@loewe-komp.de> <20020121094554.A14139@hq.fsmlabs.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com schrieb:
> 
> On Mon, Jan 21, 2002 at 05:33:50PM +0100, Peter Wächtler wrote:
> > yodaiken@fsmlabs.com schrieb:
> > >
> > > On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > > > > I think of "benefit", perhaps naiively, in terms of something that can
> > > > > be measured or demonstrated rather than just announced.
> > > >
> > > > But you see why asap scheduling improves latency/throughput *in theory*,
> > >
> > > Nope. And I don't even see a relationship between preemption and asap I/O
> > > schedulding. What make you think that I/O threads won't be preempted by
> > > other threads?
> > >
> >
> > I/O intensive threads block early voluntarily - while CPU hogs don't.
> 
> Since the preemption patch only allows additional preemption in kernel
> mode, I'm curious to know what the compute bound tasks are doing in
> kernel mode. Did Linux add in-kernel matrix multiplication while
> I was not looking?
> 

Dead right you are.
Then there are only slow system calls left. Umh, execve(), fork()
(with big address space) - what about page_launder etc.?


> > Statistically there is a higher chance, that a CPU hog gets preempted
> > instead of an IO bound (that gives up the CPU in some useconds anyway)
> 
> "Statistically"?  As far as I know, most I/O in Linux does not block.

You mean, the syscall returns without a reschedule?
Aehm, now it's time for some statistics where the kernel spents its time on ;-)

But what is a possible explanation for the people, who think their 
systems behave better with preemption - strong believe?
