Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSKFX0w>; Wed, 6 Nov 2002 18:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266219AbSKFX0w>; Wed, 6 Nov 2002 18:26:52 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:20733 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266218AbSKFX0u>;
	Wed, 6 Nov 2002 18:26:50 -0500
Date: Wed, 6 Nov 2002 18:33:25 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106233325.GA29940@www.kroptech.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com> <20021106101144.A10985@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106101144.A10985@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:11:44AM -0800, Patrick Mansfield wrote:
> On Wed, Nov 06, 2002 at 10:56:56AM -0500, Adam Kropelin wrote:
> > On Wed, Nov 06, 2002 at 08:22:23AM +0100, Jens Axboe wrote:
> > > On Tue, Nov 05 2002, Adam Kropelin wrote:
> > > > Still without coaster I tried one more thing...
> > > > 'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
> > > > did it in. ;) I'm running ext3 and the writeout load totally killed
> > > > burn, which isn't surprising. I was asking for it, I know. What happened
> > > 
> > > Really, this should work. The deadline scheduler should handle this just
> > > fine in fact. Which device is your burner and which device is the hard
> > > drive? It sounds like a bug.
> > 
> > Hard disk is sdc on onboard AIC7xxx.
> > Writer is hdc, the only device on the secondary onboard IDE channel.
> > All other disks (IDE & SCSI) were idle during the test.
> 
> What queue depth is the AIC setting?
> 
> SCSI in 2.5.x no longer copies the request, so if you have a queue
> depth larger than the allocated requests there might not be
> any free requests left for the blk layer to play with.
> 
> AIC default queue depth is 253 (with 2.5.46 queue depth can be set to 1

Are you talking tcq depth here? Best as I can tell, 2.5.46 defaults to
16. Lowering it to 2 doesn't seem to help.

> queue depth). You can modify .config, or pass boot/module options to
> lower it.

If I've misunderstood you, please clue me in and I'll give it a shot...

--Adam
