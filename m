Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSEVJAM>; Wed, 22 May 2002 05:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSEVJAL>; Wed, 22 May 2002 05:00:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18195 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316896AbSEVJAK>; Wed, 22 May 2002 05:00:10 -0400
Date: Wed, 22 May 2002 11:00:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020522090010.GC19569@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com> <3CEB3F93.7030508@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Major parts are: process stopper, S3 specific code, S4 specific
> >>code. What can I do to make this applied?
> >
> >
> >Applied. Nothing needed but some time for me to look through it.
> >
> >It still has a few too many #ifdef CONFIG_SUSPEND, and I get this feeling 
> >that the background deamons shouldn't need to do the "freeze()" by hand 
> >but simply be automatically frozen and thawed when they sleep by looking 
> >at the KERNTHREAD bit or something, but..
> 
> Oh and please reject the idea of compressing the pages
> you are writing to disk for the following reaons:

[snip]

It probably was not going to be implemented anyway. It was meant to
speed up suspend process, and yes simple compression probably could
achieve that, but it is not worth the trouble, probably.

> 1. compression is not deterministic in terms of the possible space
> savings, you will still have to provide the required amount of space.
> 
> 2. every compression algorithm has theoretical cases where the
> compression mechanism is actually increasing the space requirements.
> 
> 3. Compressing around 360 Mbytes of data will take quite a lot
> of time.
> 
> 4. Point 3 will make the CPU go high - not nice if the suspend
> happens in case of battery emergency...
> 
> Anyway it's time to repartition my notebook :-).

Yep. [Actually, if you have swap partition, you don't need to
repartition anything.]
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
