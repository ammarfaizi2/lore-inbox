Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSI3Ub3>; Mon, 30 Sep 2002 16:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbSI3Ub3>; Mon, 30 Sep 2002 16:31:29 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:60888 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261347AbSI3Ub2>;
	Mon, 30 Sep 2002 16:31:28 -0400
Message-ID: <1033418211.3d98b5e347574@kolivas.net>
Date: Tue,  1 Oct 2002 06:36:51 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39-mm1
References: <200209301941.41627.conman@kolivas.net> <3D98A7D0.8F07193F@digeo.com>
In-Reply-To: <3D98A7D0.8F07193F@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Here follow the contest v0.41 (http://contest.kolivas.net) results for
> > 2.5.39-mm1:
> > 
> > noload:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  67.71           98%             1.00
> > 2.5.38                  72.38           94%             1.07
> > 2.5.38-mm3              73.00           93%             1.08
> > 2.5.39                  73.17           93%             1.08
> > 2.5.39-mm1              72.97           94%             1.08
> 
> 2.4.19 achieves higher CPU occupancy - you're using `make -j4', so it
> could be a CPU scheduler artifact, or a disk readahead latency effect.
> 
> Is the kernel source in-cache for these runs?

Not cached. Swap should be empty and caches flushed prior to every load test.

> 
> > process_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  110.75          57%             1.64
> > 2.5.38                  85.71           79%             1.27
> > 2.5.38-mm3              96.32           72%             1.42
> > 2.5.39                  88.9            75%             1.33*
> > 2.5.39-mm1              99.0            69%             1.45*
> 
> Not sure what to make of this test.  We have a bunch of tasks
> sending data between each other across pipes while trying to
> build a kernel.
> 
> It could be that with 2.4.19, those piping processes got a lot
> more work done.
> 
> I'd be inclined to drop this test; not sure what it means.

Err yeah... 

>  
> > io_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  216.05          33%             3.19
> > 2.5.38                  887.76          8%              13.11
> > 2.5.38-mm3              105.17          70%             1.55
> > 2.5.39                  229.4           34%             3.4
> > 2.5.39-mm1              239.5           33%             3.4
> 
> I think I'll set fifo_batch to 16 again...
> 

And I'll happily benchmark it when you do.

Con.
