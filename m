Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbUKRToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUKRToO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUKRTm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:42:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:17097 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262919AbUKRT3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:29:11 -0500
Date: Thu, 18 Nov 2004 11:28:59 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: MCU.Tools@silabs.com, grayson@caltech.edu, jan@pololu.com,
       karl@accusense.com
Subject: Linux support for SiLabs CP2102 devices
Message-ID: <20041118192859.GA29395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resent without tarball to let lkml filters accept it.)

Hi all,

I've been getting a lot of requests lately to see if Linux supports the
USB to serial device from Silicon Laboratories called the CP2102 chip.
It turns out that the company is claiming Linux support, yet they are
only shipping a binary driver for Red Hat Linux 9.0.

In talking with the company, they insist that they will not release the
source code to this module, and they claim that they are not infringing
on any rights by not doing so.  I claim that this is not true, as to
write a usb to serial driver for Linux you have to use the
drivers/usb/serial/usb-serial.h header file which is specifically
licensed under the GPL v2.  This file contains inline functions and
structures that all usb-serial drivers need to use in order to work
properly.

In short, there's no way you can write a Linux usb-serial driver, that
uses the usbserial interface, without it being a derived work of other,
GPL only code.

So, they are in violation, so what.  Well, I can't do much about this
(due to my employer's rules about suing companies).  But I can do my
best to spread the word that the CP2102 device is not supported on
Linux, and should be avoided at all costs by anyone considering such a
device in a future design.  I encourage everyone else to help spread
this information too.

If people are looking for a good usb to serial chip that is supported on
Linux, Windows, and OS-X, there's the PL2303 device from Prolific, and
the FTDI-SIO chip, and the MCT-U232 chip.  All of these work very well
on Linux, and are fully supported by all distros.  I think they even
might be cheaper than the CP2102 device too :)

Oh, and just for fun, the Linux driver that SiLabs is distributing is
availble:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110079963113076&q=p3
if anyone wants to poke around in it.  The tarball contains 2 binary
drivers, one of them a version of the usbserial.c file (which plainly is
licensed under the GPL) and a mcci_usb.o binary driver.  Have fun with
it, but don't blame me for any badness that might happen to your box for
running it, no one has any way of knowing exactly what this driver is
doing.

So, in conclusion, please stay away from Silicon Laboratories devices,
if you want to run Linux, as they are obviously not supporting Linux in
any way.

thanks,

greg k-h
