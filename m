Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbTGRPge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbTGRPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:30:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:35993 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268238AbTGRPWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:22:37 -0400
Message-Id: <5.2.1.1.2.20030718165530.01adacd0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 17:41:45 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.55.0307180630450.5077@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:46 AM 7/18/2003 -0700, Davide Libenzi wrote:
>On Fri, 18 Jul 2003, Mike Galbraith wrote:
>
> > At 03:12 PM 7/16/2003 -0700, Davide Libenzi wrote:
> >
> > >http://www.xmailserver.org/linux-patches/irman2.c
> > >
> > >and run it with different -n (number of tasks) and -b (CPU burn ms time).
> > >At the same time try to build a kernel for example. Then you will realize
> > >that interactivity is not the bigger problem that the scheduler has right
> > >now.
> >
> > I added an irman2 load to contest.  Con's changes 06+06.1 stomped it flat
> > [1].  irman2 is modified to run for 30s at a time, but with default 
> parameters.
>
>In my case I cannot even estimate the time. It takes 8:33 ususally to do a
>bzImage, and after 15 minutes I ctrl-c with only two lines printed in the
>console. If you consider the ratio between the total number of lines that
>a kernel build spits out, this couls have taken hours. Also, you might

Yeah, I noticed... it's a nasty little bugger.

>want also to try a low number of processes with a short burn, like the new
>patch seems to do to better hit mm players. Something like:
>
>irman2 -n 10 -b 40

If I hadn't done the restart after 30 seconds thing, I knew it would take 
ages.  I wanted something to see contrast, not a life sentence ;-)

>Guys, I'm saying this not because I do not appreciate the time Con is
>spending on it. I just hate to see time spent in the wrong priorities.
>Whatever super privileged sleep->burn pattern you code, it can be
>exploited w/out a global throttle for the CPU time assigned to interactive
>and non interactive tasks. This is Unix guys and it is used in multi-user
>environments, we cannot ship with a flaw like this.

(Oh, I agree that the problem is nasty.  I like fair scheduling a lot... 
when _I'm_ not the one starving things to death;)

         -Mike 

