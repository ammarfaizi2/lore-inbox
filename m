Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTBJLPX>; Mon, 10 Feb 2003 06:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTBJLPW>; Mon, 10 Feb 2003 06:15:22 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:12807 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267750AbTBJLPT>;
	Mon, 10 Feb 2003 06:15:19 -0500
Message-ID: <3E478C09.6060508@cyberone.com.au>
Date: Mon, 10 Feb 2003 22:24:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 09:40:34PM +1100, Nick Piggin wrote:
>
>>I don't know too much about SCSI stuff, but if driver / wire / device
>>overheads were that much higher at 128K compared to 512K I would
>>think something is broken or maybe optimised badly.
>>
>
>I guess it's also a matter of the way the harddisk can serve the I/O if
>it sees it all at the same time, not only the cpu/bus protocol after all
>minor overhead.  Most certainly it's not a software mistake in linux
>that the big commands runs that much faster. Again go check the numbers
>in bigbox.html between my tree, 2.4 and 2.5 in bonnie read sequential,
>to see the difference between 128k commands and 512k commands with
>reads, these are facts.  (and no writes and no seeks here)
>
Yes it is very clear from the numbers that your tree is more than
150% the speed for reads. As I said I don't know too much about
SCSI, but it is very interesting that writes don't get a noticable
improvement although they would be using the bigger request sizes
too, right? Something is causing this but the cpu, bus, wire
overhead of using small requests does not seem to be it.

Nick

