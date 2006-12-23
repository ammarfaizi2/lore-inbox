Return-Path: <linux-kernel-owner+w=401wt.eu-S1753721AbWLWTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbWLWTsX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 14:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbWLWTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 14:48:23 -0500
Received: from nlpi012.sbcis.sbc.com ([207.115.36.41]:54328 "EHLO
	nlpi012.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbWLWTsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 14:48:22 -0500
X-ORBL: [67.117.73.34]
Date: Sat, 23 Dec 2006 11:48:29 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061223194829.GA29686@atomide.com>
References: <20061222105521.GA23683@elf.ucw.cz> <20061222211754.GU2449@atomide.com> <20061222214843.GA25475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061222214843.GA25475@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [061222 13:49]:
> Hi!
> 
> > > This is not yet complete set. set_map() is missing in latest kernels.
> > > 
> > > Fix DECLARE_WORK()-change-related compilation problems. Please apply,
> > >
> > > --- a/drivers/mmc/omap.c
> > > +++ b/drivers/mmc/omap.c
> > > @@ -2,7 +2,7 @@
> > >   *  linux/drivers/media/mmc/omap.c
> > >   *
> > >   *  Copyright (C) 2004 Nokia Corporation
> > > - *  Written by Tuukka Tikkanen and Juha Yrjölä<juha.yrjola@nokia.com>
> > > + *  Written by Tuukka Tikkanen and Juha Yrjölä <juha.yrjola@nokia.com>
> > >   *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
> > >   *  Other hacks (DMA, SD, etc) by David Brownell
> > >   *
> > 
> > I already applied similar fixes to linux-omap for the workqueue changes,
> > so I only applied the MMC typo fix above.
> 
> I thought I got pretty recent -git:
> 
> omap git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> 
> ...should I use another tree?
> 
> Aha, I did another pull now and it seems to be better... no, it is
> not:
> 
> Recovering from a previously interrupted fetch...
> Fetching pack (head and objects)...
> Fetching tags...
> Missing tag v2.6.20-rc1...
> Generating pack...
> Done counting 1 objects.
> Deltifying 1 objects.
>  100% (1/1) done
> Total 1, written 1 (delta 0), reused 1 (delta 0)
> Unpacking 1 objects
>  100% (1/1) done
> Up to date.
> 
> Applying changes...
> Branch already fully merged.
> 
> Plus it still does not compile:
> 
>   LD      vmlinux
> arch/arm/plat-omap/built-in.o(.text+0xd470): In function
> `exmap_set_armmmu':
> : undefined reference to `set_pte'
> arch/arm/plat-omap/built-in.o(.text+0xd56c): In function
> `exmap_set_armmmu':
> : undefined reference to `set_pte'
> make: *** [vmlinux] Error 1

Is this still a problem? Sounds like the latest tree was not yet
mirrored from master.kernel.org when you pulled.

Regards,

Tony
