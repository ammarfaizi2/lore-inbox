Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVCLBer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVCLBer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCLBeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:34:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:61573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261874AbVCLBcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:32:41 -0500
Date: Fri, 11 Mar 2005 17:32:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
 speedstep even more broken than in 2.6.10
Message-Id: <20050311173233.462971be.akpm@osdl.org>
In-Reply-To: <20050311202122.GA13205@fefe.de>
References: <20050311202122.GA13205@fefe.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
>
> My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> they all work.  In Linux, two of them work.  Putting my USB stick or
> anything else in one of the others produces nothing in Linux.
> Apparently no IRQ getting through or something?
> 
> This is what /proc/interrupts has to say:
> 
>   177:    9503618   IO-APIC-level  ohci_hcd, eth0
> 
> These are the USB boot messages:
> 
>   usbcore: registered new driver usbfs
>   usbcore: registered new driver hub
>   ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
>   ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
>   hub 1-0:1.0: USB hub found
>   ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
>   ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
>   hub 2-0:1.0: USB hub found
>   usbcore: registered new driver usblp
>   drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
>   Initializing USB Mass Storage driver...
>   usb 2-4: new low speed USB device using ohci_hcd and address 2
>   usbcore: registered new driver usb-storage
>   USB Mass Storage support registered.
>   input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on
>   usb-0000:00:02.0-4
>   usbcore: registered new driver usbhid
>   drivers/usb/input/hid-core.c: v2.0:USB HID core driver
>   HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1
> 
> As you can see, it appears to work in principle.

Did it work correctly on any earlier kernel?  If so, which one(s)?
