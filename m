Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267837AbTBJMR2>; Mon, 10 Feb 2003 07:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTBJMRV>; Mon, 10 Feb 2003 07:17:21 -0500
Received: from [195.223.140.107] ([195.223.140.107]:28546 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267834AbTBJMQ7>;
	Mon, 10 Feb 2003 07:16:59 -0500
Date: Mon, 10 Feb 2003 13:26:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210122618.GI31401@dualathlon.random>
References: <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <3E4792B7.5030108@cyberone.com.au> <20030210121018.GE31401@dualathlon.random> <3E4797B5.5010100@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4797B5.5010100@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:14:45PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 10:53:27PM +1100, Nick Piggin wrote:
> >
> >>Andrew Morton wrote:
> >>
> >>
> >>>Andrea Arcangeli <andrea@suse.de> wrote:
> >>>
> >>>
> >>>>It's the readahead in my tree that allows the reads to use the max scsi
> >>>>command size. It has nothing to do with the max scsi command size
> >>>>itself.
> >>>>
> >>>>
> >>>Oh bah.
> >>>
> >>>-               *max_ra++ = vm_max_readahead;
> >>>+               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;
> >>>
> >>>
> >>>Well of course that will get bigger bonnie numbers, for exactly the 
> >>>reasons
> >>>I've explained.  It will seek between files after every 512k rather than
> >>>after every 128k.
> >>>
> >>>
> >>Though Andrea did say it is a "single threaded" streaming read.
> >>
> >
> >yes, I pointed you to bonnie read sequential in bigbox.html, not
> >tiobench.
> >
> The same pattern is also observed with single threaded tiobench
> anyway.

yes, of course.

Andrea
