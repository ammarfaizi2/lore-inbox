Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJ2JFa>; Tue, 29 Oct 2002 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJ2JF3>; Tue, 29 Oct 2002 04:05:29 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:29064 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S261693AbSJ2JF2>;
	Tue, 29 Oct 2002 04:05:28 -0500
Message-ID: <1035882708.3dbe50d48e92f@kolivas.net>
Date: Tue, 29 Oct 2002 20:11:48 +1100
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.44-mm6 contest results
References: <1035855807.3dbde7bf1bda8@kolivas.net> <3DBE2EBE.DC860105@digeo.com>
In-Reply-To: <3DBE2EBE.DC860105@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.44 [3]              873.8   9       69      12      12.24
> > 2.5.44-mm1 [3]          347.3   22      35      15      4.86
> > 2.5.44-mm2 [3]          294.2   28      19      10      4.12
> > 2.5.44-mm4 [3]          358.7   23      25      10      5.02
> > 2.5.44-mm5 [4]          270.7   29      18      11      3.79
> > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> 
> Jens, I think I prefer fifo_batch=16.  We do need to expose
> these in /somewhere so people can fiddle with them.
> 
> >...
> > mem_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.44 [3]              114.3   67      30      2       1.60
> > 2.5.44-mm1 [3]          159.7   47      38      2       2.24
> > 2.5.44-mm2 [3]          116.6   64      29      2       1.63
> > 2.5.44-mm4 [3]          114.9   65      28      2       1.61
> > 2.5.44-mm5 [4]          114.1   65      30      2       1.60
> > 2.5.44-mm6 [3]          226.9   33      50      2       3.18
> > 
> > Mem load has dropped off again
> 
> Well that's one interpretation.  The other is "goody, that pesky
> kernel compile isn't slowing down my important memory-intensive
> whateveritis so much".  It's a tradeoff.
> 
> It appears that this change was caused by increasing the default
> value of /proc/sys/vm/page-cluster from 3 to 4.  I am surprised.
> 
> It was only of small benefit in other tests so I'll ditch that one.

I understand the trade off issue. Since make -j4 bzImage is 4 cpu hungry
processes, ideally I'm guessing mem_load should only extend the duration and
drop the cpu by 25%.

> (You're still testing with all IO against the same disk, yes?  Please
> rememeber that things change quite significantly when the swap IO
> or the io_load is against a different device)

Yes I am. Sorry I just dont have the hardware to do anything else.

Con
