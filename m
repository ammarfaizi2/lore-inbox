Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287206AbRL2WXE>; Sat, 29 Dec 2001 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287204AbRL2WWz>; Sat, 29 Dec 2001 17:22:55 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:47117 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287200AbRL2WWn> convert rfc822-to-8bit; Sat, 29 Dec 2001 17:22:43 -0500
Date: Sat, 29 Dec 2001 14:24:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: george anzinger <george@mvista.com>,
        Martin Knoblauch <knobi@sirius-cafe.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011229190226Z285236-18284+8993@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0112291418480.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Dieter [iso-8859-15] Nützel wrote:

> Martin Knoblauch wrote:
> >
> > > Re: [RFC] Scheduler issue 1, RT tasks ...
> > >
> > > >
> > > > Right, that was my question. George says, in your words, "for better
> > >
> > > > standards compliancy ..." and I want to know why you guys think
> > > that.
> > >
> > > The thought was that if someone need RT tasks he probably need a very
> > > low latency and so the idea that by applying global preemption decisions
> > > would lead to a better compliancy. But i'll be happy to ear that this is
> > > false anyway ...
> > >
> >
> >  without wanting to start a RT flame-fest, what do people really want
> > when they talk about RT in this [Linux] context:
> >
> > - very low latency
> > - deterministic latency ("never to exceed")
> > - both
> > - something completely different
> >
> > All of the above from time to time and user to user.  That is, some
> > folks want one or more of the above, some folks want more, some less.
> > What is really up?  Well they have a job to do that requires certain
> > things.  Different jobs require different capabilities.  It is hard to
> > say that any given system will do a reasonably complex job with out
> > testing.  For example we may have the required latency but find the
> > system fails because, to get the latency, we preempted another task that
> > was (and so still is) in the middle of updating something we need to
> > complete the job.
>
> So George what direction should I try for some tests?
> 2.4.17 plus your and Robert's preempt plus lock-break?
> Add your high-res-timers, rtscheduler or both?
> Do they apply against 2.4.17/2.4.18-pre1?
> A combination of the above plus Davide's BMQS?
>
> I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
> Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> Some wisdom?

A bad scheduler can make the latency to increase but in your case i don't
think that it could increase that much ( in percent ). By copying a huge
file arund you can experience spots of 1-2 secs of machine freeze and
this is definitely not the scheduler. The demage the a bad scheduler can
do is directly proportional to the cs anyway.




- Davide


