Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBFL10>; Tue, 6 Feb 2001 06:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBFL1Q>; Tue, 6 Feb 2001 06:27:16 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16397 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129027AbRBFL1E>;
	Tue, 6 Feb 2001 06:27:04 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 6 Feb 2001 12:24:37 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox Marvell G400 
CC: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org,
        wakko@animx.eu.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14B394FA5EC2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Feb 01 at 9:36, David Woodhouse wrote:
> VANDROVE@vc.cvut.cz said:
> >  And if you insist on X, you can run first head through mga with
> > usefbdev /dev/fb0 with hwcursor off, and secondary head through fbdev /
> > dev/fb1. But it is not supported by me (and neither by XFree guys
> > AFAIK, not even talking about Matrox support guys) - I support only
> > first head in X and secondary head used for 'fbtv -k'.
> 
> Unless your machine is x86, and you use the binary-only HALlib from Matrox,
> that is. :(
> 
> However, since the second heads of both G400 and G450 cards are supported 
> in matroxfb, there's no real reason why the support in the 'real' XFree86 
> driver should be so far behind. The main barrier to dual-head support in 
> XFree86, last time I knew, was the lack of a way to _configure_ it. That's 
> now been fixed, obviously. The HALlib is used only for mode setup, AFAICT. 
> All acceleration is still done by the real driver. 
> 
> Petr - how much of the matroxfb code is yours to give, and would you permit
> chunks of it to be reused under the XFree86 licence? Clean-room
> reverse-engineering is such a PITA :)

Initialization code is entirely mine, sometime written with Matrox docs
in hand, sometime without; except G100 initialization, which was written 
with cooperation with others. But proper initialization have to parse
BIOS - now when PCI subsystem can enable/disable ROM, maybe I should try
it.

Accelerator code was written/enhandced by couple of peoples except me,
so it is probably impossible to get it under X - but they have some
acceleration already, right ? ;-)

Dualhead code is written entirely by me, and at least some portions
are already used in BeOS driver, probably under GPL, but I have no
problem releasing code under any other license you can imagine, as long
as it does not impose additional restrictions on my (me personally,
not future of matroxfb) further work.

There maybe problem that i2c examples were used when writting core
of maven driver. But real useful code should not be affected by this.

BTW, http://platan.vc.cvut.cz/~vana/maven/mavenreg.html contains
partial MAVEN documentation, as I assembled it more than year ago
for my own needs. But it is really partial, as most of TVOut equations
are present only in code, and not in `datasheet'. I have some about
half year old updates to that datasheet which were submitted by someone
who had access to TV signal analyser, but I did not integrate them to
HTML yet. And my code does not support original G200 TV Out, only
late (non-US, MGA-TVO-C) G200 and G400 are supported for TV.

> > I'm trying... more or less. Next G450 BIOSes will have fix for
> > matroxfb deadlock on boot, so there is at least some move. Although
> > now when workaround is implemented in matroxfb, it is a bit late...
> 
> I think that workaround wants to be put in place for G400 too; not just 
> G450.

According to Matrox engineers last G400 BIOSes already contains this 
workaround. And as G400 initialization from scratch is not officially 
supported by me... Yes, I should dig old G400 somewhere, replace one of
my G450 with it and code something up.
                                          Best regards,
                                                   Petr Vandrovec
                                                   vandrove@vc.cvut.cz
                                                   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
