Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCaGtz>; Mon, 31 Mar 2003 01:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbTCaGtz>; Mon, 31 Mar 2003 01:49:55 -0500
Received: from pop.gmx.net ([213.165.64.20]:54380 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261427AbTCaGty>;
	Mon, 31 Mar 2003 01:49:54 -0500
Message-Id: <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 31 Mar 2003 09:05:44 +0200
To: Jens Axboe <axboe@suse.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Cc: Con Kolivas <kernel@kolivas.org>, Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030331063548.GQ917@suse.de>
References: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
 <20030330141404.GG917@suse.de>
 <3E8610EA.8080309@telia.com>
 <1048992365.13757.23.camel@localhost>
 <20030330141404.GG917@suse.de>
 <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:35 AM 3/31/2003 +0200, Jens Axboe wrote:
>On Mon, Mar 31 2003, Mike Galbraith wrote:
> > At 07:06 AM 3/31/2003 +1000, Con Kolivas wrote:
> > >On Mon, 31 Mar 2003 00:14, Jens Axboe wrote:
> > >> On Sat, Mar 29 2003, Robert Love wrote:
> > >> > On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> > >> > > Are you sure this should be called a bug? Basically X is an
> > >interactive
> > >> > > process. If it now is "interactive for a priority -10 process" then
> > >it
> > >> > > should be hogging the cpu time no? The priority -10 was a workaround
> > >> > > for lack of interactivity estimation on the old scheduler.
> > >> >
> > >> > Well, I do not necessarily think that renicing X is the problem.  Just
> > >> > an idea.
> > >>
> > >> I see the exact same behaviour here (systems appears fine, cpu intensive
> > >> app running, attempting to start anything _new_ stalls for ages), and I
> > >> definitely don't play X renice tricks.
> > >>
> > >> It basically made 2.5 unusable here, waiting minutes for an ls to even
> > >> start displaying _anything_ is totally unacceptable.
> > >
> > >I guess I should have trusted my own benchmark that was showing this was
> > >worse
> > >for system responsiveness.
> >
> > I don't think it's really bad for system responsiveness.  I think the
>
>What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
>ever used, it would be _embarassing_ to release a 2.6-test with such a
>rudimentary flaw in it. IOW, a big show stopper.

It's only horrible when you trigger the problems, otherwise it's wonderful.

> > problem is just that the sample is too small.  The proof is that simply
> > doing sleep_time %= HZ cures most of my woes.  WRT contest and it's
>
>Irk, that sounds like a really ugly bandaid.

Nope, it's a really ugly _tourniquet_ ;-)

>I'm wondering why the scheduler guys aren't all over this problem,
>getting it fixed.

I think they are.

         -Mike  

