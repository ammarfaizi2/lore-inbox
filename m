Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRG3Wl5>; Mon, 30 Jul 2001 18:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268699AbRG3Wlr>; Mon, 30 Jul 2001 18:41:47 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4597 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268691AbRG3Wlj>; Mon, 30 Jul 2001 18:41:39 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107302240.f6UMeWg2001230@webber.adilger.int>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <3B65D3DA.D70B48A0@fc.hp.com> "from Khalid Aziz at Jul 30, 2001
 03:38:34 pm"
To: Khalid Aziz <khalid@fc.hp.com>
Date: Mon, 30 Jul 2001 16:40:31 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz writes:
> Andreas Dilger wrote:
> > Has anyone considered allowing console devices to run over bi-directional
> > parallel ports?  I imagine most of the required code is in PLIP and serial,
> > which unfortunately I know nothing about.
> > 
> > Several newer systems I have today do not have physical serial ports at all,
> > but all of them (even laptops) still have bi-directional parallel ports.
> > 
> > I suppose there may be some difficulties in exporting a "serial-like"
> > interface to the user apps (e.g. minicom and such), but maybe not.
> > 
> 
> SH supports console on line printer which I assume is a parallel port
> console. You can check if that code will work for you and if it can be
> ported to x86.

 From what I have been told, the "line printer console" is unidirectional
only.  This would make it OK for console output, but you could not do real
debugging over such a setup.

What bothers me is that new systems don't have a serial port, and no ISA
slots, so there is no hope of getting a "serial console" support without
ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
for early-boot debugging, so what else is left?

There was some talk about using a low level IP console over ethernet,
but I would imagine this is more complex than the same thing on a
parallel-port.  I could be wrong.  Of course, an IP console has the
advantage of being useful over a longer distance than a parallel cable,
but may have the disadvantage of poor security.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

