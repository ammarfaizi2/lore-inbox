Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271342AbTGQC4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271344AbTGQC4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:56:47 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:25107 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S271342AbTGQC4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:56:44 -0400
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
	installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307160148420.32541@montezuma.mastecende.com>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <Pine.LNX.4.53.0307160148420.32541@montezuma.mastecende.com>
Content-Type: text/plain
Message-Id: <1058411485.4705.20.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-2) 
Date: 16 Jul 2003 23:11:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 14:59, Zwane Mwaikambo wrote:
> Can you capture that message? Perhaps your network card and sound card 
> share an interrupt?
> 
> 	Zwane

Sure, I sent it to the list already, here it is again.  This is some
time before the ethernet card driver gets loaded, etc.  Hopefully this
helps clear things up.

kernel: ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
kernel: irq 3: nobody cared!
kernel: Call Trace:
kernel:  [<c010c12a>] __report_bad_irq+0x2a/0x90
kernel:  [<c010c21c>] note_interrupt+0x6c/0xb0
kernel:  [<c010c42d>] do_IRQ+0xed/0x110
kernel:  [<c010a9f8>] common_interrupt+0x18/0x20
kernel:  [<c011f700>] do_softirq+0x40/0xa0
kernel:  [<c010c414>] do_IRQ+0xd4/0x110
kernel:  [<c010a9f8>] common_interrupt+0x18/0x20
kernel:  [<c010c84e>] setup_irq+0x6e/0xb0
kernel:  [<e087e310>] usb_hcd_irq+0x0/0x60 [usbcore]
kernel:  [<c010c4d0>] request_irq+0x80/0xd0
kernel:  [<e08813f6>] usb_hcd_pci_probe+0x1d6/0x440 [usbcore]
kernel:  [<e087e310>] usb_hcd_irq+0x0/0x60 [usbcore]
kernel:  [<c0180033>] t_start+0x43/0x50
kernel:  [<c01a92f2>] pci_device_probe_static+0x52/0x70
kernel:  [<c01a940c>] __pci_device_probe+0x3c/0x50
kernel:  [<c01a944f>] pci_device_probe+0x2f/0x50
kernel:  [<c01ea715>] bus_match+0x45/0x80
kernel:  [<c01ea82c>] driver_attach+0x5c/0x60
kernel:  [<c01eab17>] bus_add_driver+0xa7/0xc0
kernel:  [<c01eaf9f>] driver_register+0x2f/0x40
kernel:  [<c01a9700>] pci_register_driver+0x70/0xa0
kernel:  [<e0824021>] init+0x21/0x4f [ehci_hcd]
kernel:  [<c01303bb>] sys_init_module+0x10b/0x1e0
kernel:  [<c010a839>] sysenter_past_esp+0x52/0x71
kernel: handlers:
kernel: [<e087e310>] (usb_hcd_irq+0x0/0x60 [usbcore])
kernel: Disabling IRQ #3
kernel: ehci_hcd 0000:00:02.2: irq 3, pci mem e0815000
kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus
number 1

           CPU0
  0:    4758778          XT-PIC  timer
  1:      56138          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       6726          XT-PIC  ehci-hcd, NVIDIA nForce Audio
  5:          0          XT-PIC  ohci1394
  8:          1          XT-PIC  rtc
 11:     179558          XT-PIC  usb-ohci, usb-ohci, eth0
 12:     509617          XT-PIC  PS/2 Mouse
 14:     378329          XT-PIC  ide0
 15:     657852          XT-PIC  ide1

Trever
--
"I conceive that a great part of the miseries of mankind are brought
upon them by the false estimates they have made of the value of things."
-- Benjamin Franklin

