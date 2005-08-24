Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVHXBME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVHXBME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVHXBME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:12:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38367 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750805AbVHXBMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:12:03 -0400
Date: Wed, 24 Aug 2005 11:03:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824010346.GA1021@frodo>
References: <20050823123235.GG16461@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823123235.GG16461@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 02:32:36PM +0200, Jens Axboe wrote:
> Hi,
> 
> This is a little something I have played with. It allows you to see
> exactly what is going on in the block layer for a given queue. Currently
> it can logs request queueing and building, dispatches, requeues, and
> completions.

Ah, fabulous.  Thanks Jens!

> +	t.magic		= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
> +	t.sequence	= atomic_add_return(1, &bt->sequence);
> +	t.time		= sched_clock() / 1000;

Wouldn't it be better to pass out the highest precision available here
& then do the conversion in userspace instead?  I guess one might want
that little bit more for a RAM disk or something ... actually, talking
to one of the SGI people here with alot of experience on IRIX with a
similar facility, the msec resolution there is apparently sometimes an
issue already with fast storage.

cheers.

-- 
Nathan
