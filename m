Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRG3XA1>; Mon, 30 Jul 2001 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268709AbRG3XAR>; Mon, 30 Jul 2001 19:00:17 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:24546 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S268750AbRG3XAE>;
	Mon, 30 Jul 2001 19:00:04 -0400
Message-ID: <3B65E711.A3828E15@fc.hp.com>
Date: Mon, 30 Jul 2001 17:00:33 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andreas Dilger wrote:
> 
> What bothers me is that new systems don't have a serial port, and no ISA
> slots, so there is no hope of getting a "serial console" support without
> ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
> for early-boot debugging, so what else is left?

I am puzzled. How would you get "serial console" support even with ACPI
unless there IS a serial port on the system????? All ACPI can do is tell
you where the serial port is.

> 
> There was some talk about using a low level IP console over ethernet,
> but I would imagine this is more complex than the same thing on a
> parallel-port.  I could be wrong.  Of course, an IP console has the
> advantage of being useful over a longer distance than a parallel cable,
> but may have the disadvantage of poor security.
> 

IP console qould require a significant amount of network protocol stack
to be up and running. That would make console available pretty late in
bootup sequence. IMO, console should be simple and reliable if it is to
be used for debugging at all. Even if console were to be used to print
just errors and information messages, it should still be pretty simple
to ensure those messages do get printed out. A serial port meets those
requirements. USB is too complex, as you said, unless it could be
managed fully in firmware/BIOS. But then again I would hate to have
kernel make calls into firmware for simple console I/O. 

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
