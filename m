Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbUKXPqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbUKXPqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbUKXPpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:45:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42400 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262760AbUKXPnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:43:31 -0500
Date: Wed, 24 Nov 2004 16:05:20 +0100
From: Jens Axboe <axboe@suse.de>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: status of cdrom patches for 2.4 ?
Message-ID: <20041124150520.GG13847@suse.de>
References: <41A3C391.8070609@ttnet.net.tr> <20041124074336.GB8718@logos.cnet> <20041124125319.GB13847@suse.de> <41A49DA5.9090900@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A49DA5.9090900@ttnet.net.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, O.Sezer wrote:
> Jens Axboe wrote:
> >On Wed, Nov 24 2004, Marcelo Tosatti wrote:
> >
> >>On Wed, Nov 24, 2004 at 01:11:13AM +0200, O.Sezer wrote:
> >>
> >>>Hi all:
> >>>
> >>>What are the status of the cdrom patches for 2.4 series?
> >>>Namely the dvd patches which are dropped while in the
> >>>27-rc era, and the cd-mrw patch which never had a chance
> >>>trying to go in to 2.4. Jens? Mancelo?
> >>
> >>There were problems with the DVD-RW patches so I reverted them.
> 
> Yup.  Pat then posted a patch which supposedly fixed it by placing
> something like
> 	else if (CDROM_CAN(CDC_DVD_RAM))
> 		ret = 0;
> in cdrom_open_write():
> http://marc.theaimsgroup.com/?t=109156838400001&r=1&w=2
> http://marc.theaimsgroup.com/?l=linux-scsi&m=109156820507518&w=2
> 
> Jens' MRW patch also introduces a new function: cdrom_dvdram_open_write
> (which, in turn, calls cdrom_media_erasable), CDROM_CAN(CDC_DVD_RAM)
> check in cdrom_open_write() is assigned to it; which again is supposed
> to fix it.

Fix that issue. More might crop up.

> >>Jens, what do you think?
> >
> >
> >I don't think it's worth the bother, the support is in 2.6. And I don't
> >want to maintain new atapi stuff for 2.4. Pat used to care about the
> >patches, but as he is no longer with Iomega I don't think there's anyone
> >to look after it.
> 
> Which is truly a pity. Yes I can understand that a maintainer needs
> to concentrate on new trees etc, but it's pity.  Especially hearing
> the pre-recorded "Hey 2.6 already has it, upgrade to it" message is
> always nice ;)

You conveniently ignore that 2.4 is in bug fix mode, and a strict one
now even. And then you want to add new features to a driver that is both
used on almost every machine and also drives the most picky and buggy
hardware out there? So please can the 'pre-recorded' message crap. You
are not the one that will have to pick up the pieces if something
breaks.

-- 
Jens Axboe

