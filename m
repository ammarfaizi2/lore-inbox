Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSJOJ0x>; Tue, 15 Oct 2002 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSJOJ0x>; Tue, 15 Oct 2002 05:26:53 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:58632 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263991AbSJOJ0w>; Tue, 15 Oct 2002 05:26:52 -0400
Date: Tue, 15 Oct 2002 10:32:44 +0100
To: Jens Axboe <axboe@suse.de>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-lvm@sistina.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021015093244.GA3782@fib011235813.fsnet.co.uk>
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <1034614756.29775.5.camel@UberGeek.coremetrics.com> <20021014175608.GA14963@fib011235813.fsnet.co.uk> <20021015082152.GA4827@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015082152.GA4827@suse.de>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:21:52AM +0200, Jens Axboe wrote:
> On Mon, Oct 14 2002, Joe Thornber wrote:
> > 10.patch
> >   [Device-mapper]
> >   Add call to blk_queue_bounce() at the beginning of the request function.
> 
> What on earth for? I also see that you are setting BLK_BOUNCE_HIGH as
> the bounce limit unconditionally for your queue. Puzzled.

This is just me stupidly copying loop.c, already found out it doesn't
work.  Please ignore.

> When does dm even have to touch the data in the bio?

Tell me; if I'm splitting a bio using bio_clone, and then map the bio
to a driver that calls blk_queue_bounce.  How can I avoid the

        BUG_ON((*bio_orig)->bi_idx);

triggering ?  Or is bio_clone not to be used anymore ?

- Joe
