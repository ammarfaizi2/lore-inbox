Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131422AbRAOBP1>; Sun, 14 Jan 2001 20:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130803AbRAOBPR>; Sun, 14 Jan 2001 20:15:17 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:65033 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S131422AbRAOBO7>; Sun, 14 Jan 2001 20:14:59 -0500
Date: Mon, 15 Jan 2001 02:13:41 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010115021341.B17465@pcep-jamie.cern.ch>
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu> <20010114203823.A17160@pcep-jamie.cern.ch> <20010114233907.C2487@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010114233907.C2487@suse.cz>; from vojtech@suse.cz on Sun, Jan 14, 2001 at 11:39:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note that "hdparm -X34 -d1" enables old DMA, not UDMA.  (The board was
> > advertised as UDMA capable but it isn't AFAIK).

Fwiw, -X34 does not fix the lockups for everyone else.

Vojtech Pavlik wrote:
> Is the board still available for some testing?

The board is not in the same country as me (Wales vs. France), but I
visit it every few months so there is some chance of me testing it on
that timescale.  AFAIK there are no computer experts in the area to
enable remote access ;-)

> It should be able to do UDMA33.

It does not look hopeful.  Let us look at an old email:

From: Jamie Lokier <jamie@tantalophile.demon.co.uk>
To: Michel Aubry <giovanni@sudfr.com>
Subject: Re: mozilla+XFree86+Linux-2.1.x  => HARD LOCKUP (addition)

On Wed, Dec 09, 1998 at 04:30:34PM +0100, Michel Aubry wrote:
> Is this to say that your bios has no "select UDMA" or so capability???
> Is your motherboard an old one? (that was not udma compliant).

It has "Bus Master DMA" option, but no "UDMA" option.  It's an FIC
PC-2011, manufactured about August 1997.  I always assumed the hardware
did UDMA (that's one reason I bought it).

>       you should edit via82c586.c , uncomment or add a 
> "#define DISPLAY_VIA_TIMINGS"
>       and recompile your kernel...

Will do, at my next recompile.  Would that be with the patch you sent me?

> You ought to know that linux kernel via patch requires your bios to be
> udma compliant. If not, all you can do safely is run it dma only!

Is this strictly true?  You've obviously got all the chipset docs, and I
doubt anything on the motherboard interferes with IDE timings/state
machines.

> > [root@tantalophile linux]# hdparm -I /dev/hda

>       this one is not running udma!

I know, I did hdparm -X34 explicitly to avoid lockups.

> > [root@tantalophile linux]# hdparm -i /dev/hda
> 
>       this one is running udma!

And with these settings unchanged, the system locks up from time to
time.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
