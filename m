Return-Path: <linux-kernel-owner+w=401wt.eu-S1752880AbWLVVtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbWLVVtA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbWLVVtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:49:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43115 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752879AbWLVVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:48:59 -0500
Date: Fri, 22 Dec 2006 22:48:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061222214843.GA25475@elf.ucw.cz>
References: <20061222105521.GA23683@elf.ucw.cz> <20061222211754.GU2449@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061222211754.GU2449@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is not yet complete set. set_map() is missing in latest kernels.
> > 
> > Fix DECLARE_WORK()-change-related compilation problems. Please apply,
> >
> > --- a/drivers/mmc/omap.c
> > +++ b/drivers/mmc/omap.c
> > @@ -2,7 +2,7 @@
> >   *  linux/drivers/media/mmc/omap.c
> >   *
> >   *  Copyright (C) 2004 Nokia Corporation
> > - *  Written by Tuukka Tikkanen and Juha Yrjölä<juha.yrjola@nokia.com>
> > + *  Written by Tuukka Tikkanen and Juha Yrjölä <juha.yrjola@nokia.com>
> >   *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
> >   *  Other hacks (DMA, SD, etc) by David Brownell
> >   *
> 
> I already applied similar fixes to linux-omap for the workqueue changes,
> so I only applied the MMC typo fix above.

I thought I got pretty recent -git:

omap git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

...should I use another tree?

Aha, I did another pull now and it seems to be better... no, it is
not:

Recovering from a previously interrupted fetch...
Fetching pack (head and objects)...
Fetching tags...
Missing tag v2.6.20-rc1...
Generating pack...
Done counting 1 objects.
Deltifying 1 objects.
 100% (1/1) done
Total 1, written 1 (delta 0), reused 1 (delta 0)
Unpacking 1 objects
 100% (1/1) done
Up to date.

Applying changes...
Branch already fully merged.

Plus it still does not compile:

  LD      vmlinux
arch/arm/plat-omap/built-in.o(.text+0xd470): In function
`exmap_set_armmmu':
: undefined reference to `set_pte'
arch/arm/plat-omap/built-in.o(.text+0xd56c): In function
`exmap_set_armmmu':
: undefined reference to `set_pte'
make: *** [vmlinux] Error 1

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
