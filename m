Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278609AbRJXPxn>; Wed, 24 Oct 2001 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278624AbRJXPxd>; Wed, 24 Oct 2001 11:53:33 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:40717 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S278609AbRJXPx0>; Wed, 24 Oct 2001 11:53:26 -0400
Message-ID: <3BD6E413.5AF9D7EF@firsdown.demon.co.uk>
Date: Wed, 24 Oct 2001 16:53:56 +0100
From: Dave Garry <daveg@firsdown.demon.co.uk>
Organization: Daemon Solutions Ltd
X-Mailer: Mozilla 4.51C-Caldera [en] (X11; I; Linux 2.2.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk> <20011024143601.M7544@redhat.com> <3BD6D7E8.BDC1AB2B@firsdown.demon.co.uk> <20011024160533.R7544@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Waugh wrote:
> 
> On Wed, Oct 24, 2001 at 04:02:00PM +0100, Dave Garry wrote:
> 
> > Thanks for the tip, but it's not helping. I've tried
> > "irq=auto" and "irq=7" but it still wont play.
> >
> > I just noticed that CONFIG_PARPORT_PC_FIFO is set to NO
> > and I'm rebuilding with it set to YES to see if that
> > helps...
> 
> Yes, you need that enabled or it won't even have the code for using
> the FIFO compiled in.

Enabling CONFIG_PARPORT_PC_FIFO has not helped, I now
get the following:

# modprobe parport_pc verbose_probing=1 irq=auto

Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378<7>0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x40
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100

modprobe verbose_probing=1 irq=7 gives exactly the same results.

> > This option was also off when I was using 2.4.10 so
> > I'm not sure if it will help.
> 
> But 2.4.10 still had the bug that advertised modes that it wouldn't
> use.
> 
> Tim.
> */

But with 2.4.10 it _was_ using ECP mode and I was
having no trouble...

-- 
Dave Garry,
Daemon Solutions Ltd
