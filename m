Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTEDBD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 21:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTEDBD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 21:03:27 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:40581 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP id S263490AbTEDBD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 21:03:26 -0400
Date: Sat, 03 May 2003 18:27:28 -0700
From: David Brownell <david-b@pacbell.net>
Subject: [Fwd: [PATCH 2.5.68] USB Gadget framework (0/6)]
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3EB46C80.3010500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:  sent this morning to linux-usb-devel.

-------- Original Message --------
Subject: [PATCH 2.5.68] USB Gadget framework (0/6)
Date: Sat, 03 May 2003 11:45:06 -0700
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>,  linux-usb-devel@lists.sourceforge.net

Followups to this message will  include patches with the core
of a "USB Gadget" framework.  As you know, this is something
we've wanted for the 2.5 kernel.  I see this as a good seed,
the Linux developer community as fertile ground, and with
spring here (Northern hemisphere, y'all), it's time to see
what we'll grow!

The API is hardware-neutral, and passes straight down to drivers
for device-side USB controllers.  The "gadget drivers" implement
USB device functionality using that API, including "endpoint zero"
policies to configure that hardware for the desired functionality.
They talk to host-side USB device drivers, such as those found
today in all mainstream Linux kernels.

       1 <linux/usb_gadget.h> ... API, and inlined implementation.

       2 drivers/usb/gadget/net2280.[hc] ... implements that API,
         for the Net2280 peripheral controller.  This connects
         using PCI, and supports USB 2.0 high speed.  So it's
         relatively demanding of that API.

       3 drivers/usb/gadget/zero.c  ... simple gadget driver for
         testing

       4 drivers/usb/gadget/ether.c  ... CDC Ethernet gadget driver,
         supports high speed link

       5 drivers/usb/gadget/usbstring.c ... optional utility code,
         for use by gadget drivers

       6 kconfig/kbuild support for all the above.

These patches are against 2.5.68 current.  Please merge them
towards Linus' tree.

- Dave







