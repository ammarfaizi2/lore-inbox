Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbTCaGYt>; Mon, 31 Mar 2003 01:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTCaGYt>; Mon, 31 Mar 2003 01:24:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16608 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261412AbTCaGYs>;
	Mon, 31 Mar 2003 01:24:48 -0500
Date: Mon, 31 Mar 2003 08:35:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Message-ID: <20030331063548.GQ917@suse.de>
References: <20030330141404.GG917@suse.de> <3E8610EA.8080309@telia.com> <1048992365.13757.23.camel@localhost> <20030330141404.GG917@suse.de> <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31 2003, Mike Galbraith wrote:
> At 07:06 AM 3/31/2003 +1000, Con Kolivas wrote:
> >On Mon, 31 Mar 2003 00:14, Jens Axboe wrote:
> >> On Sat, Mar 29 2003, Robert Love wrote:
> >> > On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> >> > > Are you sure this should be called a bug? Basically X is an 
> >interactive
> >> > > process. If it now is "interactive for a priority -10 process" then 
> >it
> >> > > should be hogging the cpu time no? The priority -10 was a workaround
> >> > > for lack of interactivity estimation on the old scheduler.
> >> >
> >> > Well, I do not necessarily think that renicing X is the problem.  Just
> >> > an idea.
> >>
> >> I see the exact same behaviour here (systems appears fine, cpu intensive
> >> app running, attempting to start anything _new_ stalls for ages), and I
> >> definitely don't play X renice tricks.
> >>
> >> It basically made 2.5 unusable here, waiting minutes for an ls to even
> >> start displaying _anything_ is totally unacceptable.
> >
> >I guess I should have trusted my own benchmark that was showing this was 
> >worse
> >for system responsiveness.
> 
> I don't think it's really bad for system responsiveness.  I think the 

What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
ever used, it would be _embarassing_ to release a 2.6-test with such a
rudimentary flaw in it. IOW, a big show stopper.

> problem is just that the sample is too small.  The proof is that simply 
> doing sleep_time %= HZ cures most of my woes.  WRT contest and it's 

Irk, that sounds like a really ugly bandaid.

I'm wondering why the scheduler guys aren't all over this problem,
getting it fixed.

-- 
Jens Axboe

