Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTEELiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTEELiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:38:20 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:5248 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S262148AbTEELiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:38:12 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: oops 2.5.68 ohci1394/ IRQ/acpi
Date: Mon, 5 May 2003 13:50:41 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305051350.41340.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

If somebody wants more information,
I can send them privately.

Regards.

Nicolas.


Booting with 2.5.68

May  4 17:25:03 hal9003 kernel: ohci1394_0: Unexpected PCI resource length of 
1000!
May  4 17:25:03 hal9003 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[17]  
MMIO=[e8704000-e87047ff]  Max Packet=[2048]
May  4 17:25:03 hal9003 kernel: Intel 810 + AC97 Audio, version 0.24, 19:53:59 
Apr 24 2003
May  4 17:25:03 hal9003 kernel: i810: SiS 7012 found at IO 0xb800 and 0xb400, 
MEM 0x0000 and 0x0000, IRQ 18
May  4 17:25:03 hal9003 kernel: ieee1394: Host added: ID:BUS[1-00:1023]  
GUID[000010dc0021c3e5]
May  4 17:25:03 hal9003 kernel: i810_audio: Audio Controller supports 6 
channels.

and with 2.5.69 :

May  5 13:36:56 hal9003 kernel: ohci1394: $Rev: 921 $ Ben Collins 
<bcollins@debian.org>
May  5 13:36:56 hal9003 kernel: ohci1394_0: Unexpected PCI resource length of 
1000!
May  5 13:36:56 hal9003 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[17]  
MMIO=[e8704000-e87047ff]  Max Packet=[2048]
May  5 13:36:56 hal9003 kernel: irq 9: nobody cared!
May  5 13:36:56 hal9003 kernel: Call Trace:
May  5 13:36:56 hal9003 kernel:  [handle_IRQ_event+136/253] 
handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [<c010b026>] handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [do_IRQ+146/261] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [<c010b202>] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [<c0109950>] common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [object_depth+11/20] object_depth+0xb/0x14
May  5 13:36:56 hal9003 kernel:  [<c01776cc>] object_depth+0xb/0x14
May  5 13:36:56 hal9003 kernel:  [sysfs_create_link+28/296] 
sysfs_create_link+0x1c/0x128
May  5 13:36:56 hal9003 kernel:  [<c017776c>] sysfs_create_link+0x1c/0x128
May  5 13:36:56 hal9003 kernel:  [_end+945077628/1070014108] 
ohci1394_pci_driver+0x40/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ee0>] ohci1394_pci_driver+0x40/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945067276/1070014108] +0x1c/0xec 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d5670>] +0x1c/0xec [ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [device_bind_driver+66/73] 
device_bind_driver+0x42/0x49
May  5 13:36:56 hal9003 kernel:  [<c01f8555>] device_bind_driver+0x42/0x49
May  5 13:36:56 hal9003 kernel:  [_end+945077628/1070014108] 
ohci1394_pci_driver+0x40/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ee0>] ohci1394_pci_driver+0x40/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [bus_match+108/110] bus_match+0x6c/0x6e
May  5 13:36:56 hal9003 kernel:  [<c01f85c8>] bus_match+0x6c/0x6e
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [driver_attach+92/96] driver_attach+0x5c/0x60
May  5 13:36:56 hal9003 kernel:  [<c01f86a1>] driver_attach+0x5c/0x60
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [bus_add_driver+157/178] 
bus_add_driver+0x9d/0xb2
May  5 13:36:56 hal9003 kernel:  [<c01f891f>] bus_add_driver+0x9d/0xb2
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077788/1070014108] +0x0/0x200 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f80>] +0x0/0x200 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [driver_register+49/53] 
driver_register+0x31/0x35
May  5 13:36:56 hal9003 kernel:  [<c01f8d1f>] driver_register+0x31/0x35
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [pci_register_driver+67/83] 
pci_register_driver+0x43/0x53
May  5 13:36:56 hal9003 kernel: 01c07a1>] pci_register_driver+0x43/0x53
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+944960612/1070014108] 
ohci1394_init+0x15/0x4d [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88bb5c8>] ohci1394_init+0x15/0x4d 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077564/1070014108] 
ohci1394_pci_driver+0x0/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ea0>] ohci1394_pci_driver+0x0/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [sys_init_module+258/423] 
sys_init_module+0x102/0x1a7
May  5 13:36:56 hal9003 kernel:  [<c012ed22>] sys_init_module+0x102/0x1a7
May  5 13:36:56 hal9003 kernel:  [_end+945077788/1070014108] +0x0/0x200 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f80>] +0x0/0x200 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  5 13:36:56 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  5 13:36:56 hal9003 kernel:
May  5 13:36:56 hal9003 kernel: handlers:
May  5 13:36:56 hal9003 kernel: [acpi_irq+0/17] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: [<c01c1ff0>] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: irq 9: nobody cared!
May  5 13:36:56 hal9003 kernel: Call Trace:
May  5 13:36:56 hal9003 kernel:  [handle_IRQ_event+136/253] 
handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [<c010b026>] handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [do_IRQ+146/261] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [<c010b202>] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [<c0109950>] common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [do_softirq+67/163] do_softirq+0x43/0xa3
May  5 13:36:56 hal9003 kernel:  [<c01200e3>] do_softirq+0x43/0xa3
May  5 13:36:56 hal9003 kernel:  [do_IRQ+223/261] do_IRQ+0xdf/0x105
May  5 13:36:56 hal9003 kernel:  [<c010b24f>] do_IRQ+0xdf/0x105
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [<c0109950>] common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [object_depth+11/20] object_depth+0xb/0x14
May  5 13:36:56 hal9003 kernel:  [<c01776cc>] object_depth+0xb/0x14
May  5 13:36:56 hal9003 kernel:  [sysfs_create_link+28/296] 
sysfs_create_link+0x1c/0x128
May  5 13:36:56 hal9003 kernel:  [<c017776c>] sysfs_create_link+0x1c/0x128
May  5 13:36:56 hal9003 kernel:  [_end+945077628/1070014108] 
ohci1394_pci_driver+0x40/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ee0>] ohci1394_pci_driver+0x40/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945067276/1070014108] +0x1c/0xec 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d5670>] +0x1c/0xec [ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077672/1070014108] 
ohci1394_pci_driver+0x6c/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f0c>] ohci1394_pci_driver+0x6c/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [device_bind_driver+66/73] 
device_bind_driver+0x42/0x49
May  5 13:36:56 hal9003 kernel:  [<c01f8555>] device_bind_driver+0x42/0x49
May  5 13:36:56 hal9003 kernel:  [_end+945077628/1070014108] 
ohci1394_pci_driver+0x40/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ee0>] ohci1394_pci_driver+0x40/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [bus_match+108/110] bus_match+0x6c/0x6e
May  5 13:36:56 hal9003 kernel:  [<c01f85c8>] bus_match+0x6c/0x6e
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [driver_attach+92/96] driver_attach+0x5c/0x60
May  5 13:36:56 hal9003 kernel:  [<c01f86a1>] driver_attach+0x5c/0x60
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [bus_add_driver+157/178] 
bus_add_driver+0x9d/0xb2
May  5 13:36:56 hal9003 kernel:  [<c01f891f>] bus_add_driver+0x9d/0xb2
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077788/1070014108] +0x0/0x200 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f80>] +0x0/0x200 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [driver_register+49/53] 
driver_register+0x31/0x35
May  5 13:36:56 hal9003 kernel:  [<c01f8d1f>] driver_register+0x31/0x35
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [pci_register_driver+67/83] 
pci_register_driver+0x43/0x53
May  5 13:36:56 hal9003 kernel:  [<c01c07a1>] pci_register_driver+0x43/0x53
May  5 13:36:56 hal9003 kernel:  [_end+945077604/1070014108] 
ohci1394_pci_driver+0x28/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ec8>] ohci1394_pci_driver+0x28/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+944960612/1070014108] 
ohci1394_init+0x15/0x4d [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88bb5c8>] ohci1394_init+0x15/0x4d 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [_end+945077564/1070014108] 
ohci1394_pci_driver+0x0/0xe0 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7ea0>] ohci1394_pci_driver+0x0/0xe0 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [sys_init_module+258/423] 
sys_init_module+0x102/0x1a7
May  5 13:36:56 hal9003 kernel:  [<c012ed22>] sys_init_module+0x102/0x1a7
May  5 13:36:56 hal9003 kernel:  [_end+945077788/1070014108] +0x0/0x200 
[ohci1394]
May  5 13:36:56 hal9003 kernel:  [<f88d7f80>] +0x0/0x200 [ohci1394]
May  5 13:36:56 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  5 13:36:56 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  5 13:36:56 hal9003 kernel:
May  5 13:36:56 hal9003 kernel: handlers:
May  5 13:36:56 hal9003 kernel: [acpi_irq+0/17] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: [<c01c1ff0>] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: Intel 810 + AC97 Audio, version 0.24, 13:32:21 
May  5 2003
May  5 13:36:56 hal9003 kernel: i810: SiS 7012 found at IO 0xb800 and 0xb400, 
MEM 0x0000 and 0x0000, IRQ 18
May  5 13:36:56 hal9003 kernel: ieee1394: Host added: ID:BUS[0-00:1023]  
GUID[0000000000000000]
May  5 13:36:56 hal9003 kernel: irq 9: nobody cared!
May  5 13:36:56 hal9003 kernel: Call Trace:
May  5 13:36:56 hal9003 kernel:  [handle_IRQ_event+136/253] 
handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [<c010b026>] handle_IRQ_event+0x88/0xfd
May  5 13:36:56 hal9003 kernel:  [do_IRQ+146/261] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [<c010b202>] do_IRQ+0x92/0x105
May  5 13:36:56 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [<c0107029>] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [<c0107029>] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [<c0109950>] common_interrupt+0x18/0x20
May  5 13:36:56 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [<c0107029>] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [<c0107029>] default_idle+0x0/0x2c
May  5 13:36:56 hal9003 kernel:  [default_idle+39/44] default_idle+0x27/0x2c
May  5 13:36:56 hal9003 kernel:  [<c0107050>] default_idle+0x27/0x2c
May  5 13:36:56 hal9003 kernel:  [cpu_idle+49/58] cpu_idle+0x31/0x3a
May  5 13:36:56 hal9003 kernel:  [<c01070c1>] cpu_idle+0x31/0x3a
May  5 13:36:56 hal9003 kernel:  [_stext+0/42] rest_init+0x0/0x2a
May  5 13:36:56 hal9003 kernel:  [<c0105000>] rest_init+0x0/0x2a
May  5 13:36:56 hal9003 kernel:  [start_kernel+312/314] 
start_kernel+0x138/0x13a
May  5 13:36:56 hal9003 kernel:  [<c03106a5>] start_kernel+0x138/0x13a
May  5 13:36:56 hal9003 kernel:  [unknown_bootoption+0/250] 
unknown_bootoption+0x0/0xfa
May  5 13:36:56 hal9003 kernel:  [<c031043f>] unknown_bootoption+0x0/0xfa
May  5 13:36:56 hal9003 kernel:
May  5 13:36:56 hal9003 kernel: handlers:
May  5 13:36:56 hal9003 kernel: [acpi_irq+0/17] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: [<c01c1ff0>] (acpi_irq+0x0/0x11)
May  5 13:36:56 hal9003 kernel: i810_audio: Audio Controller supports 6 
channels.

