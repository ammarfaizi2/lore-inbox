Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUJBVHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUJBVHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 17:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJBVHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 17:07:31 -0400
Received: from smtp07.web.de ([217.72.192.225]:56971 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S267540AbUJBVH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 17:07:28 -0400
Date: Sat, 2 Oct 2004 23:15:48 +0200
From: Hanno Meyer-Thurow <h.mth@web.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.9-rc3-mm1 USB error on boot
Message-Id: <20041002231548.30e1d8b8.h.mth@web.de>
X-Mailer: Sylpheed version 0.9.12-gtk2-20040918 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please be kind to me, first post on this mailing-list. :)

KERNEL: 2.6.9-rc3-mm1

I get the following lines on boot when it is loading USB code:

ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebfbc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xef00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected

Badness in remove_proc_entry at fs/proc/generic.c:688
 [<b01811e9>] remove_proc_entry+0x14f/0x156
 [<b05287fb>] uhci_hcd_init+0xe4/0xf6
 [<b050e890>] do_initcalls+0x53/0xaf
 [<b015a0d6>] kern_mount+0x15/0x19
 [<b01004d4>] init+0x79/0x17d
 [<b010045b>] init+0x0/0x17d
 [<b010202d>] kernel_thread_helper+0x5/0xb

Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver


my kernel config: http://geki.ath.cx/kernelconfig

If you need any more information, please tell me. And please add me as CC, thanks!
