Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280667AbRKSTps>; Mon, 19 Nov 2001 14:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKSTpc>; Mon, 19 Nov 2001 14:45:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:19730 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280663AbRKSToP>; Mon, 19 Nov 2001 14:44:15 -0500
Date: Mon, 19 Nov 2001 16:26:26 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <20011119133032.C1439@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.21.0111191625280.7451-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Ken Brownfield wrote:

> Actually, I spoke too soon.  We developed a quick stress test that
> causes the problem immediately:
> 
>  11:18am  up 3 days,  1:36,  3 users,  load average: 8.72, 7.18, 3.96
> 91 processes: 85 sleeping, 6 running, 0 zombie, 0 stopped
> CPU states:  0.1% user, 93.4% system,  0.0% nice,  6.4% idle
> Mem:  3343688K av, 3340784K used,    2904K free,       0K shrd,     308K buff
> Swap: 1004052K av,  567404K used,  436648K free                 2994288K cached
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
> 12102 oracle    13   0 16320  15M 14868 R    5584 67.2  0.4  18:58 oracle
> 12365 oracle    18   5 39352  38M 37796 R N   30M 66.7  1.1   4:14 oracle
> 12353 oracle    18   5 39956  38M 38408 R N   31M 66.5  1.1   9:14 oracle
> 12191 root      13   0   892  852   672 R       0 66.4  0.0   6:09 top
> 12366 oracle     9   0   892  892   672 S       0 60.0  0.0   3:20 top
>     9 root       9   0     0    0     0 SW      0 49.0  0.0   9:27 kswapd
>    11 root       9   0     0    0     0 SW      0 38.3  0.0   3:58 kupdated
>   105 root       9   0     0    0     0 SW      0 28.8  0.0   4:56 kjournald
>   470 root       9   0   844  828   472 S       0 28.1  0.0   1:46 gamdrvd
> 12351 oracle    13   5 39956  38M 38408 S N   31M 25.6  1.1   3:08 oracle
>   669 oracle     9   0  4780 4780  4384 S     492 24.4  0.1   1:42 oracle
>     1 root      14   0   476  424   408 R       0 21.6  0.0   1:19 init
>     2 root      14   0     0    0     0 RW      0 20.8  0.0   1:29 keventd
>   615 oracle     9   0  8984 8984  8460 S    4380 16.3  0.2   2:41 oracle
>   388 root       9   0   732  728   592 S       0 11.5  0.0   0:17 syslogd
> 
> kswapd bounces up and down from 99%.

Ken,

Could you please check _where_ kswapd is spending its time ? 

(you can use kernel profiling and the "readprofile" tool to report us the
functions which are wasting more CPU cycles in the kernel)


