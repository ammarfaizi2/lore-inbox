Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTAEU3v>; Sun, 5 Jan 2003 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbTAEU3v>; Sun, 5 Jan 2003 15:29:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:38285 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265074AbTAEU3v>;
	Sun, 5 Jan 2003 15:29:51 -0500
Message-ID: <3E1897B8.7688566B@digeo.com>
Date: Sun, 05 Jan 2003 12:38:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: uaca@alumni.uv.es
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54-mm3
References: <3E16A2B6.A741AE17@digeo.com> <20030105180446.GA20388@pusa.informat.uv.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 20:38:19.0903 (UTC) FILETIME=[6203B8F0:01C2B4FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uaca@alumni.uv.es wrote:
> 
> On Sat, Jan 04, 2003 at 01:00:38AM -0800, Andrew Morton wrote:
> >
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/
> 
> It seems to me that the patch you pointed here doesn't include the latency
> instrumentation.

No, it doesn't.  You can monitor the latency using realfeel or realfeel2
from http://www.zip.com.au/~akpm/linux/amlat.tar.gz

But that won't tell you _why_ large latencies are occurring.   For that,
you'll need to apply
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/experimental/rtc-debug.patch
and run `amlat'.  This combination will spit out stack backtraces whenever
there is a 2 millisecond scheduling overrun.

> Where it is the needed instrumentation to meassure it?
> 
> In http://www.zip.com.au/~akpm/linux/ the are no timepeg/intlat patches for
> 2.5...

That's not suitable for this work.  intlat is OK for locating and
measuring interrupts-off code paths.   But it's a bit hard to drive.
