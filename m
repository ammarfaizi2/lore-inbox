Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292779AbSBZUO5>; Tue, 26 Feb 2002 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292798AbSBZUOy>; Tue, 26 Feb 2002 15:14:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29579 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293139AbSBZUO1>; Tue, 26 Feb 2002 15:14:27 -0500
Date: Tue, 26 Feb 2002 15:17:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.4.44.0202261211510.1544-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.3.95.1020226151635.5437C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Davide Libenzi wrote:

> On Tue, 26 Feb 2002, Richard B. Johnson wrote:
> 
> >
> >
> > I just read on this list that:
> >
> >     while(something)
> >     {
> >       current->policy |= SCHED_YIELD;
> >       schedule();
> >     }
> >
> > Will no longer be allowed in a kernel module! If this is true, how
> > do I loop, waiting for a bit in a port, without wasting CPU time?
> >
> > A lot of hardware does not generate interrupts upon a condition,
> > there is no CPU activity that could send a wake_up_interruptible()
> > to something sleeping.
> >
> > For instance, I need to write data to a hardware FIFO, one long-word
> > at a time, but I can't just write. I have to wait for a bit to be
> > set or reset for each and every write. I'm going to be burning a
> > lot of CPU cycles if I can't schedule() while the trickle-down-effect
> > of the hardware is happening.
> 
> What did it do yield() to you ? Doesn't it work for your case ?
> 
There isn't one in 2.4.x  I'll modify my drivers to use YIELD
and #define it depending upon version.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

