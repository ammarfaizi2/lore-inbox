Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278543AbRJXPBx>; Wed, 24 Oct 2001 11:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278545AbRJXPBn>; Wed, 24 Oct 2001 11:01:43 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:32263 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S278543AbRJXPB1>; Wed, 24 Oct 2001 11:01:27 -0400
Message-ID: <3BD6D7E8.BDC1AB2B@firsdown.demon.co.uk>
Date: Wed, 24 Oct 2001 16:02:00 +0100
From: Dave Garry <daveg@firsdown.demon.co.uk>
Organization: Daemon Solutions Ltd
X-Mailer: Mozilla 4.51C-Caldera [en] (X11; I; Linux 2.2.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk> <20011024143601.M7544@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim,

Thanks for the tip, but it's not helping. I've tried
"irq=auto" and "irq=7" but it still wont play.

I just noticed that CONFIG_PARPORT_PC_FIFO is set to NO
and I'm rebuilding with it set to YES to see if that
helps...

This option was also off when I was using 2.4.10 so
I'm not sure if it will help.

-- 
Dave Garry,
Daemon Solutions Ltd


Tim Waugh wrote:
> 
> On Wed, Oct 24, 2001 at 02:16:51PM +0100, Dave Garry wrote:
> 
> > With kernel 2.4.12 and 2.4.13 the parallel port on
> > my machine looks like this according to dmesg:
> >
> > parport0: PC-style at 0x378 [PCSPP,TRISTATE]
> 
> Yes.  It's showing you what modes it is prepared to use.
> 
> > Under 2.4.10 is looks like this:
> [...]
> > parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
> 
> A bug; it was showing you what modes the hardware was capable of,
> _despite_ knowing that it wasn't going to use it.
> 
> The parport driver will only use ECP and parallel port FIFO modes if
> it has an IRQ to use.  Try 'irq=auto'.
> 
> Tim.
> */
