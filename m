Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSKFX6a>; Wed, 6 Nov 2002 18:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266235AbSKFX6a>; Wed, 6 Nov 2002 18:58:30 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:50941 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266233AbSKFX63>;
	Wed, 6 Nov 2002 18:58:29 -0500
Date: Wed, 6 Nov 2002 19:05:03 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021107000503.GA1243@www.kroptech.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com> <20021106101144.A10985@eng2.beaverton.ibm.com> <20021106233325.GA29940@www.kroptech.com> <20021106155235.A17479@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106155235.A17479@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 03:52:35PM -0800, Patrick Mansfield wrote:
> On Wed, Nov 06, 2002 at 06:33:25PM -0500, Adam Kropelin wrote:
> > On Wed, Nov 06, 2002 at 10:11:44AM -0800, Patrick Mansfield wrote:
> 
> > > What queue depth is the AIC setting?
> > > 
> > > SCSI in 2.5.x no longer copies the request, so if you have a queue
> > > depth larger than the allocated requests there might not be
> > > any free requests left for the blk layer to play with.
> > > 
> > > AIC default queue depth is 253 (with 2.5.46 queue depth can be set to 1
> > 
> > Are you talking tcq depth here? Best as I can tell, 2.5.46 defaults to
> > 16. Lowering it to 2 doesn't seem to help.
> 
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000

Ok, that is indeed the setting I was changing. I've been carrying this
same .config with my for $BIGNUM kernel versions so I must have lowered
it to 16 sometime in the past.

Even setting queue depth to 1 didn't affect the cdrecord problem.

--Adam
