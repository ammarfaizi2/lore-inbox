Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266537AbUA3FlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUA3FlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:41:17 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:61316 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266537AbUA3FlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:41:15 -0500
Date: Fri, 30 Jan 2004 00:26:02 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20040130002602.GA13308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com> <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com> <20040104162654.A27227@flint.arm.linux.org.uk> <Pine.LNX.4.56.0401051713370.4783@athena.localdomain> <20040126192204.GA7280@neo.rr.com> <Pine.LNX.4.58.0401291043370.1164@athena.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401291043370.1164@athena.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 10:57:58AM +0400, Amit Gurdasani wrote:
> On Mon, 26 Jan 2004, Adam Belay wrote:
> 
> :On Mon, Jan 05, 2004 at 05:23:27PM +0400, Amit Gurdasani wrote:
> :> On Sun, 4 Jan 2004, Russell King wrote:
> :>
> :> :On Mon, Dec 29, 2003 at 10:50:37PM +0000, Adam Belay wrote:
> :> :> > ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
> :> :> > ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> :> :> > ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> :> :> > parport0: irq 7 detected
> :> :>
> :> :> Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
> :> :> I would guess it is on irq 4.
> :> :
> :> :irq0 on x86 means "I'll use polled mode".
> :
> :It occured to me that we should probably check which resources the pnpbios is
> :reporting.  If you have a chance, could you please show me the output of this
> :hack.
> 
> Sorry about taking so long to reply.

Sorry for waiting so long to bring this up.

>
> It doesn't seem that the printk was ever called. Here are dmesg outputs with
> and without isapnptools capturing an IRQ for the ISA modem. (I'm using
> loadlin from DOS to boot Linux, incidentally. Would that make any
> difference?)
>

Hmm, it looks like something strange is going on.  Perhaps the serial driver
isn't matching to the device.  Could I see the output of the following:

#mkdir /sys
#mount -t sysfs none /sys
#cd /sys/bus/pnp/devices
#find */* | xargs cat       <------

Thanks,
Adam
