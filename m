Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJMMVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTJMMVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:21:38 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:9700 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261705AbTJMMVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:21:35 -0400
Subject: Re: Weird stuff with USB and Bluetooth
From: Stian Jordet <liste@jordet.nu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1066046816.14514.257.camel@pegasus>
References: <1065744760.1344.2.camel@chevrolet.hybel>
	 <20031011023158.GE19749@kroah.com>  <1066046816.14514.257.camel@pegasus>
Content-Type: text/plain
Message-Id: <1066047713.16335.16.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 13 Oct 2003 14:21:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 13.10.2003 kl. 14.06 skrev Marcel Holtmann:
> Hi Greg,
> 
> > > I get these lines in my dmesg at boot-time:
> > > 
> > > usb 1-2: device not accepting address 3, error -110
> > > hci_usb: probe of 1-2:1.1 failed with error -5
> > > hci_usb: probe of 1-2:1.2 failed with error -5
> > > usb 1-2: USB disconnect, address 4
> > > usb 1-2: device not accepting address 5, error -110
> > > hci_usb: probe of 1-2:1.1 failed with error -5
> > > hci_usb: probe of 1-2:1.2 failed with error -5
> > > 
> > > Which often means that the usb-hc can't get an interrupt, I have read.
> > > The "problem" is that I have several usb devices (scanner, printer,
> > > usbserial, hid) and I get no such error with them, only the Bluetooth.
> > > And even weirder, the BT-dongle works just perfect.
> > > 
> > > So my question is; what does this messages means?
> > 
> > You have a broken device, sorry.
> 
> this is not the complete story. Some USB Bluetooth devices are buggy,
> that's right, but in some cases the USB host controller is acting very
> weird. The ACER BT-500 for example shows the same error on all of my
> UHCI based devices (with usb-uhci.o and uhci.o in 2.4), but with a NEC
> USB 2.0 card and usb-ohci.o it works fine every time. But if the device
> is already plugged in and the UHCI host driver is loaded later, the
> device works. Also unloading/reloading of the UHCI host driver helps to
> get this device working.

Thanks for your reply :) This is e 3Com BT-dongle. Anyway, I don't have
to unload/reload the UHCI host driver. The device just works, even with
these errors. I'm quite sure I didn't saw this error earlier (like
2.5.65, or something). I will check that later tonight.

Thanks :)

Best regards,
Stian

