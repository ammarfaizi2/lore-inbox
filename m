Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWB1Usb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWB1Usb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWB1Usa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:48:30 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53419 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932479AbWB1Us2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:48:28 -0500
Date: Tue, 28 Feb 2006 15:48:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] usb usb5: Manufacturer: Linux 2.6.16-rc5-mm1
 ehci_hcd
In-Reply-To: <20060228194050.GA7793@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.44L0.0602281543570.5088-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Alexey Dobriyan wrote:

> Lines like the one below puzzle me for a couple -mm's:
> 
> usb usb5: new device found, idVendor=0000, idProduct=0000
> usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb5: Product: EHCI Host Controller
> ==>	usb usb5: Manufacturer: Linux 2.6.16-rc5-mm1 ehci_hcd	<==
> usb usb5: SerialNumber: 0000:00:1d.7
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 8 ports detected
> 
> Is it supposed to contain "Intel" and "Corporation"?
> 
> P.S.: 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
>       USB2 EHCI Controller (rev 02)

The log is not supposed to say "Intel Corporation".

The controller hardware does not contain a manufacturer string anywhere,
so instead the driver makes up a name based on the current kernel version.  
(Likewise for the serial number; the driver makes up a name based on the
device's path.)

The name you see in the lspci output actually comes from the lspci program
itself, based on a code number embedded in the controller.

It has always been this way, and not just in -mm.

Alan Stern

