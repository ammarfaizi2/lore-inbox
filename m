Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292777AbSBZURp>; Tue, 26 Feb 2002 15:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292796AbSBZURg>; Tue, 26 Feb 2002 15:17:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:21778 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293385AbSBZURN>; Tue, 26 Feb 2002 15:17:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 26 Feb 2002 12:19:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.3.95.1020226151635.5437C-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0202261218080.1544-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Richard B. Johnson wrote:

> On Tue, 26 Feb 2002, Davide Libenzi wrote:
>
> > On Tue, 26 Feb 2002, Richard B. Johnson wrote:
> >
> > >
> > >
> > > I just read on this list that:
> > >
> > >     while(something)
> > >     {
> > >       current->policy |= SCHED_YIELD;
> > >       schedule();
> > >     }
> > >
> > > Will no longer be allowed in a kernel module! If this is true, how
> > > do I loop, waiting for a bit in a port, without wasting CPU time?
> > >
> > > A lot of hardware does not generate interrupts upon a condition,
> > > there is no CPU activity that could send a wake_up_interruptible()
> > > to something sleeping.
> > >
> > > For instance, I need to write data to a hardware FIFO, one long-word
> > > at a time, but I can't just write. I have to wait for a bit to be
> > > set or reset for each and every write. I'm going to be burning a
> > > lot of CPU cycles if I can't schedule() while the trickle-down-effect
> > > of the hardware is happening.
> >
> > What did it do yield() to you ? Doesn't it work for your case ?
> >
> There isn't one in 2.4.x  I'll modify my drivers to use YIELD
> and #define it depending upon version.

In 2.5 yield() maps to sys_sched_yield(). You can handle it in the same
way in your includes if version <= 2.4.




- Davide


