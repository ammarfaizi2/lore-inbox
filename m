Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRK0Sci>; Tue, 27 Nov 2001 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282397AbRK0Sc2>; Tue, 27 Nov 2001 13:32:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44306 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281221AbRK0ScR>; Tue, 27 Nov 2001 13:32:17 -0500
Date: Tue, 27 Nov 2001 19:32:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: jsimmons@transvirtual.com, mj@ucw.cz, linux-kernel@vger.kernel.org,
        acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: Restoring videomode on return from S3 sleep
Message-ID: <20011127193209.B3152@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011126210621.A2039@elf.ucw.cz> <Pine.LNX.4.10.10111271003070.21131-100000@www.transvirtual.com> <20011127191604.A3152@atrey.karlin.mff.cuni.cz> <20011127132615.0a25c838.dang@fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127132615.0a25c838.dang@fprintf.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'll need to restore video mode on returning from acpi sleep...
> > > > 
> > > > Unfortunately, video selection code is not part of kernel, it is
> > > > 16-bit code. acpi_wakeup.S, otoh, *is* part of kernel :-(. 
> > > 
> > > Is this on the console and if it is I assum you are uing vgacon. It could 
> > > be the S# card has a broken implemenation. This wouldn't be the first.
> > > Their has been a patch sometime for vesafb to work properly with S3 cards.
> > > 
> > > S3 framebuffer anyone? I remember their has been scathered work on this
> > > but I never seen anything come to light for this.
> > 
> > Oh. Sorry. By S3 I mean ACPI S3 state. ACPI S3 == suspend to RAM.
> > 
> > Basically what I need is to restore video mode after returning from
> > ACPI S3 sleep state, so that vesafb works properly.
> 
> I need the same for APM. (I would prefer ACPI, but it currently
> hangs by box) 

ACPI and APM are *very* different in this regard: in APM, you stay
protected mode, while with ACPI, you *have to* go through real mode.

> I have to use vesafb or I get artifacts (Trident CyberBlade/XP), but then a
> resume from APM never restores the video.  Presumably, a reset (similar to
> when the fb is turned on?) would fix the problem.  I haven't looked into it
> yet due to lack of time, but if someone else is going to work on it, I'll
> gladly help test.


It is going to be different from ACPI sleep support.

...or...

maybe not. vesafb with ability to go back realmode and reinit hw would
be nice -- and it would also fix your APM problem. But I doubt that's
implementable.
									Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
