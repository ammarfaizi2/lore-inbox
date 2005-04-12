Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVDLF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVDLF7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDLF4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:56:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11658 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262062AbVDLFxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:53:11 -0400
Date: Tue, 12 Apr 2005 07:49:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ll_rw_blk.c: possible cleanups
Message-ID: <20050412054957.GF4722@suse.de>
References: <20050410181321.GE4204@stusta.de> <20050411061233.GW22988@suse.de> <20050412020413.GC3828@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412020413.GC3828@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2005, Adrian Bunk wrote:
> On Mon, Apr 11, 2005 at 08:12:34AM +0200, Jens Axboe wrote:
> > On Sun, Apr 10 2005, Adrian Bunk wrote:
> > > This patch contains the following possible cleanups:
> > > - make needlessly global code static
> > > - remove the following unused global functions:
> > >   - blkdev_scsi_issue_flush_fn
> > 
> > Kill the function completely, it is not used anymore.
> > 
> > >   - __blk_attempt_remerge
> > 
> > Normally I would say leave that since it's part of the API, but lets
> > just kill it. I don't envision any further users of the remerging
> > attempts.
> > 
> > > - remove the following unused EXPORT_SYMBOL's:
> > >   - blk_phys_contig_segment
> > >   - blk_hw_contig_segment
> > >   - blkdev_scsi_issue_flush_fn
> > >   - __blk_attempt_remerge
> > > 
> > > Please review which of these changes make sense.
> > 
> > Looks fine to me, thanks. Can you send a new patch that kills
> > blkdev_scsi_issue_flush_fn()?
> 
> I have a problem parsing your email.
> 
> Which parts of my patch are OK and which shouldn't be applied?
> Or why do you want a separate blkdev_scsi_issue_flush_fn patch?

I have no problems with your patch, I would just like a revised patch
that removes blkdev_scsi_issue_flush_fn completely instead since it is
totally unused. It doesn't make sense to remove the export and make it
static, since it isn't used internally (and never meant to, it's a
helper function for drivers).

-- 
Jens Axboe

