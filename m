Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132474AbQKSP0U>; Sun, 19 Nov 2000 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132492AbQKSP0K>; Sun, 19 Nov 2000 10:26:10 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:30421 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S132474AbQKSPZw>; Sun, 19 Nov 2000 10:25:52 -0500
Message-ID: <3A17E986.E4D5A06@didntduck.org>
Date: Sun, 19 Nov 2000 09:53:58 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Markus Schoder <markus_schoder@yahoo.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <20001118190638.18296.qmail@web3407.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Schoder wrote:
> 
> --- Linus Torvalds <torvalds@transmeta.com> schrieb: >
> 
> >
> > On Sat, 18 Nov 2000, adrian wrote:
> >
> > >
> > >
> > > On Sat, 18 Nov 2000, Linus Torvalds wrote:
> > >
> > > > There's almost certainly more than that. I'd
> > love to have a report on my
> > > > asm-only version, but even so I suspect it also
> > requires the 3dnow stuff,
> > >
> > > I tried all three versions, and no freezes.  I
> > forgot to mention the tests
> > > were run on a model 2 Athlon (original slot K7,
> > .18 micron).  The kernel
> > > is compiled with 3dnow support.
> >
> > Apparently it isn't the stepping, as we have Athlon
> > model 4's both showing
> > it and not showing it. The motherboard seems to be
> > the only real
> > difference here, which is why I like the irq13
> > explanation more and more.
> >
> > I've been wanting to get rid of irq13 anyway (some
> > boards wire up USB
> > and/or ACPI to irq13 and the fact that the FPU has
> > claimed it makes those
> > machines unhappy), so if the solution is to only
> > check for irq13 on old
> > i386 and i486sx machines and just leave it alone for
> > newer CPU's, I won't
> > complain.
> >
> > Markus, can you make the irq13 test the first thing
> > - don't worry about
> > 3dnow as that seems to not be a deciding factor..
> >
> >                       Linus
> >
> 
> Ok, that was it!  It's IRQ 13.  Guess I should have
> tried that first.  Now everything works perfectly.
> Thanks everybody.

What motherboard do you have?  I can't reproduce this on my FIC SD11.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
