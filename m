Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319609AbSIMMET>; Fri, 13 Sep 2002 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319610AbSIMMET>; Fri, 13 Sep 2002 08:04:19 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49930 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319609AbSIMMET>; Fri, 13 Sep 2002 08:04:19 -0400
Date: Fri, 13 Sep 2002 08:01:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209121008160.26031-100000@boris.prodako.se>
Message-ID: <Pine.LNX.3.96.1020913075359.22464C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Tobias Ringstrom wrote:

> 3. More than 90% of all tasks in a system are classified as interactive at
>    any given time (since they are sleeping).  For example all cron jobs
>    are classified as interactive, which sounds really strange.  IMHO, it's
>    a good example of a non-interactive background job.  (I'll run my crond
>    at nice 19 for now.)
> 
>    I'm curious, why are you using the process average sleep time to
>    determine interactiveness and not the presense of prematurely abandoned
>    timeslices?

I'll ask that, too. Not because I doubt you have a good reason, but
because it doesn't jump out at me. I would like the CPU to go to the
process most likely to start an i/o and block, so the CPU hog can run
while the i/o takes place, because that seems to get the highest overlap
of CPU and i/o. I assume the current scheduler that as one of the goal,
clearly not the only one.

A few words of clarification would be educational.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

