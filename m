Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTHTOBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTHTOBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:01:25 -0400
Received: from bay1-f130.bay1.hotmail.com ([65.54.245.130]:7952 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261903AbTHTOBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:01:21 -0400
X-Originating-IP: [12.25.43.10]
X-Originating-Email: [ckbroadbus@hotmail.com]
From: "ckbb ckbb" <ckbroadbus@hotmail.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB device not accepting new address=2 (error=-19)
Date: Wed, 20 Aug 2003 10:01:20 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F130ok1Bkfkll10000c83b@hotmail.com>
X-OriginalArrivalTime: 20 Aug 2003 14:01:20.0974 (UTC) FILETIME=[8898D6E0:01C36723]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes it is coustomised board and ISP1161A host controller is connected to a 
fpga device which is on the PCI bus. Infact it is one of the general purpose 
io (gpio-23) to which usb interrupt line is connected and gpio is programmed 
as an interrupt. I am getting the 'sof' interrupt continuously (at every 
1msec) and I can see the corresponding interrupt count in /proc/interrupts 
is incrementing accordingly.

Regarding hc 1161a, I have been told by phillips factory people that the 
driver is working fine with the x86 platform. I did a port to the powerpc 
platform.


>From: Greg KH <greg@kroah.com>
>To: ckbb ckbb <ckbroadbus@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: USB device not accepting new address=2 (error=-19)
>Date: Tue, 19 Aug 2003 16:50:12 -0700
>
>On Tue, Aug 19, 2003 at 07:33:32PM -0400, ckbb ckbb wrote:
> > I am stuck with the following error. I really appreciate any help for 
>this
> > problem. May be it is known bug in the usb stack.
> >
> > I am using linux2.4.21, powerpc processor, phillips 1161a host 
>controller
> >
> > I am getting interrupts & hardware seems to be OK. I have configured 
>EHCI &
> > OHCI, scsi, usb mass storage in the kernel configuration.
> >
> >
> > usb.c: new USB bus registered, assigned bus number 1
> > Product: USB OHCI Root Hub
> > SerialNumber: c7911000
> > hub.c: USB hub found
> > hub.c: 1 port detected
> > hcd_1161.c : usb devices found..
> > usbutil: USB int. status bits cleared 0x00060000
> > usbutil: USB interrupt.1 Enabled ox00020000
> > ISP116x_HCD Initialization Successful
> >
> > usb.c: USB device not accepting new address=2 (error=-19)
> >
> > usb.c: USB device not accepting new address=3 (error=-19)
>
>Looks like a pci interrupt routing issue.  Is the usb host controller
>actually getting interrupts?
>
>Is this a custom motherboard, or is it a Apple machine?
>
>Odds are it's a bug in the hcd_1161 driver as almost no one uses that
>driver and I doubt it is up to date.
>
>thanks,
>
>greg k-h

_________________________________________________________________
<b>MSN 8:</b>  Get 6 months for $9.95/month 
http://join.msn.com/?page=dept/dialup

