Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUGJO53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUGJO53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGJO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:57:29 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:62690 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266262AbUGJO51 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:57:27 -0400
Message-ID: <2a4f155d0407100757647823d5@mail.gmail.com>
Date: Sat, 10 Jul 2004 17:57:20 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Ingo Molnar <mingo@elte.hu>, Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <40F000F1.1080004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com> <20040710123520.GA27278@elte.hu> <2a4f155d04071005585b5d8999@mail.gmail.com> <20040710135555.GA31068@elte.hu> <40F000F1.1080004@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jack uses realtime through realtime lsm module so it can do mlock() ,
I tried making aRts run real time too but it didn't prevent skips
either.

Cheers,
ismail

On Sun, 11 Jul 2004 00:45:05 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
> Ingo Molnar wrote:
> > * ismail dönmez <ismail.donmez@gmail.com> wrote:
> >
> >
> >>>what filesystem are you using?
> >>>
> >>
> >>XFS
> >
> >
> > i've fixed latencies in ext3, i'm not sure how bad XFS is. But 2-3
> > seconds delay is almost impossible to be a true scheduling latency -
> > it's probably IO latency impacting your audio application. (it could
> > also be normal preemption latency, if those tasks are not running as
> > SCHED_FIFO - but 2-3 seconds preemption latency should not be caused by
> > a simple cp -a. This leaves IO latency.).
> >
> 
> But it only skips when using aRts, which points the other way ;)
> 
> If all tasks are using realtime scheduling, then this discounts
> the scheduler from the equation, however I'm not sure if this is
> the case?
> 


-- 
Time is what you make of it
