Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUEUHvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUEUHvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUEUHvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:51:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28117 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265433AbUEUHvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:51:41 -0400
Date: Fri, 21 May 2004 09:51:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: FabF <Fabian.Frederick@skynet.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
Message-ID: <20040521075129.GO1952@suse.de>
References: <1085124268.8064.15.camel@bluerhyme.real3> <40ADB20C.8090204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ADB20C.8090204@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21 2004, Nick Piggin wrote:
> FabF wrote:
> >Jens,
> >
> >	Here's ff1 patchset to have generic I/O context.
> >ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> >ff2 : Make io_context generic plateform by importing IO stuff from
> >as_io.
> >
> 
> Can I just ask why you want as_io_context in generic code?
> It is currently nicely hidden away in as-iosched.c where
> nobody else needs to ever see it.

I think (it's the only reason I can think of) that he is trying to make
the anticipation generic. Am I correct?

> >	AFAICS, cfq_queue for instance could disappear when using io_context
> >but I think elv_data should remain elevator side....
> >I don't want to go in the wild here so if you've got suggestions, don't
> >hesitate ;)
> >
> 
> cfq_queue is per-queue-per-process. io_context is just
> per-process, so it isn't a trivial replacement.

Definitely not, I struggled quite a bit with such a transformation in
cfq + ioprio.

-- 
Jens Axboe

