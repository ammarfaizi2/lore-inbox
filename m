Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276309AbRJGLal>; Sun, 7 Oct 2001 07:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRJGLab>; Sun, 7 Oct 2001 07:30:31 -0400
Received: from c999639-a.carneg1.pa.home.com ([24.180.243.111]:2812 "EHLO
	maul.jdc.home") by vger.kernel.org with ESMTP id <S276309AbRJGLaX>;
	Sun, 7 Oct 2001 07:30:23 -0400
Subject: Re: AIC7xxx panic
From: Jim Crilly <noth@noth.is.eleet.ca>
To: Rob Turk <r.turk@chello.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9ppc3l$cde$1@ncc1701.cistron.net>
In-Reply-To: <1002451051.3718.20.camel@warblade> 
	<9ppc3l$cde$1@ncc1701.cistron.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 07:28:57 -0400
Message-Id: <1002454137.284.6.camel@warblade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both disks on the controller are Seagate Cheetahs, the one being worked
during the panic is a ST39204LW, the other disk is a ST318451LW.

I did have TCQ enabled and I left it at the default of 255, I'll try a
lower value tomorrow, since it's so late.

Jim

On Sun, 2001-10-07 at 06:48, Rob Turk wrote:
> "Jim Crilly" <noth@noth.is.eleet.ca> wrote in message
> news:cistron.1002451051.3718.20.camel@warblade...
> > I got a reproducible panic while running dbench simulating 25+ clients,
> > the new aic7xxx driver panics with "Too few segs for dma mapping.
> > "Increase AHC_NSEG". The partition in question is FAT32 and on a
> > different disk than /, I'm not using HIGHMEM. I am using XFS and the
> > preempt patches, but I don't think they're related to the panic.
> >
> > The odd thing, is if I run dbench in the same manner on my / partition,
> > which is on a different disk on the same controller, it goes fine. It
> > seems, to my untrained eye anyway, to be a bad interaction between the
> > vfat driver and the aic7xxx driver.
> >
> > I'm using the old aic7xxx driver right now and it's fine, has anyone
> > else seen anything like this?
> >
> > Jim
> 
> Since this seems to fail on just one disk, it might have to do with one of the
> disk characteristics, like command queue depth. Did you enable Tagged Command
> Queueing, and if so, can you try playing around with the maximum depth?
> 
> Rob
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Help protect your rights on-line.
Join the Electronic Frontiers Foundation today: http://www.eff.org/join
-----------------------------------------------------------------------
Security: Antonyms: See Microsoft
-----------------------------------------------------------------------
"We are coming after you. God may have mercy on you, but we won't,"
declared Sen. John McCain, R-Arizona.

