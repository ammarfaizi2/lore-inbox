Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSAUQam>; Mon, 21 Jan 2002 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSAUQaY>; Mon, 21 Jan 2002 11:30:24 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:64009 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S287307AbSAUQaH>; Mon, 21 Jan 2002 11:30:07 -0500
Message-ID: <3C4C42EE.BAEBE8CB@loewe-komp.de>
Date: Mon, 21 Jan 2002 17:33:50 +0100
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
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com schrieb:
> 
> On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > > I think of "benefit", perhaps naiively, in terms of something that can
> > > be measured or demonstrated rather than just announced.
> >
> > But you see why asap scheduling improves latency/throughput *in theory*,
> 
> Nope. And I don't even see a relationship between preemption and asap I/O
> schedulding. What make you think that I/O threads won't be preempted by
> other threads?
> 

I/O intensive threads block early voluntarily - while CPU hogs don't.
Statistically there is a higher chance, that a CPU hog gets preempted
instead of an IO bound (that gives up the CPU in some useconds anyway)

The next IO request is hitting the device "earlier" - instead of waiting
for the next schedule() - that makes sense to me.

With this scenario the system CPU utilization gets "bigger" for the benefit
of "faster" IO. OTOH, seti@home needs longer to run.
