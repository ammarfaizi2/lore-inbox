Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262756AbSJHDGA>; Mon, 7 Oct 2002 23:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbSJHDGA>; Mon, 7 Oct 2002 23:06:00 -0400
Received: from shells.hardanger.net ([209.113.172.35]:38154 "EHLO
	server.bohemians.org") by vger.kernel.org with ESMTP
	id <S262756AbSJHDF7>; Mon, 7 Oct 2002 23:05:59 -0400
Date: Tue, 8 Oct 2002 04:11:36 +0100
From: Martin Dahl <dahlm@izno.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41-ac1: Debug: sleeping function called from illegal context at include/asm/semaphore.h:145
Message-ID: <20021008031136.GA1887@izno.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my thinkpad a20m i get the following debug messages during boot:

At IDE initialization:

Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [__kmem_cache_alloc+202/208] __kmem_cache_alloc+0xca/0xd0
 [blk_init_free_list+101/224] blk_init_free_list+0x65/0xe0
 [blk_init_queue+23/256] blk_init_queue+0x17/0x100
 [ide_init_queue+57/160] ide_init_queue+0x39/0xa0
 [do_ide_request+0/48] do_ide_request+0x0/0x30
 [init_irq+462/912] init_irq+0x1ce/0x390
 [ide_intr+0/384] ide_intr+0x0/0x180
 [hwif_init+216/608] hwif_init+0xd8/0x260
 [probe_hwif_init+36/112] probe_hwif_init+0x24/0x70
 [ide_setup_pci_device+80/128] ide_setup_pci_device+0x50/0x80
 [piix_init_one+54/64] piix_init_one+0x36/0x40
 [init+53/352] init+0x35/0x160
 [init+0/352] init+0x0/0x160
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

At USB hub initialization:

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<cc8485e2>] usb_hub_events+0x72/0x3c0 [usbcore]
 [<cc85300b>] .rodata.str1.1+0x42b/0x840 [usbcore]
 [schedule+402/768] schedule+0x192/0x300
 [reparent_to_init+228/384] reparent_to_init+0xe4/0x180
 [<cc848965>] usb_hub_thread+0x35/0xf0 [usbcore]
 [default_wake_function+0/64] default_wake_function+0x0/0x40
 [<cc85b1a0>] khubd_wait+0x0/0x8 [usbcore]
 [<cc85b1a0>] khubd_wait+0x0/0x8 [usbcore]
 [<cc848930>] usb_hub_thread+0x0/0xf0 [usbcore]
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Also, i the following occurs when using the buttons for adjusting audio
volume or anything involving the Fn key.

Debug: sleeping function called from illegal context at include/asm/semaphore.h:145
Call Trace:
 [<c01a14f8>] acpi_os_wait_semaphore+0x1e8/0x240
 [<c01ce53d>] acpi_ut_acquire_mutex+0xdd/0x200
 [<c01b6334>] acpi_ex_enter_interpreter+0x44/0xa0
 [<c01ad33d>] acpi_acquire_global_lock+0x1d/0x60
 [<c01d5ed9>] acpi_ec_query+0x79/0x1c0
 [<c01d61bc>] acpi_ec_gpe_handler+0x8c/0xf0
 [<c01aa319>] acpi_ev_gpe_dispatch+0x229/0x2b0
 [<c01a9f6f>] acpi_ev_gpe_detect+0x14f/0x160
 [<c01aaf4e>] acpi_ev_sci_handler+0x9e/0xc0
 [<c01a0971>] acpi_irq+0x11/0x20
 [<c0108dc5>] handle_IRQ_event+0x45/0x70
 [<c01a0960>] acpi_irq+0x0/0x20
 [<c0108ff7>] do_IRQ+0x97/0x120
 [<c01053f0>] default_idle+0x0/0x40
 [<c01053f0>] default_idle+0x0/0x40
 [<c0107970>] common_interrupt+0x18/0x20
 [<c01053f0>] default_idle+0x0/0x40
 [<c01053f0>] default_idle+0x0/0x40
 [<c0105414>] default_idle+0x24/0x40
 [<c01054aa>] cpu_idle+0x3a/0x50
 [<c0105000>] stext+0x0/0x30

regards,
martin

-- 
Martin Dahl
dahlm@izno.net
