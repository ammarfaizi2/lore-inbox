Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268591AbTBYWCW>; Tue, 25 Feb 2003 17:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268592AbTBYWCW>; Tue, 25 Feb 2003 17:02:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:3252 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268591AbTBYWCR>;
	Tue, 25 Feb 2003 17:02:17 -0500
Date: Tue, 25 Feb 2003 14:09:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-Id: <20030225140918.197dea73.akpm@digeo.com>
In-Reply-To: <20030225125942.GA1657@rushmore>
References: <20030225125942.GA1657@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 22:12:26.0275 (UTC) FILETIME=[FA94F730:01C2DD1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> >> Why does 2.5.62-mm2 have higher sequential
> >> write latency than 2.5.61-mm1?
> 
> > And there are various odd interactions in, at least, ext3.  You did not
> > specify which filesystem was used.
> 
> ext2
> 
> >>                     Thr  MB/sec   CPU%     avg lat      max latency
> >> 2.5.62-mm2-as         8   14.76   52.04%     6.14        4.5
> >> 2.5.62-mm2-dline      8    9.91   13.90%     9.41         .8
> >> 2.5.62-mm2            8    9.83   15.62%     7.38      408.9
> 
> > Fishiness.  2.5.62-mm2 _is_ 2.5.62-mm2-as.  Why the 100x difference?
> 
> Bad EXTRAVERSION naming on my part.  2.5.62-mm2 _was_ booted with 
> elevator=cfq.
> 
> ...
> > That 408 seconds looks suspect.
> 
> AFAICT, that's the one request in over 500,000 that took the longest.
> The numbers are fairly consistent.  How relevant they are is debatable.  

OK.  When I was testing CFQ I saw some odd behaviour, such as a 100%
cessation of reads for periods of up to ten seconds.

So there is some sort of bug in there, and until that is understood we should
not conclude anything at all about CFQ from this testing.

> 2.5.62-mm3 or 2.5.63-mm1?  (-mm3 is running now)

Well I'm showing about seven more AS patches since 2.5.63-mm1 already, so
this is a bit of a moving target.  Sorry.


