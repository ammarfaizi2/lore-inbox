Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWBRAB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWBRAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWBRAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:01:56 -0500
Received: from smtp.enter.net ([216.193.128.24]:54795 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751805AbWBRAB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:01:56 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 17 Feb 2006 19:02:10 -0500
User-Agent: KMail/1.8.1
Cc: Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
References: <43D7AF56.nailDFJ882IWI@burner> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com>
In-Reply-To: <43F641A2.50200@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171902.11631.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 16:35, Bill Davidsen wrote:
> Daniel Barkalow wrote:
> > I don't think it needs to be a class, but I think that there should be a
> > single place with a directory for each device that could be what you
> > want, with a file that tells you if it is. That's why I was looking at
> > block/; these things must be block devices, and there aren't an huge
> > number of block devices.
> >
> > I suppose "grep 1 /sys/block/*/device/dvdwriter" is just as good; I
> > hadn't dug far enough in to realize that the reason I wasn't seeing
> > anything informative in /sys/block/*/device/ was that I didn't have any
> > devices with informative drivers, not that it was actually supposed to
> > only have links to other things.
>
> It would be nice to have one place to go to find burners, and to have
> the model information in that place. I would logically think that place
> is sysfs, and I know the kernel has the information because if I root
> through /proc/bus/usb and /proc/scsi/scsi, and /proc/ide/hd?/model I can
> eventually find out what the system has connected.
>
> I not entirely sure about having classes other than cdrom, just because
> we already have CD, DVD, DVD-DL, and are about to add blue-ray and
> HD-DVD, so if I can tell that it's a removable device which can read
> CDs, the applications have a fighting chance to looking at the device to
> see what it is. As a human I would like the model information because
> the kernel has done the work, why should people have to chase it when it
> could be in one place?

The problem is that drives don't always cleanly report what they are in a 
simple to access format. All SCSI and ATAPI drives provide a model, 
manufacturer and serial number but usually the type of drive is buried within 
the Model field, and that has a lot of variations.

(I have personally seen CD/CDRW, CD-ROM, CD-RW, CDR, CDRW and DVD/CDROM)

Now what could be done is that said information could be exported to sysfs. 
Given the time I could probably manage the patch myself, but I'm currently 
overextended with the number of projects I have underway.

DRH
