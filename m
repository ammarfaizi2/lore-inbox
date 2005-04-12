Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVDLLyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVDLLyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVDLLwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:52:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15122 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262361AbVDLLuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:50:07 -0400
Date: Tue, 12 Apr 2005 13:50:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ll_rw_blk.c: possible cleanups
Message-ID: <20050412115002.GA3631@stusta.de>
References: <20050410181321.GE4204@stusta.de> <20050411061233.GW22988@suse.de> <20050412020413.GC3828@stusta.de> <20050412054957.GF4722@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412054957.GF4722@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 07:49:57AM +0200, Jens Axboe wrote:
> On Tue, Apr 12 2005, Adrian Bunk wrote:
> > On Mon, Apr 11, 2005 at 08:12:34AM +0200, Jens Axboe wrote:
> > > On Sun, Apr 10 2005, Adrian Bunk wrote:
> > > > This patch contains the following possible cleanups:
> > > > - make needlessly global code static
> > > > - remove the following unused global functions:
> > > >   - blkdev_scsi_issue_flush_fn
> > > 
> > > Kill the function completely, it is not used anymore.
> > > 
> > > >   - __blk_attempt_remerge
> > > 
> > > Normally I would say leave that since it's part of the API, but lets
> > > just kill it. I don't envision any further users of the remerging
> > > attempts.
> > > 
> > > > - remove the following unused EXPORT_SYMBOL's:
> > > >   - blk_phys_contig_segment
> > > >   - blk_hw_contig_segment
> > > >   - blkdev_scsi_issue_flush_fn
> > > >   - __blk_attempt_remerge
> > > > 
> > > > Please review which of these changes make sense.
> > > 
> > > Looks fine to me, thanks. Can you send a new patch that kills
> > > blkdev_scsi_issue_flush_fn()?
> > 
> > I have a problem parsing your email.
> > 
> > Which parts of my patch are OK and which shouldn't be applied?
> > Or why do you want a separate blkdev_scsi_issue_flush_fn patch?
> 
> I have no problems with your patch, I would just like a revised patch
> that removes blkdev_scsi_issue_flush_fn completely instead since it is
> totally unused. It doesn't make sense to remove the export and make it
> static, since it isn't used internally (and never meant to, it's a
> helper function for drivers).

My patch does already completely remove blkdev_scsi_issue_flush_fn.

When I say "remove the following unused global functions:", this means 
the patch completely removes the function.

> Jens Axboe

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

