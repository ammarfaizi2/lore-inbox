Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVKWJJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVKWJJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 04:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVKWJJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 04:09:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45579 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030379AbVKWJJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 04:09:16 -0500
Date: Wed, 23 Nov 2005 09:09:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kasper Sandberg <lkml@metanurb.dk>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123090905.GA2867@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <1132694935.10574.2.camel@localhost> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com> <1132702614.20233.91.camel@localhost.localdomain> <9e4733910511221556n1fe390e5qcd778f39aa75695d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511221556n1fe390e5qcd778f39aa75695d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:56:30PM -0500, Jon Smirl wrote:
> On 11/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Maw, 2005-11-22 at 16:41 -0500, Jon Smirl wrote:
> > > An example of this is that the serial driver is hard coded to report
> > > four legacy serial ports when my system physically only has two. I
> > > have to change a #define and recompile the kernel to change this.
> >
> > It does an autodetect sequence to find the ports. If it reports ttyS0-S3
> > your system probably has them, they may just not be wired to external
> > ports and that is kinda tricky to autodetect
> 
> The ports really aren't there. If we had a driver for the LPC chip it
> would see that the chip only implemented two ports.  On modern
> hardware a driver for LPC/super IO chips might be enough to do all of
> the needed legacy detection.

If the serial driver detects a port at a particular address, the
hardware or something which behaves very much like a serial port
is there.

However, as far as I recall, you've never reported this as a problem.
Care to put something in bugzilla or start a new thread?  Starting
with the entire kernel messages with the DEBUG_AUTOCONF stuff enabled
in the 8250 driver would probably be good.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
