Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286225AbRLJKlE>; Mon, 10 Dec 2001 05:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbRLJKjp>; Mon, 10 Dec 2001 05:39:45 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:44298 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286216AbRLJKj1>; Mon, 10 Dec 2001 05:39:27 -0500
Date: Sun, 9 Dec 2001 13:13:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: John Clemens <john@deater.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011209131332.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain> <20011207213313.A176@elf.ucw.cz> <1007876254.17062.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1007876254.17062.0.camel@localhost.localdomain>; from cory.bell@usa.net on Sat, Dec 08, 2001 at 09:37:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > know what interrupt is right for maestro3, also on omnibook? ;-).
> 
> On my Pavilion (and the other 5400's as far as I can tell), maestro's on
> irq 5. Wanna send me a "dump_pirq" and a "lspci -vvvxxx"? Could you try

I forced maestro on irq11, and it now works, but pcmcia locks up. Maybe
11 is not correct, but it just happens frequene enough for sound to play
back?

Ugh... Yep, if I hooked maestro on USB interrupt.... Of course that would
work!

Ouch, you said you have maestro on irq5. And does it *work*? For me,
it plays mp3 but repeats portions even on wrong interrupt.

> the patch below (inspired by/stolen from Kai Germaschewski)? Also, the
> newest acpi patch will print out the acpi irq routing table - might have
> your info. You can tell if the patch below had any effect because it
> will say it ASSIGNED IRQ XX instead of FOUND.

Will patch below fix the problem or just print tables?

> apply to both. If you want to help get the BIOS updated (the root cause,
> IMHO), please call HP support and reference case number 1429683616 (that
> 9 may be a 4 - my handwriting is horrible). That's the case I logged
> with thim about the broken PIR table (USB irq showing 9; being 11) and
> failure to enable sse on athlon 4/duron/xp chips.

I'm afraid I'm not going to call HP, sitting in europe. Also not sure if
I'll be able to update BIOS, notebook is not exactly mine ("Trash anything
on the disk, but don't kill the machine").
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

