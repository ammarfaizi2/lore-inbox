Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316941AbSE1VTy>; Tue, 28 May 2002 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316945AbSE1VTx>; Tue, 28 May 2002 17:19:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16649 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316941AbSE1VTv>; Tue, 28 May 2002 17:19:51 -0400
Date: Tue, 28 May 2002 23:19:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: fchabaud@free.fr
Cc: matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
Message-ID: <20020528211954.GD28189@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020527140111.G35@toy.ucw.cz> <200205282113.g4SLD6n05000@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
> >> > is blocked?"
> >> > 
> >> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
> >> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
> >> > "Probem while suspending", then some "Resume" and finally the panic.
> >> > 
> >> > It may be worth noting that one swap partition is on a SCSI drive, and
> >> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
> >> > motors were stopped.
> >> > 
> >> 
> >> AFAIK swap partition under SCSI is not supported for the moment.
> > 
> >  can you elaborate? swsusp ddoes not careif it is scsi on ide and I had it
> > running on usb-storage device at one point.
> > 								Pavel
> > 
> 
> Well we haven't the equivalent to ide_disk_(un)suspend. I agree that
> this should be sufficient to make it work, but SCSI may be a little more
> difficult to patch.

Yup, right. Right way to do that is using pci power interface. It
hopefully is strong enough to do that in 2.4, and it will magically
work in 2.5 too.

But for that usb-storage, usb already contains pm-related code, so it
should just work.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
