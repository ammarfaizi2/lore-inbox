Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269569AbTGOTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTGOTz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:55:56 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:30731 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S269569AbTGOTzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:55:53 -0400
Subject: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all
	needed rpms installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: arjanv@redhat.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058217601.4441.1.camel@aurora.localdomain>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <3F12FF53.7060708@pobox.com>  <1058210139.5981.6.camel@laptop.fenrus.com>
	 <1058217601.4441.1.camel@aurora.localdomain>
Content-Type: text/plain
Message-Id: <1058299838.3358.4.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-2) 
Date: 15 Jul 2003 16:10:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I finally went into interactive boot (taking a moment from my
studies).  I made sure not to let it bring eth0 up, everything worked
fine.  I still got this USB oops.  I hope it means something more to
people.

If I do pci=noacpi and acpi=off then I can boot.  However, I can't use
my mouse with is an MS InteliMouse Explorer 3 on a PS/2 port.  The PS/2
driver did initiate, so did gpm.  However, no mouse in console or X. 
This board is supposed to be fine with Linux acpi, or so I have read
somewhere.  Anyway, USB oops.

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
--
"History is nothing but a collection of fables and useless trifles,
cluttered up with a mass of unnecessary figures and proper names." --
Leo Tolstoy

