Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVKWPbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVKWPbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKWPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:31:11 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:59795 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751009AbVKWPbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:31:10 -0500
Date: Wed, 23 Nov 2005 15:25:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123152558.GB15449@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:19:19AM -0500, Jon Smirl wrote:
> On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
> > > My system has:
> > > 2 serial
> > >
> > > In /sys/bus/platform/devices I see this:
> > > serial8250
> > > shouldn't there be entries for all of the legacy devices?
> > >
> > > In /dev
> > > ttyS0
> > > ttyS1
> > > ttyS2
> > > ttyS3
> >
> > You're basically confused about serial ports.  The kernel serial devices
> > whether or not hardware is found, to allow programs such as setserial to
> > function.
> >
> > If you disagree with that, there'll be an equal number of people who
> > have serial cards that need setserial who will in turn disagree with
> > you.
> 
> This is confusing...
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Yes it is, but it's down to the way folk want things to operate.  The
first two come from the legacy table in include/asm-*/serial.h.  The
second two come from something-that-I-have-no-clue-about but is probably
ACPI related.  Dunno.  We're back to the far-too-many-complex-ways-to-
initialise-serial problem again that I've given up really caring how
many lines of serial printk junk folk end up with.  I can't fight it
all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
