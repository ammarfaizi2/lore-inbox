Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUAMLtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbUAMLty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:49:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264137AbUAMLtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:49:52 -0500
Date: Tue, 13 Jan 2004 11:49:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Outstanding fixups (was: Re: [PROBLEM] ircomm ioctls)
Message-ID: <20040113114948.B2975@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113113650.A2975@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 13, 2004 at 11:36:51AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:36:51AM +0000, Russell King wrote:
> ircomm needs updating to use the tiocmset/tiocmget driver calls.  Could
> you see if the following patch solves your problem please?

And as a follow up, there are about 30 other drivers which still
reference TIOCM{GET,SET,BIC,BIS} most of which won't work.  Some of
them include drivers that were dumped into drivers/serial (despite
not using the serial_core stuff.)

The list currently looks like this.  Some of these drivers have been
updated since the change was made back in April, but it seems that
this particular update was missed.

I'm going to work through this list and update these drivers today.
However, I will be unable to test most if not all of these drivers.

drivers/char/rio/rio_linux.c
drivers/char/amiserial.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/ip2main.c
drivers/char/isicom.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/pcxx.c
drivers/char/riscom8.c
drivers/char/rocket.c
drivers/char/serial167.c
drivers/char/sh-sci.c
drivers/char/specialix.c
drivers/char/stallion.c
drivers/char/sx.c
drivers/isdn/i4l/isdn_tty.c
drivers/macintosh/macserial.c
drivers/net/wan/pc300_tty.c
drivers/s390/net/ctctty.c
drivers/sbus/char/aurora.c
drivers/serial/68360serial.c
drivers/serial/mcfserial.c
drivers/tc/zs.c
drivers/usb/serial/ftdi_sio.c
drivers/usb/serial/io_edgeport.c

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
