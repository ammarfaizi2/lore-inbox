Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272658AbTG3C5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272661AbTG3C5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 22:57:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39945 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272658AbTG3C5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 22:57:05 -0400
Date: Tue, 29 Jul 2003 22:49:13 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Con Kolivas <kernel@kolivas.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
In-Reply-To: <200307290800.24003.kernel@kolivas.org>
Message-ID: <Pine.LNX.3.96.1030729224509.27753B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Con Kolivas wrote:

> On Tue, 29 Jul 2003 07:38, Bill Davidsen wrote:

> > It would seem to me that the lower limit for a given CPU is a function of
> > CPU speed and cache size. One reason for longer slices is to preserve the
> > cache, but the real time to get good use from the cache is not a constant,
> > and you just can't pick any one number which won't be too short on a slow
> > cpu or unproductively long on a fast CPU. Hyperthreading shrinks the
> > effective cache size as well, but certainly not by 2:1 or anything nice.
> >
> > Perhaps this should be a tunable set by a bit of hardware discovery at
> > boot and diddled at your own risk. Sure one factor in why people can't
> > agree on HZ and all to get best results.
> 
> Agreed, and no doubt the smaller the timeslice the worse it is. I did a little 
> experimenting with my P4 2.53 here and found that basically no matter how 
> much longer the timeslice was there was continued benefit. However the 
> benefit was diminishing the higher you got. If you graphed it out it was a 
> nasty exponential curve up to 7ms and then there was a knee in the curve and 
> it was virtually linear from that point on with only tiny improvements. A p3 
> 933 behaved surprisingly similarly. That's why on 2.4.21-ck3 it was running 
> with timeslice_granularity set to 10ms. However the round robin isn't as bad 
> as pure timeslice limiting because if they're still on the active array I am 
> led to believe there is less cache trashing. 
> 
> There was no answer in that but just thought I'd add what I know so far.

I think your agreement that one size doesn't fit all at least indicates
that hardware performance does enter into the settings. I'm disappointed
that you see no nice sharp "best value," but real data is better than
theory.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

