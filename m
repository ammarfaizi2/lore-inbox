Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbTBJLVu>; Mon, 10 Feb 2003 06:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBJLVu>; Mon, 10 Feb 2003 06:21:50 -0500
Received: from [195.223.140.107] ([195.223.140.107]:6018 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267786AbTBJLVt>;
	Mon, 10 Feb 2003 06:21:49 -0500
Date: Mon, 10 Feb 2003 12:31:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: piggin@cyberone.com.au, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210113105.GX31401@dualathlon.random>
References: <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <20030210032101.5439d240.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210032101.5439d240.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:21:01AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Mon, Feb 10, 2003 at 09:40:34PM +1100, Nick Piggin wrote:
> > > I don't know too much about SCSI stuff, but if driver / wire / device
> > > overheads were that much higher at 128K compared to 512K I would
> > > think something is broken or maybe optimised badly.
> > 
> > I guess it's also a matter of the way the harddisk can serve the I/O if
> > it sees it all at the same time, not only the cpu/bus protocol after all
> > minor overhead.  Most certainly it's not a software mistake in linux
> > that the big commands runs that much faster. Again go check the numbers
> > in bigbox.html between my tree, 2.4 and 2.5 in bonnie read sequential,
> > to see the difference between 128k commands and 512k commands with
> > reads, these are facts.  (and no writes and no seeks here)
> > 
> 
> I thought scsi in 2.5 was doing 512k I/O's at present???
> 
> Doesn't Randy attribute the differences there to an updated
> qlogic driver?   (Or was the update to allow 512k I/O's? ;))

The special case of the qlogic that Randy is using does 256k commands
with the new driver.

Andrea
