Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULMQrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULMQrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbULMQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:47:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38058 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261271AbULMQrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:47:08 -0500
Date: Mon, 13 Dec 2004 17:46:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, nickpiggin@yahoo.com.au
Subject: Re: IO Priorities
Message-ID: <20041213164625.GX3033@suse.de>
References: <20041213142217.GA22853@optonline.net> <20041213143809.GO3033@suse.de> <20041213164325.GA26031@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213164325.GA26031@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13 2004, Jeff Sipek wrote:
> On Mon, Dec 13, 2004 at 03:38:10PM +0100, Jens Axboe wrote:
> > On Mon, Dec 13 2004, Jeff Sipek wrote:
> > > Hello all,
> > > 	About a week ago, I said I would try to implement IO priorities.
> > > I tried. I got the whole thing done, but there is one major problem - it
> > 
> > I did too, did you see my patch?
> 
> I did after I sent mine. I was reading it and I noticed:
> 
> "Disable TCQ in the hardware/driver by default. Can be changed (as
> always) with the max_depth setting. If you do that, don't expect
> fairness or priorities to work as well."
> 
> Would this cause my problem?

Only if you test on SCSI with TCQ enabled. But I already outlined what
your problems are even if you did.

> > Additionally, you don't do anything with the priorities internally.
> 
> Sure I do, I multiply the slice by cfq_prio_scale[ioprio]. It did seem
> too simple. :-) Looking at your code right now, I kind of see some code
> that should have been in my implementation as well. Back to coding...
> :-)

If you would base changes on what I already did with CFQ, that would be
handy. You need the CFQ bits anyways.

Updated patch here:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-11-2.6.10-rc3-mm1.gz

-- 
Jens Axboe

