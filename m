Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318405AbSGYKgc>; Thu, 25 Jul 2002 06:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318406AbSGYKgc>; Thu, 25 Jul 2002 06:36:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318405AbSGYKgb>;
	Thu, 25 Jul 2002 06:36:31 -0400
Date: Thu, 25 Jul 2002 12:39:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020725103940.GA8761@suse.de>
References: <20020721152804.GA6273@www.kroptech.com> <20020724133959.GD5159@suse.de> <20020725003235.GA5345@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725003235.GA5345@www.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Adam Kropelin wrote:
> > On Sun, Jul 21 2002, Adam Kropelin wrote:
> > > The cpqarray driver seems to have been broken around 2.5.19 with the
> > > blk_start_queue/blk_stop_queue changes. As-is, cpqarray deadlocks the entire
> 
> On Wed, Jul 24, 2002 at 03:39:59PM +0200, Jens Axboe wrote:
> > Thanks for the report. Could you just kill the spin_lock/unlock in
> > blk_stop_queue() in drivers/block/ll_rw_blk.c and see if it works?
> 
> Hi, Jens,
> 
> I killed the spin_lock/unlock as you directed (and made no other changes
> to the tree). Result is the same as before: hard lock on partition detect.
> The first time I tried it I got an oops but didn't have the serial console
> up so it didn't get captured. (Stupid, stupid) Subsequent attempts have just
> the hard lock with no oops.

Could you please repeat the expirement with the 2.5.28 just released,
and record any oopses :-)

-- 
Jens Axboe

