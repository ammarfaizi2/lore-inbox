Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268387AbSIRVEv>; Wed, 18 Sep 2002 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268395AbSIRVEv>; Wed, 18 Sep 2002 17:04:51 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:29850 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S268387AbSIRVEu>; Wed, 18 Sep 2002 17:04:50 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A6A@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux hot swap support
Date: Wed, 18 Sep 2002 17:09:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our HW uses an AMCC S5935 PCI controller. Right now, since we own both
device and SW, we are using a simple interrupt mechanism to accomplish the
hot swap. 

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, September 18, 2002 5:06 PM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support


On Wed, Sep 18, 2002 at 04:59:08PM -0400, Bloch, Jack wrote:
> Ok, my driver is for a specific cPCI biard which we have developed here. I
> want the Linux Kernel to tell me when this board is inserted and/or
removed.

That will already happen today.  /sbin/hotplug will be called whenever a
new PCI card is added or removed, IF you have a PCI Hotplug controller
driver that works for your cPCI board.

> I am running on a 700Mhz PIII with a 2.4.18-3 Kernel (Red Hat 7.3) My
driver
> is written with a call to pci_module_init in the init routine wherein I
> specify a probe and remove routine. According to Linux Device Drivers 2nd
> edition (pages 489 - 493), As long as the HW supports hot swap, I should
get
> called automatically whenevr one of the devices (vendor ID device ID)
which
> I specified in my table gets inserted or ejected. Am I totaly wrong about
> this? I am not trying to write a driver for a hotplug controller but for a
> device.

Yes, you are correct.  But odds are there is not a PCI Hotplug
controller for your hardware, so this probably will not work.  However,
your driver should work just fine to control your card.

What kind of cPCI controller do you have?

thanks,

greg k-h
