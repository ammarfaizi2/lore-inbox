Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264023AbTCXQW7>; Mon, 24 Mar 2003 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264025AbTCXQW7>; Mon, 24 Mar 2003 11:22:59 -0500
Received: from gorilla.mchh.siemens.de ([194.138.158.18]:44942 "EHLO
	gorilla.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S264023AbTCXQW6> convert rfc822-to-8bit; Mon, 24 Mar 2003 11:22:58 -0500
Message-ID: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4677@BSL203E>
From: Spang Oliver <oliver.spang@siemens.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: AW: drivers/serial/Makefile
Date: Mon, 24 Mar 2003 17:33:44 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have some other hints for the problem described in the "2.5.64 ttyS problem ?"-thread?

Oliver

> -----Ursprüngliche Nachricht-----
> Von: Russell King [mailto:rmk@arm.linux.org.uk]
> Gesendet: Montag, 24. März 2003 17:16
> An: Duncan Sands
> Cc: linux-kernel@vger.kernel.org; Spang Oliver
> Betreff: Re: drivers/serial/Makefile
> 
> 
> On Mon, Mar 24, 2003 at 04:52:50PM +0100, Duncan Sands wrote:
> > The serial driver is now compiled as "8250", rather than
> > the traditional "serial" (Kconfig says "serial" as well).
> > Assuming this was a mistake in the Makefile, I went and
> > had a look, but my brain exploded.
> 
> It isn't a mistake.  "serial" is meaningless with you've got multiple
> serial ports of different types.  It's a general name of a class of
> devices, not a specific device.
> 
> > What exactly is this intended to do?
> 
> Well, core.c is the core driver which knows how to talk to user space,
> and on to that bolts the hardware specific bits, 8250.c, sa1100.c,
> suncore.c etc.
> 
> > PS: 8250_gsc, 8250_pci can be compiled as modules in their
> > own right.
> 
> In theory they can, and maybe one day we'll teach the Kconfig system
> to allow it.  Feel free to send a patch for this. 8)
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The 
> developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
