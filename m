Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRKXUVn>; Sat, 24 Nov 2001 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRKXUVe>; Sat, 24 Nov 2001 15:21:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22543 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279798AbRKXUVU>; Sat, 24 Nov 2001 15:21:20 -0500
Date: Sat, 24 Nov 2001 17:03:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Peter Jay Salzman <p@dirac.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd and system response
In-Reply-To: <20011124121231.A2062@dirac.org>
Message-ID: <Pine.LNX.4.21.0111241703090.12066-100000@freak.distro.conectiva>
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
> i thought i'd post it to lkml to let someone know that there's a problem.
> i'm not subscribed to the list, so if there's anything else i can do to help
> diagnose what's going on next time it happens, please cc me.
> 
> i feel like such a loser when i reboot.   ;)   i heard that 2.4.15 was just
> released, so i'll try upgrading to that and see if it helps any.

Don't use 2.4.15: it may corrupt your filesystem.

I just released 2.4.16-pre1 which has a fix for this problem...

Please try it and tell us if you still see the kswapd problems.

