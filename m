Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288671AbSAIBJy>; Tue, 8 Jan 2002 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288672AbSAIBJe>; Tue, 8 Jan 2002 20:09:34 -0500
Received: from Expansa.sns.it ([192.167.206.189]:26124 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288671AbSAIBJ0>;
	Tue, 8 Jan 2002 20:09:26 -0500
Date: Wed, 9 Jan 2002 02:09:08 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>, Anton Blanchard <anton@samba.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        George Anzinger <george@mvista.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201090014.g090Efpn002215@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0201090148550.2471-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> On Wednesday, 9. January 2002 00:02, Luigi Genoni wrote:
> > On Tue, 8 Jan 2002, Daniel Phillips wrote:
> > > On January 8, 2002 04:29 pm, Andrea Arcangeli wrote:
> [-]
> > > > I also don't want to devaluate the preemptive kernel approch (the mean
> > > > latency it can reach is lower than the one of the lowlat kernel,
> > > > however I personally care only about worst case latency and this is why
> > > > I don't feel the need of -preempt),
> > >
> > > This is exactly the case that -preempt handles well.  On the other hand,
> > > trying to show that scheduling hacks satisfy any given latency bound is
> > > equivalent to solving the halting problem.
> > >
> > > I thought you had done some real time work?
> > >
> > > > but I just wanted to make clear that the
> > > > idea that is floating around that preemptive kernel is all goodness is
> > > > very far from reality, you get very low mean latency but at a price.
> > >
> > > A price lots of people are willing to pay
> >
> > Probably sometimes they are not making a good business. In the reality
> > preempt is good in many scenarios, as I said, and I agree that for
> > desktops, and dedicated servers where just one application runs, and
> > probably the CPU is idle the most of the time,
>
> OK, good. You are much at the same line than I am.
>
> Should we starting not only to differentiate between UP and SMP systems but
> allthought between desktop and (big) servers?
> I remember one saying. "Think, this patch is worth only for ~0.05% of the
> Linux users..." (He meant the multi SMP system users.)
Linux is suitable for many use, with a lot of HW.
There are a lot of thing you MUST differentiate, not just desktop and
servers, and uniprocessor and multi SMP
Just think to this, Linux runs on
sprac64, alpha, ia64, pa-risc, ppc and so on, and all those platforms have
work well with it.
Don't you see?
And please, lkml is the place to differentiate, because here people talk
about development, and how to do it at best.
>
> Allmost 99.95% of the Linux users running desktops and I am somewhat tiered
> of saying, "sorry, Linux is under development..."
> Look at the imprint of the famous German ct magazine (they are not even known
> as Linux bashers...;-). It shows little penguins falling like domino stones
> (starting with 2.4.17).
yes and no. Maybe 95% of linux box out here are desktops, and they would
benefit of preemption. For the others, it's an option not to enable it.
But what we were discussing here was if preemption is a greek panacea or
not. And if not, why. And then, How could things be improoved. It is
important to discuss those topics here.
>
> Let me rephrase it:
> I appreciate all your great work and I know "only" some (little) internals of
> it but we should do some interactivity improvements for the 2.4 kernel, too.
> I know what it's worth Andrew's (lowlatency patch) and Robert's (George
> Anzinger's) preempt patch. In short the system (bigger desktop) flies.
yes, but this is mostly 2.5 stuff. Then it can be backported.
>
>
> > indeed users have a speed
> > feeling. Please consider that on eavilly loaded servers, with 40 and more
> > users, some are running gcc, others g77, others g++ compilations, someone
> > runs pine or mutt or kmail, and netscape, and mozilla, and emacs (someone
> > form xterm kde or gnome), and and
> > and... You can have also 4/8 CPU butthey are not infinite ;) (but I talk
> > mainly thinking of dualAthlon systems).
> > there is a lot of memory and disk I/O.
> > This is not a strange scenary on the interactive servers used at SNS.
> > Here preempt has a too high price
>
> That's why preempt is a compile time option, btw.
>
> > > By the way, have you measured the cost of -preempt in practice?
> >
> > Yes, I did a lot of tests, and with current preempt patch definitelly
> > I was seeing a too big performance loss.
>
> Have you tried with stock 2.4.17 or with additional patches?
> 2.4.17-rc2aa2 (10_vm-21)?
Obviously. This is an important part of my work (and hobby).
>
> The later make big differences in throughput for me (with and without
> preempt).
for me too, 2.4.17+rc2aa2 is specially good with medium sized databases.
>
> I am under preparation of some numbers.
> Anybody want some special tests?
> dbench (yes, I know...) with and without MP3 during run
> latencytest0.42-png
> bonnie++
> getc_putc
very interested in what you will get.
>
> Thank you for all your serious answers. This was definitely not intended as a
> flamewar start.
and this was not a flamewar...

