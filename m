Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269802AbUICTyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269802AbUICTyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUICTxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:53:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3856 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269797AbUICTvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:51:19 -0400
Date: Fri, 3 Sep 2004 20:51:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903205115.E15620@flint.arm.linux.org.uk>
Mail-Followup-To: John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <1094157190l.4235l.2l@hydra> <20040903135103.GA982@elf.ucw.cz> <1094236686l.7429l.0l@hydra> <20040903195555.D15620@flint.arm.linux.org.uk> <1094238599l.7429l.2l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094238599l.7429l.2l@hydra>; from lenz@cs.wisc.edu on Fri, Sep 03, 2004 at 07:09:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 07:09:59PM +0000, John Lenz wrote:
> > > The led class does not really inforce any policy, it just passes this
> > > number along to the actual driver that is registered.  So say you had
> > > a led that could be red, green, or both red and green at the same time
> > > (not sure how that would work hardware wise, but ok).
> > 
> > See Netwinders.  They have a bi-colour LED which has independent red
> > and green LEDs in the same package.  When they're both on it's yellow.
> > 
> > It's _VERY_ useful to see the green LED flashing and know that the
> > headless machine is running, or that the red LED being on means that
> > either it hasn't booted a kernel yet or the system has successfully
> > shut down.
> > 
> > It means I don't have to fsck around with monitor cables before pulling
> > the power.
> > 
> > And no, doing that from userspace won't work because userspace is dead
> > _before_ the system has finished shutting down (see drive cache
> > flushing on shutdown.)
> > 
> > It's also _VERY_ useful to know whether the kernel has managed to get
> > far enough through the boot that the heartbeat LED is flashing but
> > maybe not sufficiently to bring up the serial console as well -
> > again another thing that a userspace implementation will never be
> > able to support.
> 
> Hey I agree!  I use the led as a debugging tool on the Sharp Zaurus.   
> Before I had the framebuffer or the serial port working, being able to see  
> the led told me something was working :)  This patch isn't really intended  
> for debugging support, so perhaps some other interface could be added.
> 
> On the other hand, perhaps we can just do a #ifdef LEDS_DEBUGGING that  
> would toggle the led on a timer.

You missed the point.  The above scenarios I was describing are _not_
debugging.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
