Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTDXCzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTDXCzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:55:04 -0400
Received: from lakemtao05.cox.net ([68.1.17.116]:64435 "EHLO
	lakemtao05.cox.net") by vger.kernel.org with ESMTP id S263612AbTDXCym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:54:42 -0400
Subject: 2.5.68-mm2 bttv oops
From: steven roemen <sdroemen1@cox.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051153462.997.159.camel@lws04.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2003 22:04:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's what is in the syslog after booting the 2.5.68-mm2 kernel:
bttv is built into the kernel.

Steve

Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Advanced Micro Devic AMD-760 MP [IGD4-2P]
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 02:05.0, irq: 17, latency: 132, mmio:
0xf8000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is
0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
irq event 17: bogus retval mask c0a31
Call Trace:
 [<c010d2c5>] handle_IRQ_event+0x85/0x100
 [<c010d5a5>] do_IRQ+0xd5/0x1b0
 [<c0108970>] default_idle+0x0/0x40
 [<c0108970>] default_idle+0x0/0x40
 [<c010b858>] <6>bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
common_interrupt+0x18/0x20
 [<c0108970>] default_idle+0x0/0x40
 [<c0108970>] default_idle+0x0/0x40
 [<c010899d>] default_idle+0x2d/0x40
 [<c0108a2a>] cpu_idle+0x3a/0x50
 [<c0123cef>] printk+0x17f/0x1d0

handlers:
[<c02c9e10>] (bttv_irq+0x0/0x2b0)
bttv0: Hauppauge eeprom: model=44801, tuner=Philips FI1236 MK2 (2),
radio=no
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 irq event 17: bogus retval mask c0a31
Call Trace:
 [<c010d2c5>] handle_IRQ_event+0x85/0x100
 [<c010d5a5>] do_IRQ+0xd5/0x1b0
 [<c010b858>] common_interrupt+0x18/0x20
 [<c0321095>] vgacon_cursor+0xa5/0x200
 [<c028d698>] clear_selection+0x18/0x60
 [<c0290462>] set_cursor+0x72/0x90
 [<c0293a39>] vt_console_print+0x1e9/0x2f0
 [<c0123957>] __call_console_drivers+0x57/0x60
 [<c0123a3b>] call_console_drivers+0x5b/0x120
 [<c0123de2>] release_console_sem+0x62/0xf0
 [<c0123cef>] printk+0x17f/0x1d0
 [<c02c52f1>] set_pll+0x101/0x180
 [<c02c5396>] bt848A_set_timing+0x26/0x40
 [<c02c5869>] set_tvnorm+0x89/0xb0
 [<c059a126>] bttv_probe+0x556/0x670
 [<c0258f7e>] pci_device_probe+0x5e/0x70
 [<c02a7c55>] bus_match+0x45/0x80
 [<c02a7d7c>] driver_attach+0x5c/0x70
 [<c02a8062>] bus_add_driver+0xd2/0xe0
 [<c02590b7>] pci_register_driver+0x47/0x60
 [<c02ca163>] bttv_init_module+0x93/0xf0
 [<c057c91b>] do_initcalls+0x2b/0xa0
 [<c013380f>] init_workqueues+0xf/0x26
 [<c01050e7>] init+0x57/0x1f0
 [<c0105090>] init+0x0/0x1f0
 [<c0108b9d>] kernel_thread_helper+0x5/0x18

handlers:
[<c02c9e10>] (bttv_irq+0x0/0x2b0)
irq event 17: bogus retval mask c0a31
Call Trace:
 [<c010d2c5>] handle_IRQ_event+0x85/0x100
 [<c010d5a5>] do_IRQ+0xd5/0x1b0
 [<c010b858>] common_interrupt+0x18/0x20
 [<c025a956>] acpi_os_read_port+0x30/0x45
 [<c026601c>] acpi_hw_low_level_read+0xac/0xb4
 [<c025fc4f>] acpi_ev_gpe_detect+0x83/0x12b
 [<c025e88d>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c025a826>] acpi_irq+0xc/0x13
 [<c010d27e>] handle_IRQ_event+0x3e/0x100
 [<c025a81a>] acpi_irq+0x0/0x13
 [<c010d5a5>] do_IRQ+0xd5/0x1b0
 [<c010b858>] common_interrupt+0x18/0x20
 [<c012761d>] do_softirq+0x5d/0xd0
 [<c0117bf7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c010b8da>] apic_timer_interrupt+0x1a/0x20
 [<c0321095>] vgacon_cursor+0xa5/0x200
 [<c028d698>] clear_selection+0x18/0x60
 [<c0290462>] set_cursor+0x72/0x90
 [<c0293a39>] vt_console_print+0x1e9/0x2f0
 [<c0123957>] __call_console_drivers+0x57/0x60
 [<c0123a3b>] call_console_drivers+0x5b/0x120
 [<c0123de2>] release_console_sem+0x62/0xf0
 [<c0123cef>] printk+0x17f/0x1d0
 [<c02c52f1>] set_pll+0x101/0x180
 [<c02c5396>] bt848A_set_timing+0x26/0x40
 [<c02c5869>] set_tvnorm+0x89/0xb0
 [<c059a126>] bttv_probe+0x556/0x670
 [<c0258f7e>] pci_device_probe+0x5e/0x70
 [<c02a7c55>] bus_match+0x45/0x80
 [<c02a7d7c>] driver_attach+0x5c/0x70
 [<c02a8062>] bus_add_driver+0xd2/0xe0
 [<c02590b7>] pci_register_driver+0x47/0x60
 [<c02ca163>] bttv_init_module+0x93/0xf0
 [<c057c91b>] do_initcalls+0x2b/0xa0
 [<c013380f>] init_workqueues+0xf/0x26
 [<c01050e7>] init+0x57/0x1f0
 [<c0105090>] init+0x0/0x1f0
 [<c0108b9d>] kernel_thread_helper+0x5/0x18

handlers:
[<c02c9e10>] (bttv_irq+0x0/0x2b0)
.. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea642
0,tda8425,pic16c54 (PV951)
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
bttv0: i2c attach [client=Philips NTSC (FI1236,FM1236 and
compatibles),ok]
registering 0-0061


