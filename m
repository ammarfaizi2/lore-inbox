Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTKOLMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 06:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTKOLMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 06:12:34 -0500
Received: from attila.bofh.it ([213.92.8.2]:57034 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261640AbTKOLM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 06:12:29 -0500
Date: Sat, 15 Nov 2003 11:43:28 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031115104328.GB1897@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 3
kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 7
kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 15
kernel: PCI: Using ACPI for IRQ routing

[...]

kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
kernel: VIA8237SATA: chipset revision 128
kernel: VIA8237SATA: 100%% native mode on irq 3
kernel:     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
kernel:     ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
kernel: VP_IDE: chipset revision 6
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
kernel:     ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
kernel:     ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA

kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: hdc: IRQ probe failed (0x3cfa)
kernel: hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
kernel: hdd: 32X10, ATAPI CD/DVD-ROM drive
kernel: irq 15: nobody cared!
kernel: Call Trace:
kernel:  [<c010a92b>] __report_bad_irq+0x2b/0x90
kernel:  [<c010aa24>] note_interrupt+0x64/0xa0
kernel:  [<c010ac2a>] do_IRQ+0xea/0xf0
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c011d0c4>] do_softirq+0x44/0xa0
kernel:  [<c010ac11>] do_IRQ+0xd1/0xf0
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c010aff4>] setup_irq+0x64/0xb0
kernel:  [<c021a730>] ide_intr+0x0/0x130
kernel:  [<c010acaf>] request_irq+0x7f/0xc0
kernel:  [<c021bc86>] init_irq+0x156/0x400
kernel:  [<c021a730>] ide_intr+0x0/0x130
kernel:  [<c021c318>] hwif_init+0xb8/0x250
kernel:  [<c021b94c>] probe_hwif_init+0x2c/0x80
kernel:  [<c022761a>] ide_setup_pci_device+0x7a/0x80
kernel:  [<c021902d>] via_init_one+0x3d/0x50
kernel:  [<c039791d>] ide_scan_pcidev+0x5d/0x70
kernel:  [<c0397976>] ide_scan_pcibus+0x46/0xd0
kernel:  [<c0397823>] probe_for_hwifs+0x13/0x20
kernel:  [<c0397838>] ide_init_builtin_drivers+0x8/0x20
kernel:  [<c0397898>] ide_init+0x48/0x70
kernel:  [<c038674b>] do_initcalls+0x2b/0xa0
kernel:  [<c01278b2>] init_workqueues+0x12/0x60
kernel:  [<c0105097>] init+0x27/0x110
kernel:  [<c0105070>] init+0x0/0x110
kernel:  [<c01072a9>] kernel_thread_helper+0x5/0xc
kernel: 
kernel: handlers:
kernel: [<c021a730>] (ide_intr+0x0/0x130)
kernel: Disabling IRQ #15
kernel: ide1 at 0x170-0x177,0x376 on irq 15


Trying to mount a cdrom fails:

kernel: hdc: lost interrupt
kernel: hdc: lost interrupt
kernel: irq 15: nobody cared!
kernel: Call Trace:
kernel:  [<c010a92b>] __report_bad_irq+0x2b/0x90
kernel:  [<c010aa24>] note_interrupt+0x64/0xa0
kernel:  [<c010ac2a>] do_IRQ+0xea/0xf0
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c021a5af>] ide_timer_expiry+0xdf/0x1b0
kernel:  [<c021a4d0>] ide_timer_expiry+0x0/0x1b0
kernel:  [<c0120e90>] run_timer_softirq+0xb0/0x170
kernel:  [<c011d116>] do_softirq+0x96/0xa0
kernel:  [<c010ac11>] do_IRQ+0xd1/0xf0
kernel:  [<c0105000>] rest_init+0x0/0x30
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c0105000>] rest_init+0x0/0x30
kernel:  [<c0107066>] default_idle+0x26/0x30
kernel:  [<c01070e4>] cpu_idle+0x34/0x40
kernel:  [<c03866f0>] start_kernel+0x140/0x150
kernel:  [<c0386480>] unknown_bootoption+0x0/0x100
kernel: 
kernel: handlers:
kernel: [<c021a730>] (ide_intr+0x0/0x130)
kernel: Disabling IRQ #15
kernel: hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
kernel: Uniform CD-ROM driver Revision: 3.12
kernel: hdc: lost interrupt
last message repeated 2 times
kernel: irq 15: nobody cared!
kernel: Call Trace:
kernel:  [<c010a92b>] __report_bad_irq+0x2b/0x90
kernel:  [<c010aa24>] note_interrupt+0x64/0xa0
kernel:  [<c010ac2a>] do_IRQ+0xea/0xf0
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c010a8b0>] handle_IRQ_event+0x20/0x70
kernel:  [<c010abbc>] do_IRQ+0x7c/0xf0
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c021a5af>] ide_timer_expiry+0xdf/0x1b0
kernel:  [<c021a4d0>] ide_timer_expiry+0x0/0x1b0
kernel:  [<c0120e90>] run_timer_softirq+0xb0/0x170
kernel:  [<c011d116>] do_softirq+0x96/0xa0
kernel:  [<c010ac11>] do_IRQ+0xd1/0xf0
kernel:  [<c0105000>] rest_init+0x0/0x30
kernel:  [<c01092a0>] common_interrupt+0x18/0x20
kernel:  [<c0105000>] rest_init+0x0/0x30
kernel:  [<c0107066>] default_idle+0x26/0x30
kernel:  [<c01070e4>] cpu_idle+0x34/0x40
kernel:  [<c03866f0>] start_kernel+0x140/0x150
kernel:  [<c0386480>] unknown_bootoption+0x0/0x100
kernel: 
kernel: handlers:
kernel: [<c021a730>] (ide_intr+0x0/0x130)
kernel: Disabling IRQ #15
[...]

And it also breaks a bit the mouse:

kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.


           CPU0       
  0:    3167529          XT-PIC  timer
  1:       8602          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  uhci_hcd, uhci_hcd
  5:          0          XT-PIC  ehci_hcd, VIA8233
  7:          1          XT-PIC  uhci_hcd, uhci_hcd
  8:          5          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      12024          XT-PIC  SysKonnect SK-98xx
 11:          0          XT-PIC  saa7134[0]
 12:      50940          XT-PIC  i8042
 14:      31247          XT-PIC  ide0
 15:    1000005          XT-PIC  ide1
NMI:          0 
ERR:          0

This is an ASUS A7V600 motherboard.


00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 Ethernet controller: 3Com Corporation 3c940 1000Base? (rev 12)
00:0a.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:10.5 Network controller: VIA Technologies, Inc.: Unknown device d104
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 60)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964 (rev 01)
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5d44 (rev 01)

-- 
ciao, |
Marco | [3062 cavlf5SFtruTs]
