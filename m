Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273099AbRIWCpm>; Sat, 22 Sep 2001 22:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273102AbRIWCpc>; Sat, 22 Sep 2001 22:45:32 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:56347 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273099AbRIWCpS> convert rfc822-to-8bit; Sat, 22 Sep 2001 22:45:18 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: george anzinger <george@mvista.com>, Oliver Xymoron <oxymoron@waste.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109222120.f8MLKYG24859@zero.tech9.net>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
	<1001042255.7291.39.camel@phantasy> <3BAB614E.8600D074@mvista.com> 
	<200109222120.f8MLKYG24859@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 22:44:57 -0400
Message-Id: <1001213112.872.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 17:09, Dieter Nützel wrote:
> Yes, I do like I've posted in all the related threads.
> 
> Here is some more input for you. I hope it could help nail it down.
> 
> Regards,
> 	Dieter
> 
> BTW I'll now switching to 2.4.10-pre14
>
> SunWave1#time tar xIf /Pakete/Linux/linux-2.4.9.tar.bz2
> 34.570u 5.350s 0:47.84 83.4%    0+0k 0+0io 295pf+0w
> 
> I "hear" some have disk activities (disk trashing).
> 
> SunWave1#sync
> 
> Runs for ages!!!

It has to flush that whole tar job you just did, which it did in memory
:)

> User	 CPU  0%
> System	 CPU  0%
> Idle	 CPU 99%
> 
> So where did it wait???
> 
> Here comes what latencytimes show:
> 
> Worst 20 latency times of 5061 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
> 322263   reacqBKL        1  1375/sched.c         c01138b4   697/sched.c
> 216174        BKL        1    30/inode.c         c016b971    52/inode.c
> 158328        BKL        9   742/block_dev.c     c0144d51   697/sched.c

OK, these three are not acceptable...adding them to the "list".

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

