Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWAIIy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWAIIy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 03:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWAIIy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 03:54:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44816 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751046AbWAIIy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 03:54:59 -0500
Date: Mon, 9 Jan 2006 08:54:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20060109085452.GA9189@flint.arm.linux.org.uk>
Mail-Followup-To: Antonio Vargas <windenntw@gmail.com>,
	Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231117560.25532@math.ut.ee> <20051223093343.GA22506@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231204290.8311@math.ut.ee> <20051223104146.GB22506@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512271553480.7835@math.ut.ee> <20051228195509.GA12307@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512291011320.28176@math.ut.ee> <69304d110601081524v37b15ff2tfed8341eaffbe07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d110601081524v37b15ff2tfed8341eaffbe07@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:24:52AM +0100, Antonio Vargas wrote:
> On 12/29/05, Meelis Roos <mroos@linux.ee> wrote:
> > > Can I assume that the bug has disappeared?  Does the patch make it
> > > disappear?
> >
> > Yes, seems so.
> >
> > --
> > Meelis Roos (mroos@linux.ee)
> 
> Please notice official linus 2.6.15 tree doesn't have this fix... I've
> just installed a virtual machine (qemu-system-i386 with linus 2.6.15 +
> plain debian 3r0, console output to xterm via emulated serial console)
> and trying to use any curses program (top for example) produces
> exactly this type of error.

That's because the patch just adds debugging seems to be sufficient to
cause the bug to disappear.  It isn't a fix.

The only explaination I have at the moment is that it changes the timing
- maybe there's a bug in these UARTs... I don't know at the moment.
What I do know is that Alan's original premise seems wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
