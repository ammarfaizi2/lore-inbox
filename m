Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266781AbRGKVGV>; Wed, 11 Jul 2001 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbRGKVGL>; Wed, 11 Jul 2001 17:06:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42737 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266780AbRGKVGG>; Wed, 11 Jul 2001 17:06:06 -0400
Date: Wed, 11 Jul 2001 14:05:54 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Dipankar Sarma <dipankar@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711140554.A27815@us.ibm.com>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711090257.B27097@us.ibm.com> <20010711212022.H712@suse.de> <20010712014328.A14094@in.ibm.com> <20010711221719.P712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010711221719.P712@suse.de>; from axboe@suse.de on Wed, Jul 11, 2001 at 10:17:19PM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Thu, Jul 12 2001, Dipankar Sarma wrote:
> > On Wed, Jul 11, 2001 at 09:20:22PM +0200, Jens Axboe wrote:
> > > True. In theory it would be possible to do request slot stealing from
> > > idle queues, in fact it's doable without adding any additional overhead
> > > to struct request. I did discuss this with [someone, forgot who] last
> > > year, when the per-queue slots where introduced.
> > > 
> > > I'm not sure I want to do this though. If you have lots of disks, then
> > > yes there will be some wastage if they are idle. IMO that's ok. What's
> > > not ok and what I do want to fix is that slower devices get just as many
> > > slots as a 15K disk for instance. For, say, floppy or CDROM devices we
> > > really don't need to waste that much RAM. This will change for 2.5, not
> > > before.
> > 
> > Unless there is some serious evidence substantiating the need for
> > stealing request slots from other devices to avoid starvation, it
> > makes sense to avoid it and go for a simpler scheme. I suspect that device
> > type based slot allocation should just suffice.
> 
> My point exactly. And typically, if you have lots of queues you have
> lots of RAM. A standard 128meg desktop machine does not waste a whole
> lot.

I would vote for the simpler approach of slots. :-).

> 
> -- 
> Jens Axboe

-- 
Michael Anderson
mike.anderson@us.ibm.com

