Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWHRTBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHRTBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHRTBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:01:15 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:22284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750858AbWHRTBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:01:14 -0400
Date: Fri, 18 Aug 2006 20:01:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
Subject: Re: R: How to avoid serial port buffer overruns?
Message-ID: <20060818190106.GG21101@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Giampaolo Tomassoni <g.tomassoni@libero.it>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it> <1155920400.24907.63.camel@mindpipe> <20060818170450.GC21101@flint.arm.linux.org.uk> <1155922240.2924.5.camel@mindpipe> <20060818183430.GD21101@flint.arm.linux.org.uk> <1155927174.2924.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155927174.2924.28.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 02:52:53PM -0400, Lee Revell wrote:
> On Fri, 2006-08-18 at 19:34 +0100, Russell King wrote:
> > That "0000:00:0b.0" looks like a PCI device ID.  If it were a fourport
> > board, it would be "serial8250.3" according to the current enumeration
> > in linux/serial_8250.h.
> > 
> > Also, another give away is that IRQ185 is being setup as a PCI interrupt
> > immediately prior to the devices being registered.
> > 
> > And I doubt that an ISA board (which is what fourport is) would ever get
> > such a high IRQ number.
> > 
> 
> So you're saying that the standard 8250 driver is being used?

Yes, which is also the case with 8250_fourport.  8250_fourport is just
a probe module just like 8250_pnp or 8250_pci.

> http://www.moschip.com/html/MCS9845.html

That also clearly says its a PCI device. 8)

What problem are we talking about here again?  Sorry, I've completely lost
track and this particular thread of 26 messages is soo convoluted and too
much to re-read.

Since you only appear to be the messenger, wouldn't it be far better to get
the person with the problem to report and respond rather than sitting in
the middle?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
