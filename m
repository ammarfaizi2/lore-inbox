Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSGYAaA>; Wed, 24 Jul 2002 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318201AbSGYAaA>; Wed, 24 Jul 2002 20:30:00 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:7412 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318105AbSGYA3a>;
	Wed, 24 Jul 2002 20:29:30 -0400
Date: Wed, 24 Jul 2002 20:32:35 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020725003235.GA5345@www.kroptech.com>
References: <20020721152804.GA6273@www.kroptech.com> <20020724133959.GD5159@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724133959.GD5159@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jul 21 2002, Adam Kropelin wrote:
> > The cpqarray driver seems to have been broken around 2.5.19 with the
> > blk_start_queue/blk_stop_queue changes. As-is, cpqarray deadlocks the entire

On Wed, Jul 24, 2002 at 03:39:59PM +0200, Jens Axboe wrote:
> Thanks for the report. Could you just kill the spin_lock/unlock in
> blk_stop_queue() in drivers/block/ll_rw_blk.c and see if it works?

Hi, Jens,

I killed the spin_lock/unlock as you directed (and made no other changes
to the tree). Result is the same as before: hard lock on partition detect.
The first time I tried it I got an oops but didn't have the serial console
up so it didn't get captured. (Stupid, stupid) Subsequent attempts have just
the hard lock with no oops.

--Adam
