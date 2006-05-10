Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWEJOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWEJOLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWEJOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:11:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:11202 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751426AbWEJOLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:11:10 -0400
Date: Wed, 10 May 2006 10:10:56 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <4461E53B.7050905@compro.net>
Message-ID: <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Mark Hounschell wrote:

> Steven Rostedt wrote:
> > (It is expected on LKML to not touch the CC list, and especially keep the
> > one you are replying to)
> >
> Ok. I'm on so many it's hard to remember what each want.

:) I've read that in other lists it's impolite to CC others.  I still do
it :}  I find that, espically if I'm on lots of lists, if I'm on a thread,
I prefer to be emailed directly, that way I know about a topic that I
might need to quickly respond to.  I never pay attention to policies
abount stripping CC lists, because I don't ever want to be stripped from a
thread I'm interested in.  The LKML has 300 to 700 emails a day, so you
really do need to CC those, otherwise you'll be lost in the noise.

>

[snip]

> Thank you. That is exactly what I wanted to know. I ask because when I
> run my app in complete preemption mode I have random periods where the
> machine stops for many seconds at a time. Only in complete preemption
> mode does this happen. In Voluntary and Preempt modes this does not
> occure. I'm having a hard time trying to determine if the problem is in
> my application.
>

OK, now you got my attention.  What do you mean by your machine stops?

Are you playing with priorities?  You might want to turn on latency
tracing, although it could be a PI leak.  But I really need to know more,
since I'm suspecting that your app isn't written properly to work with a
true RT environment.

RT means that you can easily freeze the machine if you have a high prio
task that runs more than you expect it to.  With this power comes great
responsibility, as well as understanding.

Is this SMP or UP?

Could you explain you app a little and what tasks are RT?

Thanks,

-- Steve

