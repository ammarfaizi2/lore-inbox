Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUEOTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUEOTbL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUEOTbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:31:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38608 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264686AbUEOTa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:30:26 -0400
Date: Sat, 15 May 2004 19:30:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slabify iocontext + request_queue
Message-ID: <20040515173004.GA962@suse.de>
References: <20040515190735.A4189@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515190735.A4189@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15 2004, Christoph Hellwig wrote:
> this just went in:
> 
> >  From: Jens Axboe <axboe@suse.de>
> > 
> > Move both request_queue and io_context allocation to a slab cache.
> > 
> > This is mainly a space-saving exercise.  Some setups have a lot of disks
> > and the kmalloc rounding-up can consume significant amounts of memory.
> 
> While I agree on the io_context part, slabifying request_queue is a space
> waste on most machines out there.  The averange desktop has less than a
> handfull of these, and even for smaller servers it doesn't exactly look
> like a gain.

See the thread last week on queue congestion threshold calculations,
there were some numbers in there.

-- 
Jens Axboe

