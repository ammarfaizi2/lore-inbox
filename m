Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316772AbSEUXUA>; Tue, 21 May 2002 19:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSEUXT7>; Tue, 21 May 2002 19:19:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316772AbSEUXT7>; Tue, 21 May 2002 19:19:59 -0400
Date: Wed, 22 May 2002 01:20:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020521232001.GK22878@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Major parts are: process stopper, S3 specific code, S4 specific
> > code. What can I do to make this applied?
> 
> Applied. Nothing needed but some time for me to look through it.

Wow, good!

> It still has a few too many #ifdef CONFIG_SUSPEND, and I get this
> feeling 

I'll hunt them down.

> that the background deamons shouldn't need to do the "freeze()" by
> hand 
> but simply be automatically frozen and thawed when they sleep by looking 
> at the KERNTHREAD bit or something, but..

Do you think I should modify schedule() to do freezing automatically?
I wanted to keep my hands off hot paths... I'd rather not do that. 

I guess adding maybe_refrigerator() macro should solve that without
introducing overhead in schedule().

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
