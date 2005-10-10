Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVJJDZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVJJDZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJJDZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 23:25:30 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:32736 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932333AbVJJDZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 23:25:29 -0400
Subject: Re: USB-> bluetooth adapter problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Luke Albers <gtg940r@mail.gatech.edu>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <4349B920.4090105@mail.gatech.edu>
References: <43499A44.2070803@mail.gatech.edu>
	 <1128898123.19569.28.camel@blade>  <4349B920.4090105@mail.gatech.edu>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 05:25:43 +0200
Message-Id: <1128914743.19569.38.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

> Under "Bluetooth subsystem support" I removed support for "SCO links 
> support", and then under "Bluetooth device drivers" I removed SCO 
> (voice) support.  What is still left:
> 
> HCI USB driver
> HCI UART driver
>       -UART (H4) protocol support
>       -BCSP protocol support
> HCI BCM203x USB driver
> HCI BlueFRITZ! USB driver
> HCI VHCI (Virtual HCI device) driver
> 
> I realize that some of these shouldnt be in there, but I don't think 
> they are causing problems, either.  Anyway, after I removed the items 
> mentioned above, and after plugging in the bluetooth adapter, this is 
> what I get:
> 
> Oct  9 20:24:17 Obliterus usb 4-1: new full speed USB device using 
> uhci_hcd and address 2
> Oct  9 20:24:18 Obliterus usb 4-1: USB disconnect, address 2
> Oct  9 20:24:18 Obliterus Bluetooth: HCI USB driver ver 2.8
> Oct  9 20:24:18 Obliterus usbcore: registered new driver hci_usb
> 
> So it looks like it immediately disconnects.  It doesn't show up with 
> lspci at all either.  I havent tried using the hci_usb as a module and 
> setting isoc=0 yet, but am I correct that removing the SCO stuff from 
> the kernel took care of the problem, since I no longer get the same message? 

build them as modules and do what I told you. Check what lsusb says and
what's in /proc/bus/usb/devices. What kernel version are you using?

Regards

Marcel


