Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWBSA3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWBSA3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWBSA3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:29:24 -0500
Received: from smtp.enter.net ([216.193.128.24]:13841 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932369AbWBSA3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:29:23 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sat, 18 Feb 2006 19:29:30 -0500
User-Agent: KMail/1.8.1
Cc: Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
References: <43D7AF56.nailDFJ882IWI@burner> <200602171902.11631.dhazelton@enter.net> <43F751B0.1040101@tmr.com>
In-Reply-To: <43F751B0.1040101@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181929.32026.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 11:56, Bill Davidsen wrote:
> D. Hazelton wrote:
> >On Friday 17 February 2006 16:35, Bill Davidsen wrote:
> >>Daniel Barkalow wrote:
> >>>I don't think it needs to be a class, but I think that there should be a
> >>>single place with a directory for each device that could be what you
> >>>want, with a file that tells you if it is. That's why I was looking at
> >>>block/; these things must be block devices, and there aren't an huge
> >>>number of block devices.
> >>>
> >>>I suppose "grep 1 /sys/block/*/device/dvdwriter" is just as good; I
> >>>hadn't dug far enough in to realize that the reason I wasn't seeing
> >>>anything informative in /sys/block/*/device/ was that I didn't have any
> >>>devices with informative drivers, not that it was actually supposed to
> >>>only have links to other things.
> >>
> >>It would be nice to have one place to go to find burners, and to have
> >>the model information in that place. I would logically think that place
> >>is sysfs, and I know the kernel has the information because if I root
> >>through /proc/bus/usb and /proc/scsi/scsi, and /proc/ide/hd?/model I can
> >>eventually find out what the system has connected.
> >>
> >>I not entirely sure about having classes other than cdrom, just because
> >>we already have CD, DVD, DVD-DL, and are about to add blue-ray and
> >>HD-DVD, so if I can tell that it's a removable device which can read
> >>CDs, the applications have a fighting chance to looking at the device to
> >>see what it is. As a human I would like the model information because
> >>the kernel has done the work, why should people have to chase it when it
> >>could be in one place?
> >
> >The problem is that drives don't always cleanly report what they are in a
> >simple to access format. All SCSI and ATAPI drives provide a model,
> >manufacturer and serial number but usually the type of drive is buried
> > within the Model field, and that has a lot of variations.
> >
> >(I have personally seen CD/CDRW, CD-ROM, CD-RW, CDR, CDRW and DVD/CDROM)
> >
> >Now what could be done is that said information could be exported to
> > sysfs. Given the time I could probably manage the patch myself, but I'm
> > currently overextended with the number of projects I have underway.
>
> I would think that the model, manufacturer and serial would be useful,
> and just the indication that the device was CD capable would be a huge
> gain. There are at least two more type of drive coming soon in the 25GB
> media race, so identification could legitimately be left to the
> application as long as all CD-like devices can easily be identified for
> examination.
>
> Does that fit with your level of available time (and interest in
> resolving this issue)?

seems straightforward enough. May take me a bit, since I'll need to see what 
has to be done in order to make the information necessary, but I think it 
could all be resolved with calls to the routines the ioctl's normally access.

DRH

(and I think that theres even more information available, from the 
capabilities mode page, but I'm unsure as to how to access that)
