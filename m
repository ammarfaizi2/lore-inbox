Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTBJLLK>; Mon, 10 Feb 2003 06:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbTBJLLK>; Mon, 10 Feb 2003 06:11:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:27357 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267443AbTBJLLJ>;
	Mon, 10 Feb 2003 06:11:09 -0500
Date: Mon, 10 Feb 2003 03:21:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: piggin@cyberone.com.au, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210032101.5439d240.akpm@digeo.com>
In-Reply-To: <20030210111017.GV31401@dualathlon.random>
References: <3E473172.3060407@cyberone.com.au>
	<20030210073614.GJ31401@dualathlon.random>
	<3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
	<20030210001921.3a0a5247.akpm@digeo.com>
	<20030210085649.GO31401@dualathlon.random>
	<20030210010937.57607249.akpm@digeo.com>
	<3E4779DD.7080402@namesys.com>
	<20030210101539.GS31401@dualathlon.random>
	<3E4781A2.8070608@cyberone.com.au>
	<20030210111017.GV31401@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 11:20:47.0399 (UTC) FILETIME=[75A3B370:01C2D0F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Mon, Feb 10, 2003 at 09:40:34PM +1100, Nick Piggin wrote:
> > I don't know too much about SCSI stuff, but if driver / wire / device
> > overheads were that much higher at 128K compared to 512K I would
> > think something is broken or maybe optimised badly.
> 
> I guess it's also a matter of the way the harddisk can serve the I/O if
> it sees it all at the same time, not only the cpu/bus protocol after all
> minor overhead.  Most certainly it's not a software mistake in linux
> that the big commands runs that much faster. Again go check the numbers
> in bigbox.html between my tree, 2.4 and 2.5 in bonnie read sequential,
> to see the difference between 128k commands and 512k commands with
> reads, these are facts.  (and no writes and no seeks here)
> 

I thought scsi in 2.5 was doing 512k I/O's at present???

Doesn't Randy attribute the differences there to an updated
qlogic driver?   (Or was the update to allow 512k I/O's? ;))
