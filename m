Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbTCGHy0>; Fri, 7 Mar 2003 02:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCGHy0>; Fri, 7 Mar 2003 02:54:26 -0500
Received: from pop.gmx.net ([213.165.65.60]:33747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261439AbTCGHyY>;
	Fri, 7 Mar 2003 02:54:24 -0500
Message-Id: <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 09:09:32 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303070842420.4572-100000@localhost.localdom
 ain>
References: <5.2.0.9.2.20030307075851.00cf5448@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:45 AM 3/7/2003 +0100, Ingo Molnar wrote:

>On Fri, 7 Mar 2003, Mike Galbraith wrote:
>
> > Weeeeell, FWIW my box (p3-500/128mb/rage128) disagrees.
>
>UP box, right?

Yes, p3/500 w. 128mb ram and rage128.

> > I can still barely control the box when a make -j5 bzImage is running
> > under X/KDE in one terminal and a vmstat (SCHED_RR) in another. I'm not
> > swapping, though a bit of idle junk does page out.  IOW, I think I'm
> > seeing serious cpu starvation.
>
>which precise scheduler are you using, BK-curr? And to see whether the
>problem is related to scheduling at all, could you try to renice X to -10?
>[this is not a solution, this is just a test to see the problem is
>scheduling related.]

I plugged your combo patch into virgin .64.

>is there any way we could exclude/isolate the VM as the source of
>interactivity problems? Eg. any chance to get more RAM into that box?

I can (could with your earlier patches anyway) eliminate the X stalls by 
setting X junk to SCHED_FIFO.  I don't have ram to plug in, but I'm as 
certain as I can be without actually doing so that it's not ram shortage.

Best would be for other testers to run some tests.  With the make -j30 
weirdness, I _suspect_ that other oddities (hmm... multi-client db load... 
query service time) will show.

         -Mike 

