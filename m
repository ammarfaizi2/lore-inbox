Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSJVAI6>; Mon, 21 Oct 2002 20:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSJVAI6>; Mon, 21 Oct 2002 20:08:58 -0400
Received: from pc132.utati.net ([216.143.22.132]:35456 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261839AbSJVAI6> convert rfc822-to-8bit; Mon, 21 Oct 2002 20:08:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Any hope of fixing shutdown power off for SMP?
Date: Mon, 21 Oct 2002 14:15:03 -0500
User-Agent: KMail/1.4.3
Cc: Jurriaan <thunder7@xs4all.nl>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1021021163731.4564A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021021163731.4564A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210211415.03206.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 15:41, Bill Davidsen wrote:
> On Sun, 20 Oct 2002, Rob Landley wrote:
> > On Sunday 20 October 2002 21:45, Bill Davidsen wrote:
> > > On Sun, 20 Oct 2002, Jurriaan wrote:
> > > > 2.5.43 will power down my smp VP6 board if I replace the BUG() calls
> > > > in arch/i386/kernel/apm.c with warnings. Somehow, the kernel doesn't
> > > > succesfully schedule itself to run on CPU 0. However, for my bios
> > > > that isn't needed.
> > >
> > > Are you using the real-mode call? Perhaps I should try NOT doing that,
> > > and see if it solves the problem. That used to be the solution, but
> > > things change.
> >
> > None of my systems will power down on UP if I enable the "local apic
> > support on uniprocessors" option.
> >
> > Something about the APIC code prevents the power down from occuring.  The
> > symptoms are as you describe: the drives spin down, and the power goes
> > off immediately if you press the button (instead of having to hold it
> > down), but the power doesn't go off by itself.
> >
> > Works fine if I compile without local APIC support.
>
> Hum, and you can quote me on that. I don't have that particular problem at
> all, my problem is only with SMP.

SMP machines have the APIC enabled by default.  Hence the problem sounds like 
it's (at least being triggered by) the APIC code.

> Anyway, my kernels are SMP, and if I boot "nosmp" they work fine with
> every APIC in sight enabled. This may or may not be the same problem, you
> could build an SMP kernel and boot it "nosmp" with APIC on and see what
> that does (if you're curious).

Dunno.  The boxen I currently manage are UP (cheaper that way), so I don't 
actually need the APIC, so I switched it off and life went on.  Alan Cox 
seems to be of the opinion that bios bugs are involved, which should come as 
no surprise. :)

Rob
