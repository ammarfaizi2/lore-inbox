Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUGQGfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUGQGfg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 02:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUGQGfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 02:35:36 -0400
Received: from fmr10.intel.com ([192.55.52.30]:33433 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S266560AbUGQGfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 02:35:33 -0400
Subject: Re: Weird kernel message about irq when loading ehci_hcd
From: Len Brown <len.brown@intel.com>
To: Martin Bammer <e9525103@student.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFF1A@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFF1A@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1090046122.2787.9.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Jul 2004 02:35:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 08:39, Martin Bammer wrote:

> Linux version 2.6.7 (root@bender) (gcc-Version 3.3.3 (Debian
> 20040429)) #1 Wed 

> ehci_hcd 0000:00:02.2: irq 11, pci mem e0e4d000
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> irq 11: nobody cared!
>  [<c0107a1a>] __report_bad_irq+0x2a/0x90
>  [<c0107b10>] note_interrupt+0x70/0xa0
>  [<c0107db1>] do_IRQ+0x121/0x130
>  [<c01061f4>] common_interrupt+0x18/0x20
>  [<c011cab0>] __do_softirq+0x30/0x80
>  [<c011cb26>] do_softirq+0x26/0x30
>  [<c0107d8d>] do_IRQ+0xfd/0x130
>  [<c01061f4>] common_interrupt+0x18/0x20
>  [<c01beb9f>] pci_bus_read_config_byte+0x5f/0x90
>  [<e0e75acc>] ehci_start+0x2cc/0x360 [ehci_hcd]
>  [<c011967d>] printk+0x10d/0x170
>  [<e0e974f7>] usb_register_bus+0x137/0x160 [usbcore]
>  [<e0e9c54b>] usb_hcd_pci_probe+0x2ab/0x4e0 [usbcore]
>  [<c01c24c2>] pci_device_probe_static+0x52/0x70
>  [<c01c251b>] __pci_device_probe+0x3b/0x50
>  [<c01c255c>] pci_device_probe+0x2c/0x50
>  [<c01f698f>] bus_match+0x3f/0x70
>  [<c01f6ab9>] driver_attach+0x59/0x90
>  [<c01f6d61>] bus_add_driver+0x91/0xb0
>  [<c01f721f>] driver_register+0x2f/0x40
>  [<c01c27dc>] pci_register_driver+0x5c/0x90
>  [<e0e57023>] init+0x23/0x30 [ehci_hcd]
>  [<c012ed7f>] sys_init_module+0xff/0x210
>  [<c0106087>] syscall_call+0x7/0xb
> 
> handlers:
> [<e0e982e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
> Disabling IRQ #11

Same failure with latest 2.6.8 kernel?

does the failure change and /proc/interrupts change if booted w/
"acpi=off"?

While it should work in either case, I'm curious why you're using PIC
mode instead of IOAPIC mode.

cheers,
-Len


