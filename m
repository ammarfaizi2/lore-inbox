Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTBJLc2>; Mon, 10 Feb 2003 06:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTBJLc2>; Mon, 10 Feb 2003 06:32:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:62941 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263899AbTBJLc1>;
	Mon, 10 Feb 2003 06:32:27 -0500
Date: Mon, 10 Feb 2003 03:42:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hans Reiser <reiser@namesys.com>
Cc: andrea@suse.de, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210034220.75710fc3.akpm@digeo.com>
In-Reply-To: <3E478C39.602@namesys.com>
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
	<3E478C39.602@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 11:42:05.0804 (UTC) FILETIME=[6FA0D2C0:01C2D0F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> Is it true that there is no manpage available anywhere for fadvise?
> 

It's pretty simple.

http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html

It's also basically unimplementable without the radix tree, so I don't how
other systems can be doing it.  Maybe they just lock up for a day when
someone does fadvise64(fd, 0, -1, FADV_DONTNEED) ;)

