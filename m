Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268765AbRG3XVJ>; Mon, 30 Jul 2001 19:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268771AbRG3XU7>; Mon, 30 Jul 2001 19:20:59 -0400
Received: from archive.osdlab.org ([65.201.151.11]:53442 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S268765AbRG3XUs>;
	Mon, 30 Jul 2001 19:20:48 -0400
Message-ID: <3B65EB21.C1DD8624@osdlab.org>
Date: Mon, 30 Jul 2001 16:17:53 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khalid Aziz <khalid@fc.hp.com>
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <3B65E711.A3828E15@fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz wrote:
> 
> Andreas Dilger wrote:
> >
> > What bothers me is that new systems don't have a serial port, and no ISA
> > slots, so there is no hope of getting a "serial console" support without
> > ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
> > for early-boot debugging, so what else is left?
> 
> I am puzzled. How would you get "serial console" support even with ACPI
> unless there IS a serial port on the system????? All ACPI can do is tell
> you where the serial port is.

Wait a minute.  Aren't you the person who originally proposed this,
and you don't know how it's used?

Here are 2 possibilities:

a.  Some pre-production motherboards are built with serial ports on
them, only for debugging.  Never shipped to customers like this.
The documented I/O resources for this serial port are in the
special ACPI table that you referred to last Thursday.

(second one is below)

> > There was some talk about using a low level IP console over ethernet,
> > but I would imagine this is more complex than the same thing on a
> > parallel-port.  I could be wrong.  Of course, an IP console has the
> > advantage of being useful over a longer distance than a parallel cable,
> > but may have the disadvantage of poor security.
> >
> 
> IP console qould require a significant amount of network protocol stack
> to be up and running. That would make console available pretty late in
> bootup sequence. IMO, console should be simple and reliable if it is to
> be used for debugging at all. Even if console were to be used to print
> just errors and information messages, it should still be pretty simple
> to ensure those messages do get printed out. A serial port meets those
> requirements. USB is too complex, as you said, unless it could be
> managed fully in firmware/BIOS. But then again I would hate to have
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel make calls into firmware for simple console I/O.

b. Bingo.  USB chipsets "could" do this -- i.e., could translate
"simple" reads/writes into USB protocol transfers.

-- 
~Randy
