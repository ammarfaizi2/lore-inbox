Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279992AbRKXUtX>; Sat, 24 Nov 2001 15:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRKXUtO>; Sat, 24 Nov 2001 15:49:14 -0500
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:3986 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id <S279992AbRKXUtF>; Sat, 24 Nov 2001 15:49:05 -0500
Date: Sat, 24 Nov 2001 15:48:24 -0500 (EST)
From: Ahmed Masud <masud@marauder.googgun.com>
To: Peter Jay Salzman <p@dirac.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd and system response
In-Reply-To: <20011124121231.A2062@dirac.org>
Message-ID: <Pine.LNX.4.33.0111241535160.3541-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Peter Jay Salzman wrote:

> hi there,
>
> every so often, my system (2.4.13 smp) gets really sloooooow.   a typical top
> looks something like:
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>     5 root      14   0     0    0     0 RW   99.9  0.0   7:52 kswapd
>     7 root       9   0     0    0     0 SW    1.9  0.0   0:04 kupdated
>  2053 root      13   0   984  984   776 R     0.7  0.4   0:01 top
>  2063 p          9   0  2080 2080  1292 S     0.3  0.9   0:00 vim
>
> kswapd is definitely not behaving correctly.
>
> the thing that brought it on this time was gtv (an mpeg viewer which uses
> sdl) bailed on me.   X "kind of" froze, so i killed it.  but that's only the
> cause this time around.  last time, it happened between the time of going to
> bed and waking up (ie- the system was pretty much idling from a user's pov).
>
> this has been happening with the 2.4.13 kernel every couple of days.
>

Hello

I have experienced similar behaviour with kswapd/kupdated with 2.4.12 and
2.4.13 .  After much struggle, I discovered that the system had become
slugish and non-responsive because i was using the wrong IDE busmastering
and DMA drivers (VIA chipset) instead of the correct ones for my
motherboard (PROMISE chipset). If you are using IDE, then perhaps you have
something similar and are using the incorrect drivers?

If you are indeed using IDE then suggest that you turn of busmastering all
together and give it another try.

Ahmed.

