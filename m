Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSKMNjx>; Wed, 13 Nov 2002 08:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSKMNjx>; Wed, 13 Nov 2002 08:39:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261365AbSKMNjw>; Wed, 13 Nov 2002 08:39:52 -0500
Date: Wed, 13 Nov 2002 14:46:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
Message-ID: <20021113134642.GE10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz> <1037126927.9383.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037126927.9383.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With the shutdown/cleanup split so the locking works out you might
> actually be able to do what you want (although I dont think you can get
> all the locking logic right yet because some of it is still hosed in the
> ide core). Also take a glance at the SC1200 driver with regards to the
> sysfs based power management handling.

I'll take a look.

> [Linus you can apply this if you want - it fixes
> 	Serverworks /proc
> 	Adds SC1200
> 	Short term fix for simplex DMA devices
> 	Fixes PCMCIA ide eject
> 	Splits IDE I/O from the registration code
> 	Makes the argument names saner
> ]
> 
>  	int		(*standby)(ide_drive_t *);
>  	int		(*suspend)(ide_drive_t *);
>  	int		(*resume)(ide_drive_t *);

Can you show me who calls these 3 callbacks?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
