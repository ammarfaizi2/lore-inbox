Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTBJM7f>; Mon, 10 Feb 2003 07:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267843AbTBJM7f>; Mon, 10 Feb 2003 07:59:35 -0500
Received: from [195.223.140.107] ([195.223.140.107]:47234 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267841AbTBJM7e>;
	Mon, 10 Feb 2003 07:59:34 -0500
Date: Mon, 10 Feb 2003 13:47:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210124747.GN31401@dualathlon.random>
References: <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au> <20030210120006.GC31401@dualathlon.random> <3E4796D5.7070009@cyberone.com.au> <20030210122248.GG31401@dualathlon.random> <3E479CE2.5090605@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E479CE2.5090605@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:36:50PM +1100, Nick Piggin wrote:
> in corner cases. Luckily it seems you don't need such
> infrastructure to demonstrate most anticipatory scheduler gains.

sure. I guess it would be most important to be allowed to leave
anticipatory scheduling enabled *always* even with very async-io
intensive workloads, so when you read a file with normal fileutiles you
still can take advantage of it for the most important places. Ideally in
this case where w/o the hint we might have to disable anticipatory
scheduling completely to get peak async-io performance, the non-hint
timeout could be zero (i.e. no stall at all) and the kernel would
understand and do the right thing

Andrea
