Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274177AbRITCdi>; Wed, 19 Sep 2001 22:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274186AbRITCd1>; Wed, 19 Sep 2001 22:33:27 -0400
Received: from [209.195.52.30] ([209.195.52.30]:30222 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S274177AbRITCdL>;
	Wed, 19 Sep 2001 22:33:11 -0400
Date: Wed, 19 Sep 2001 18:13:14 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: safemode <safemode@speakeasy.net>
cc: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <20010920022305Z272886-760+14371@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0109191811540.7181-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also how useful is the latency info once swapping starts? if you have
something that gets swapped out it will have horrible latency and skew the
results (or at the very least you won't know if the problem is disk IO or
fixable problems)

David Lang

 On Wed, 19 Sep 2001, safemode wrote:

> Date: Wed, 19 Sep 2001 22:23:21 -0400
> From: safemode <safemode@speakeasy.net>
> To: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
>      linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Preemption Latency Measurement Tool
>
> Is it possible to run the 20 worsst latency thing without having the pre-empt
> patch ?  I'd like to see how things run without the preempt patch and which
> ones are the slowest.   The last time i used the pre-empt patch i had worse
> audio performance than not.  Perhaps that's because i use alsa.
>
>
>
> On Wednesday 19 September 2001 21:40, Ignacio Vazquez-Abrams wrote:
> > I'm posting this in the hope that someone will find it useful.
> >
> > Worst 20 latency times of 4647 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/file
> >  35735  spin_lock        1   358/memory.c        c012c74a   379/memory.c
> >  14003  spin_lock        1   341/vmscan.c        c013977b   362/vmscan.c
> >  13701  spin_lock        1  1376/sched.c         c0118ef9   697/sched.c
> >  12533        BKL        7  2689/buffer.c        c0149acc   697/sched.c
> >  12459  spin_lock        7   547/sched.c         c0116ca3   697/sched.c
> >  10479  spin_lock        1   703/vmscan.c        c013a213   685/vmscan.c
> >  10443  spin_lock        1   669/inode.c         c015e8dd   696/inode.c
> >   9163   reacqBKL        1  1375/sched.c         c0118edb  1381/sched.c
> >   8727        BKL        9   164/inode.c         c0171885   188/inode.c
> >   8066   usb-uhci        d    76/softirq.c       c0120cf2   119/softirq.c
> >   8041        BKL        9   130/attr.c          c015fbd4   143/attr.c
> >   7982  spin_lock        8   547/sched.c         c0116ca3   204/namei.c
> >   6920   reacqBKL        5  1375/sched.c         c0118edb   697/sched.c
> >   6720  spin_lock        0  1376/sched.c         c0118ef9  1380/sched.c
> >   6567  spin_lock        0   661/vmscan.c        c013a0f2   764/vmscan.c
> >   6365  spin_lock        0   703/vmscan.c        c013a213   764/vmscan.c
> >   5680        BKL        1   452/exit.c          c011f6c6   697/sched.c
> >   5646  spin_lock        0   227/inode.c         c015df35   696/inode.c
> >   5428  spin_lock        1   710/inode.c         c015ea08   696/inode.c
> >   4933  spin_lock        0   547/sched.c         c0116ca3  1380/sched.c
> >
> > This was taken after compiling several packages and running dbench a few
> > times.
> >
> > I also ran it previously while running 'while true ; do python -c
> > range\(3e7\) ; done', and the first line had minimum latencies of 10000,
> > going as high as about 96000 when swapping.
> >
> > This is on an Athlon 1050/100 Asus A7V (KT133) with PC133 CL2 SDRAM running
> > 2.4.9-ac12-preempt1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
