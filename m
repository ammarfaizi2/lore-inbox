Return-Path: <linux-kernel-owner+w=401wt.eu-S932635AbWLZOW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWLZOW6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 09:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWLZOW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 09:22:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56108 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932628AbWLZOW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 09:22:57 -0500
Date: Tue, 26 Dec 2006 15:22:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061226142245.GB3677@elf.ucw.cz>
References: <20061222105521.GA23683@elf.ucw.cz> <20061222211754.GU2449@atomide.com> <20061222214843.GA25475@elf.ucw.cz> <20061223194829.GA29686@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061223194829.GA29686@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-12-23 11:48:29, Tony Lindgren wrote:
> Hi,
> 
> * Pavel Machek <pavel@ucw.cz> [061222 13:49]:
> > Hi!
> > 
> > > > This is not yet complete set. set_map() is missing in latest kernels.
> > > > 
> > > > Fix DECLARE_WORK()-change-related compilation problems. Please apply,
> > > >
> > > > --- a/drivers/mmc/omap.c
> > > > +++ b/drivers/mmc/omap.c
> > > > @@ -2,7 +2,7 @@
> > > >   *  linux/drivers/media/mmc/omap.c
> > > >   *
> > > >   *  Copyright (C) 2004 Nokia Corporation
> > > > - *  Written by Tuukka Tikkanen and Juha Yrjölä<juha.yrjola@nokia.com>
> > > > + *  Written by Tuukka Tikkanen and Juha Yrjölä <juha.yrjola@nokia.com>
> > > >   *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
> > > >   *  Other hacks (DMA, SD, etc) by David Brownell
> > > >   *
> > > 
> > > I already applied similar fixes to linux-omap for the workqueue changes,
> > > so I only applied the MMC typo fix above.
> > 
> > I thought I got pretty recent -git:
> > 
> > omap git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > 
> > ...should I use another tree?
> > 
> > Aha, I did another pull now and it seems to be better... no, it is
> > not:
> > 
> > Recovering from a previously interrupted fetch...
> > Fetching pack (head and objects)...
> > Fetching tags...
> > Missing tag v2.6.20-rc1...
> > Generating pack...
> > Done counting 1 objects.
> > Deltifying 1 objects.
> >  100% (1/1) done
> > Total 1, written 1 (delta 0), reused 1 (delta 0)
> > Unpacking 1 objects
> >  100% (1/1) done
> > Up to date.
> > 
> > Applying changes...
> > Branch already fully merged.
> > 
> > Plus it still does not compile:
> > 
> >   LD      vmlinux
> > arch/arm/plat-omap/built-in.o(.text+0xd470): In function
> > `exmap_set_armmmu':
> > : undefined reference to `set_pte'
> > arch/arm/plat-omap/built-in.o(.text+0xd56c): In function
> > `exmap_set_armmmu':
> > : undefined reference to `set_pte'
> > make: *** [vmlinux] Error 1
> 
> Is this still a problem? Sounds like the latest tree was not yet
> mirrored from master.kernel.org when you pulled.

Yep, it seems fixed.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
