Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKRThK>; Sat, 18 Nov 2000 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQKRThB>; Sat, 18 Nov 2000 14:37:01 -0500
Received: from web3401.mail.yahoo.com ([204.71.203.55]:52752 "HELO
	web3407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129136AbQKRTgo>; Sat, 18 Nov 2000 14:36:44 -0500
Message-ID: <20001118190638.18296.qmail@web3407.mail.yahoo.com>
Date: Sat, 18 Nov 2000 20:06:38 +0100 (CET)
From: Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
To: Linus Torvalds <torvalds@transmeta.com>, adrian <jimbud@lostland.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Linus Torvalds <torvalds@transmeta.com> schrieb: >

> 
> On Sat, 18 Nov 2000, adrian wrote:
> 
> > 
> > 
> > On Sat, 18 Nov 2000, Linus Torvalds wrote:
> > 
> > > There's almost certainly more than that. I'd
> love to have a report on my
> > > asm-only version, but even so I suspect it also
> requires the 3dnow stuff,
> > 
> > I tried all three versions, and no freezes.  I
> forgot to mention the tests
> > were run on a model 2 Athlon (original slot K7,
> .18 micron).  The kernel
> > is compiled with 3dnow support.
> 
> Apparently it isn't the stepping, as we have Athlon
> model 4's both showing
> it and not showing it. The motherboard seems to be
> the only real
> difference here, which is why I like the irq13
> explanation more and more.
> 
> I've been wanting to get rid of irq13 anyway (some
> boards wire up USB
> and/or ACPI to irq13 and the fact that the FPU has
> claimed it makes those
> machines unhappy), so if the solution is to only
> check for irq13 on old
> i386 and i486sx machines and just leave it alone for
> newer CPU's, I won't
> complain.
> 
> Markus, can you make the irq13 test the first thing
> - don't worry about
> 3dnow as that seems to not be a deciding factor..
> 
> 			Linus
> 

Ok, that was it!  It's IRQ 13.  Guess I should have
tried that first.  Now everything works perfectly. 
Thanks everybody.

--
Markus

__________________________________________________________________
Do You Yahoo!?
Gesendet von Yahoo! Mail - http://mail.yahoo.de
Gratis zum Millionär! - http://10millionenspiel.yahoo.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
