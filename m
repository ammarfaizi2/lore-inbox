Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279089AbRJ3Iaq>; Tue, 30 Oct 2001 03:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278949AbRJ3Iaf>; Tue, 30 Oct 2001 03:30:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48114 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S278961AbRJ3IaR>; Tue, 30 Oct 2001 03:30:17 -0500
Message-ID: <3BDE62C0.C7C5CC70@mvista.com>
Date: Tue, 30 Oct 2001 00:20:16 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> Alan Cox wrote:
> 
> > > and received a nasty surprise. The uptime, which had been 496+ days
> > > on Friday, was back down to a few hours. I was ready to lart somebody
> > > with great vigor when I realized the uptime counter had simply wrapped
> > > around.
> > >
> > > So, I thought to myself, at least the 2.4 kernels on our new boxes won't
> >
> > It wraps at 496 days. The drivers are aware of it and dont crash the box
> 
> Yes, and these boxes are still running fine - other
> than showing some processes that were started
> in the year 2003... but DAMN, what an eyesore -
> uptime ruined as far as anybody can tell, times
> and dates no longer making any sense.
> 
> So, is there an implicit Linux policy to upgrade
> the distro, or at least the kernel, every 496 days
> whether it needs it or not?

Time for a plug for the High-res-timers project.  We have expanded
jiffies to 64 bits.  It can be read as the CLOCK_MONOTONIC via the new
POSIX timers interface (part of high-res-timers).  Haven't fixed uptime
yet, but hay, I got 496 days to do it :)

Find our latest patch here:
https://sourceforge.net/projects/high-res-timers/

George
