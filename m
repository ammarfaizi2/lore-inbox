Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264374AbRFNBL6>; Wed, 13 Jun 2001 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264359AbRFNBLs>; Wed, 13 Jun 2001 21:11:48 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:17674 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S264374AbRFNBLd>;
	Wed, 13 Jun 2001 21:11:33 -0400
Date: Wed, 13 Jun 2001 19:22:38 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Daniel wrote:

I agree that some clean up is needed.  (The size of the kernel is getting
HUGE. Back in the old days, we didn't have kernels larger than a few
hundred kbytes.  That is because we had to type in the kernel source from
source written on papyrus.)

> So without further ado here're the features I want to get rid of:
> 
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.

You are in a part of the world that can afford them.

In Third World countries, however, Pentiums are not always the norm. You
are cutting off a good chunk of the world here.

> math-emu
> If support for i386 and i486 is going away, then so should math emulation.
> Every intel processor since the 486DX has an FPU unit built in. In fact
> shouldn't FPU support be a userspace responsibility anyway?

How does getting rid of math-emu effect compilation on other platforms?

Not just Intel out there...

> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc

This I strongly disagree with.

There are alot of ISA cards still in use.  (I have a USR 56k voice/fax
modem that still works great. How many Sound Blaster 16 cards are still
being used? Lots, i would guess.)

It may not be pretty, but it is still widely used. (Even in the US.)

> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.

I am not certain if tis is a good idea, for the reason given above.  (Not
certain about MCA and EISA though.)  

> all code marked as CONFIG_OBSOLETE
> Since we're cleaning house we may as well get rid of this stuff.

I don't have an argument there, except when it has not been that way long.

> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very least get rid
> of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)

I am not certain how much this stuff is still used outside the US.  The XT
driver still being around does surprise me though.  (Will that even *work*
on modern hardware?  I didn't think you could get that card to work on a
386.)

> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

This is BAD idea.  This sort of joystick was produced until reciently.
They are still in use.  You will piss off a bunch of gamers this way.
(Yanking a gamer's joystick is never a good idea.)

> a.out
> Who needs it anymore. I love ELF.

How much legacy code is still out there? How much will still run on 2.4? I
don't see this one as a problem, but I expect that there are some special
cases that will keep it alive.

> I really think doing a clean up is worthwhile. Maybe while looking for stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or suggestions?
> I'd love to start a good discussion about this going so please send me your
> 2 cents.

I would like to see a clean up of the documentation.  (As well as new docs
written.) Getting an updated list of all the parameters that can be passed
to the kernel would be a nice start.  (The current list looks pretty old.)

I do agree that some parts need to be cut off from the main tree.  Maybe
this clean-up should be a part of 2.5? 2.7? 6.6.6?

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

