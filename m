Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbTFLFyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTFLFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:54:41 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:17794 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264760AbTFLFyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:54:36 -0400
From: Artemio <artemio@artemio.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: SMP question
Date: Thu, 12 Jun 2003 08:42:42 +0300
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0306111838360.20310-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0306111838360.20310-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306120841.08809.artemio@artemio.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > I'm building a hard real-time Linux (RTLinux) system on a 2x Xeon
> > machine. If
>
> then LKML is not the place for you.  RTLinux is a fork of "real" linux.

Well, those guys seem to have success on the same machines that I fail. 

I even used *their* .config file to compile a kernel, but I still fail.

> well, talk to the rtlinux people.  considering what rtlinux changes from
> real linux, this hang is not a big surprise.

Yes, rtlinux runs linux kernel as it's idle thread, and it messes up the 
system - I mean it becomes more difficult to make it work if it doesn't work.

> > So, I have to deside between these two:
> >
> >  - Run rtlinux and hard-realtime applications on a kernel without SMP
> > support. How much performance will I loose this way? Is SMP *THAT*
> > critical?
>
> huh?  it's not critical at all.  though if you have two processors,
> you've just wasted several hundred dollars unless you run SMP.

:-)

> >  - Run all tasks in a usual way, no hard realtime, but with SMP support.
>
> why do you think you need rtlinux-type realtime?

Hmm... Nice question.

We are to run many applications that will be mission-critical. That's why we 
decided to make them in hard-realtime.

The other way is probably making low-priority kernel threads by usual means.

But I think hard-realtime will give us more performance. 

> > Also, if I turn hyperthreading off, how will it influence the system with
> > SMP support? Without SMP support?
>
> HT is just hardware-supported multithreading - imagine that you have
> the same old processor, except that the CPU's instruction-dispatcher
> is reading from two instruction streams.  HT doesn't add any new resources,
> just shares a single CPU among two threads.

Got it.

> I suspect the design of rtlinux is inherently incompatible with HT.

I will try turning HT off and running RTLinux.



Thank you very much for your reply!


Artemio.

