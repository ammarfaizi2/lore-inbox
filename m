Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263584AbRFFQsA>; Wed, 6 Jun 2001 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263583AbRFFQrv>; Wed, 6 Jun 2001 12:47:51 -0400
Received: from c009-h019.c009.snv.cp.net ([209.228.34.132]:20199 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S263578AbRFFQrp>;
	Wed, 6 Jun 2001 12:47:45 -0400
X-Sent: 6 Jun 2001 16:47:44 GMT
Date: Wed, 6 Jun 2001 09:48:56 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m17kyp7o2y.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0106060947350.304-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2001, Eric W. Biederman wrote:

> "Jeffrey W. Baker" <jwbaker@acm.org> writes:
>
> > On Tue, 5 Jun 2001, Derek Glidden wrote:
> >
> > >
> > > After reading the messages to this list for the last couple of weeks and
> > > playing around on my machine, I'm convinced that the VM system in 2.4 is
> > > still severely broken.
> > >
> > > This isn't trying to test extreme low-memory pressure, just how the
> > > system handles recovering from going somewhat into swap, which is a real
> > > day-to-day problem for me, because I often run a couple of apps that
> > > most of the time live in RAM, but during heavy computation runs, can go
> > > a couple hundred megs into swap for a few minutes at a time.  Whenever
> > > that happens, my machine always starts acting up afterwards, so I
> > > started investigating and found some really strange stuff going on.
> >
> > I reboot each of my machines every week, to take them offline for
> > intrusion detection.  I use 2.4 because I need advanced features of
> > iptables that ipchains lacks.  Because the 2.4 VM is so broken, and
> > because my machines are frequently deeply swapped, they can sometimes take
> > over 30 minutes to shutdown.  They hang of course when the shutdown rc
> > script turns off the swap.  The first few times this happened I assumed
> > they were dead.
>
> Interesting.  Is it constant disk I/O?  Or constant CPU utilization.
> In any case you should be able to comment that line out of your shutdown
> rc script and be in perfectly good shape.

Well I can't exactly run top(1) at shutdown time, but the disks aren't
running at all.  Either the system is using the CPUs, or it is blocked
waiting for something to happen.

You're right about swapoff, we removed it from our shutdown script.

