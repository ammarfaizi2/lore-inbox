Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUEWRkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUEWRkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUEWRkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:40:25 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:31926 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S263188AbUEWRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:40:01 -0400
Subject: Problems with 2.6.6-bk9
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085333998.3245.1.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 23 May 2004 20:39:58 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I get this oops on boot with 2.6.6-bk9, I don't know what it is
caused by:
irq 5: nobody cared!
 [<c0107b1a>] __report_bad_irq+0x2a/0x90
 [<c0107c10>] note_interrupt+0x70/0xa0
 [<c0107e3c>] do_IRQ+0xdc/0xe0
 [<c0106278>] common_interrupt+0x18/0x20
 [<c011c770>] __do_softirq+0x30/0x80
 [<c011c7e6>] do_softirq+0x26/0x30
 [<c0107e23>] do_IRQ+0xc3/0xe0
 [<c0106278>] common_interrupt+0x18/0x20
 [<c024728b>] pci_bus_read_config_byte+0x4b/0x60
 [<f8dc422c>] ehci_start+0x2cc/0x360 [ehci_hcd]
 [<c01197e1>] printk+0x121/0x150
 [<c02c9b17>] usb_register_bus+0x137/0x160
 [<c02ce84b>] usb_hcd_pci_probe+0x2ab/0x4e0
 [<c024aac2>] pci_device_probe_static+0x52/0x70
 [<c024ab1b>] __pci_device_probe+0x3b/0x50
 [<c024ab5c>] pci_device_probe+0x2c/0x50
 [<c026608f>] bus_match+0x3f/0x70
 [<c02661b9>] driver_attach+0x59/0x90
 [<c0266461>] bus_add_driver+0x91/0xb0
 [<c026691f>] driver_register+0x2f/0x40
 [<c024ad4c>] pci_register_driver+0x5c/0x90
 [<f8d99023>] init+0x23/0x30 [ehci_hcd]
 [<c012cf67>] sys_init_module+0x107/0x1d0
 [<c010590b>] syscall_call+0x7/0xb

handlers:
[<c02ca7a0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #5
PCI: cache line size of 64 is not supported by device 0000:00:02.2

This is my lspci:
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 07)
0000:01:06.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev
61)
0000:02:00.0 VGA compatible controller: nVidia Corporation NV 36
[GeForce 5700 Ultra] (rev a1)

        Markus

