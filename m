Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272886AbRITCXR>; Wed, 19 Sep 2001 22:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274010AbRITCXI>; Wed, 19 Sep 2001 22:23:08 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:25617 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S272886AbRITCW7>; Wed, 19 Sep 2001 22:22:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Wed, 19 Sep 2001 22:23:21 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109192135360.23588-100000@terbidium.openservices.net>
In-Reply-To: <Pine.LNX.4.33.0109192135360.23588-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920022305Z272886-760+14371@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to run the 20 worsst latency thing without having the pre-empt 
patch ?  I'd like to see how things run without the preempt patch and which 
ones are the slowest.   The last time i used the pre-empt patch i had worse 
audio performance than not.  Perhaps that's because i use alsa. 



On Wednesday 19 September 2001 21:40, Ignacio Vazquez-Abrams wrote:
> I'm posting this in the hope that someone will find it useful.
>
> Worst 20 latency times of 4647 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  35735  spin_lock        1   358/memory.c        c012c74a   379/memory.c
>  14003  spin_lock        1   341/vmscan.c        c013977b   362/vmscan.c
>  13701  spin_lock        1  1376/sched.c         c0118ef9   697/sched.c
>  12533        BKL        7  2689/buffer.c        c0149acc   697/sched.c
>  12459  spin_lock        7   547/sched.c         c0116ca3   697/sched.c
>  10479  spin_lock        1   703/vmscan.c        c013a213   685/vmscan.c
>  10443  spin_lock        1   669/inode.c         c015e8dd   696/inode.c
>   9163   reacqBKL        1  1375/sched.c         c0118edb  1381/sched.c
>   8727        BKL        9   164/inode.c         c0171885   188/inode.c
>   8066   usb-uhci        d    76/softirq.c       c0120cf2   119/softirq.c
>   8041        BKL        9   130/attr.c          c015fbd4   143/attr.c
>   7982  spin_lock        8   547/sched.c         c0116ca3   204/namei.c
>   6920   reacqBKL        5  1375/sched.c         c0118edb   697/sched.c
>   6720  spin_lock        0  1376/sched.c         c0118ef9  1380/sched.c
>   6567  spin_lock        0   661/vmscan.c        c013a0f2   764/vmscan.c
>   6365  spin_lock        0   703/vmscan.c        c013a213   764/vmscan.c
>   5680        BKL        1   452/exit.c          c011f6c6   697/sched.c
>   5646  spin_lock        0   227/inode.c         c015df35   696/inode.c
>   5428  spin_lock        1   710/inode.c         c015ea08   696/inode.c
>   4933  spin_lock        0   547/sched.c         c0116ca3  1380/sched.c
>
> This was taken after compiling several packages and running dbench a few
> times.
>
> I also ran it previously while running 'while true ; do python -c
> range\(3e7\) ; done', and the first line had minimum latencies of 10000,
> going as high as about 96000 when swapping.
>
> This is on an Athlon 1050/100 Asus A7V (KT133) with PC133 CL2 SDRAM running
> 2.4.9-ac12-preempt1.
