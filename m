Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCCUIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUCCUIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:08:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40577 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261168AbUCCUHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:07:45 -0500
Date: Wed, 3 Mar 2004 15:10:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dave Dillow <dave@thedillows.org>
cc: Bill Davidsen <davidsen@tmr.com>, Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <1078342159.1123.18.camel@dillow.idleaire.com>
Message-ID: <Pine.LNX.4.53.0403031459260.13544@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos> 
 <1078286221.4302.23.camel@ori.thedillows.org>  <Pine.LNX.4.53.0403031313270.12900@chaos>
 <1078342159.1123.18.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Dave Dillow wrote:

> On Wed, 2004-03-03 at 13:23, Richard B. Johnson wrote:
> > The very great problems that exist with poll on linux-2.6.0
> > are being quashed by those who just like to argue.
>
> No, the argument has always been that your understanding of poll()'s
> internals is not entirely correct. We have simply asked you to post code
> that shows poll()'s problems, which you have finally provided. Sort of.
>
> >  Therefore,
> > I wrote some code that emulates the environment in which I
> > discovered the poll failure. Experts can decide whatever they
> > want about the inner workings of poll(). I supposed that if
> > `ps` showed that a task was sleeping in poll() then it must
> > be sleeping in poll().
>
> This we all agree on -- poll() sleeps. Duh. No argument there.
> poll_wait() doesn't and never has, which was your original assertion.
>
> But on to the code!
>
> > So, even it that's wrong, here is
> > irrefutable proof that there is a problem with polling events
> > getting lost on 2.6.0.
>
> Ahem, no, not so much. What you have here is proof that your user
> program is not getting control again withing 0.488ms of the interrupt
> happening. That does not mean poll() is loosing events.
>

Well that should mean the same thing in the final wash.

> You are definately seeing some significant latency -- 50 lost increments
> is ~25ms.
>
> What else is running when you perform this test? Can you repeat with a
> more recent kernel? Can you repeat in single user mode, with it being
> the only process present? With as few extra modules loaded as possible?
>

I would need to install a more recent kernel and I think I should. That
will mean some re-write of the module code, so I am told. I wrote the
module and another Engineer, Terry Skillman, wrote the test-code and the
Makefile. He also performed the tests. He says that it will not compile
on a newer 2.6.x so I would have to do more work if true. I will
have to put that off until Monday because I have to take a work-break.

Nothing else is running. Although there is a network board, there is no
network line from the hub to that machine when the tests are made.

> I still think your problem is not poll() -- if there were problems
> there, bug reports would be coming out of the woodwork.
> --
> Dave Dillow <dave@thedillows.org>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


