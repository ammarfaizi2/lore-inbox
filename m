Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269084AbRG3XeU>; Mon, 30 Jul 2001 19:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269085AbRG3XeB>; Mon, 30 Jul 2001 19:34:01 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:10741 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269084AbRG3Xdm>; Mon, 30 Jul 2001 19:33:42 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107302332.f6UNWbxg001791@webber.adilger.int>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <3B65E711.A3828E15@fc.hp.com> "from Khalid Aziz at Jul 30, 2001
 05:00:33 pm"
To: Khalid Aziz <khalid@fc.hp.com>
Date: Mon, 30 Jul 2001 17:32:37 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz writes:
> Andreas Dilger wrote:
> > What bothers me is that new systems don't have a serial port, and no ISA
> > slots, so there is no hope of getting a "serial console" support without
> > ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
> > for early-boot debugging, so what else is left?
> 
> I am puzzled. How would you get "serial console" support even with ACPI
> unless there IS a serial port on the system????? All ACPI can do is tell
> you where the serial port is.

OK, maybe I'm misunderstanding here, but even if I put in a PCI serial
card in such a machine, can I get serial console support without ACPI?
Not that it matters in my case, because there are no PCI slots on the
motherboard either.

> > There was some talk about using a low level IP console over ethernet,
> > but I would imagine this is more complex than the same thing on a
> > parallel-port.  I could be wrong.  Of course, an IP console has the
> > advantage of being useful over a longer distance than a parallel cable,
> > but may have the disadvantage of poor security.
> 
> IP console qould require a significant amount of network protocol stack
> to be up and running. That would make console available pretty late in
> bootup sequence.

Yes, this is another good reason why an IP console is less desirable.
AFAIK, some systems have such IP console support in BIOS (it may not
even be "IP" but raw ethernet).

> Even if console were to be used to print just errors and information
> messages, it should still be pretty simple to ensure those messages
> do get printed out. A serial port meets those requirements.

And I think "legacy" parallel ports also meet this simplicity requirement
as well, except for the fact that until now it was much more common to
also have a serial port, so nobody has done the work to have bidirectional
parallel port support.  Sadly, I have _no_ idea even where to begin on it,
nor the time.  I was hoping someone would chime in and say "I did that
already".

I guess the other need would be to allow programs like minicom, kgdb,
etc to open /dev/lp0 like a serial port on the client side, so we don't
need to re-write all of the user-space tools as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

