Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316962AbSEWRRH>; Thu, 23 May 2002 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316963AbSEWRRH>; Thu, 23 May 2002 13:17:07 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2462 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316962AbSEWRRE>; Thu, 23 May 2002 13:17:04 -0400
Date: Thu, 23 May 2002 11:16:53 -0600
Message-Id: <200205231716.g4NHGrT04526@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16+devfs+ide+scsi = Disaster! (data recovery tips requested)
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315082E17EE@berkeley.gci.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer writes:
> I now join the ranks of the "Damn, I should have double-checked my
> backups to make sure they were readable."
> 
> Booted into Linux last night to format a new IDE drive for a laptop.
> My thought was to clone the existing (SCSI) windows partition for my
> wife's laptop.  Then I could wipe the old partition after saving off
> my data and have one more dedicated linux box laying around.
> 
> Everything looked okay when I fdisk'd the drive and the formatted
> it with mkfs.vfat
> 
> That is, until I went to reboot.
> 
> Apparantly, there's a weird bug/race/conflict between devfs, scsi, and ide.
> 
> My CD/RW was on the IDE cable, which I had simply swapped out with the
> mini-HD.
> 
> after the realization of what must have happend, i dug a little deeper.
> fortunately lilo hadn't been wiped, and I did have linux on a second (scsi)
> drive,
> so I double-checked what devices it thought everthing was.
> 
> /dev/hda = block-device 8
> /dev/sda = block-device 8

This isn't supposed to happen, because the IDE and SCSI subsystems
hard-wire different major numbers when registering devices.

> umm... this is bad !!
> 
> the scsi-ide module was loaded (because of the CD/RW) and it seems that
> the combination of a hard-drive + scsi-ide and devfs just layed over the
> top of the existing config.

Has anyone responded to you yet?

> My kernel is 2.4.16.  I can provide more information later, if requested.

That's a pretty old kernel. Upgrade to 2.4.19-pre8 and see if the same
thing happens.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
