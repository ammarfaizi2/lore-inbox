Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTBJIJb>; Mon, 10 Feb 2003 03:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbTBJIJb>; Mon, 10 Feb 2003 03:09:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:62679 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264657AbTBJIJb>;
	Mon, 10 Feb 2003 03:09:31 -0500
Date: Mon, 10 Feb 2003 00:19:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: piggin@cyberone.com.au, jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210001921.3a0a5247.akpm@digeo.com>
In-Reply-To: <20030210080858.GM31401@dualathlon.random>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
	<20030209203343.06608eb3.akpm@digeo.com>
	<20030210045107.GD1109@unthought.net>
	<3E473172.3060407@cyberone.com.au>
	<20030210073614.GJ31401@dualathlon.random>
	<3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 08:19:08.0582 (UTC) FILETIME=[15703460:01C2D0DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> BTW, one thing that should definitely do readhaead and it's
> not doing that (at least in 2.4) is the readdir path, again to generate
> big commands, no matter the seeks.  It was lost with the directory in
> pagecache.

Yes.  But ext3 is still doing directory readahead, and I have never
noticed it gaining any particular benefit over ext2 from it.

And neither fs performs inode table readahead.
