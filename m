Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVBSW2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVBSW2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBSW2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:28:01 -0500
Received: from smtpout4.uol.com.br ([200.221.4.195]:60096 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262066AbVBSW1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:27:38 -0500
Date: Sat, 19 Feb 2005 20:27:31 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
Message-ID: <20050219222730.GA5928@ime.usp.br>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
	hostap@shmoo.com
References: <4214450B.6090006@triplehelix.org> <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 17 2005, Linus Torvalds wrote:
> Does the box still work? It may well be that once all drivers have had a 
> chance to initialize their hardware properly, the problem is just gone, 
> and that the interim reports about not being able to handle the irq are 
> just temporary noise.

I started seeing a similar message (irq 10: nobody cared!) right after I've
bought a (IDE) DVD recorder and decided to rearrange my drives so that each
one would not interfere with the others.

An excerpt of the messages that I get with kernel 2.6.10-rc4 is the
following:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Linux version 2.6.11-rc4-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #1 Sun Feb 13 15:23:03 BRST 2005
(...)
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
(...)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
(...)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: QUANTUM FIREBALL CX13.0A, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
irq 10: nobody cared!
 [<c0128fc1>] __report_bad_irq+0x31/0x77
 [<c012906b>] note_interrupt+0x4c/0x71
 [<c0128c86>] __do_IRQ+0x93/0xbd
 [<c0104635>] do_IRQ+0x19/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c011935c>] __do_softirq+0x2c/0x7d
 [<c01193cf>] do_softirq+0x22/0x26
 [<c010463a>] do_IRQ+0x1e/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c0128d89>] enable_irq+0x88/0x8d
 [<c021edc0>] probe_hwif+0x2da/0x366
 [<c021a137>] ata_attach+0xa3/0xbd
 [<c021ee5c>] probe_hwif_init_with_fixup+0x10/0x74
 [<c0221597>] ide_setup_pci_device+0x72/0x7f
 [<c0216f82>] pdc202xx_init_one+0x15/0x18
 [<c039182e>] ide_scan_pcidev+0x34/0x59
 [<c039186f>] ide_scan_pcibus+0x1c/0x88
 [<c039179f>] probe_for_hwifs+0xb/0xd
 [<c03917e5>] ide_init+0x44/0x59
 [<c037c6ce>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c021c2a6>] (ide_intr+0x0/0xee)
Disabling IRQ #10
irq 10: nobody cared!
 [<c0128fc1>] __report_bad_irq+0x31/0x77
 [<c012906b>] note_interrupt+0x4c/0x71
 [<c0128c86>] __do_IRQ+0x93/0xbd
 [<c0104635>] do_IRQ+0x19/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c011935c>] __do_softirq+0x2c/0x7d
 [<c01193cf>] do_softirq+0x22/0x26
 [<c010463a>] do_IRQ+0x1e/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c0128d89>] enable_irq+0x88/0x8d
 [<c021cfb7>] ide_config_drive_speed+0x168/0x30d
 [<c02165c2>] pdc202xx_tune_chipset+0x38c/0x396
 [<c021ee0a>] probe_hwif+0x324/0x366
 [<c021a137>] ata_attach+0xa3/0xbd
 [<c021ee5c>] probe_hwif_init_with_fixup+0x10/0x74
 [<c0221597>] ide_setup_pci_device+0x72/0x7f
 [<c0216f82>] pdc202xx_init_one+0x15/0x18
 [<c039182e>] ide_scan_pcidev+0x34/0x59
 [<c039186f>] ide_scan_pcibus+0x1c/0x88
 [<c039179f>] probe_for_hwifs+0xb/0xd
 [<c03917e5>] ide_init+0x44/0x59
 [<c037c6ce>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c021c2a6>] (ide_intr+0x0/0xee)
Disabling IRQ #10
irq 10: nobody cared!
 [<c0128fc1>] __report_bad_irq+0x31/0x77
 [<c012906b>] note_interrupt+0x4c/0x71
 [<c0128c86>] __do_IRQ+0x93/0xbd
 [<c0104635>] do_IRQ+0x19/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c011935c>] __do_softirq+0x2c/0x7d
 [<c01193cf>] do_softirq+0x22/0x26
 [<c010463a>] do_IRQ+0x1e/0x24
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c0128d89>] enable_irq+0x88/0x8d
 [<c021cfb7>] ide_config_drive_speed+0x168/0x30d
 [<c02165c2>] pdc202xx_tune_chipset+0x38c/0x396
 [<c02168da>] config_chipset_for_dma+0x216/0x227
 [<c0216922>] pdc202xx_config_drive_xfer_rate+0x37/0x6c
 [<c021ee31>] probe_hwif+0x34b/0x366
 [<c021a137>] ata_attach+0xa3/0xbd
 [<c021ee5c>] probe_hwif_init_with_fixup+0x10/0x74
 [<c0221597>] ide_setup_pci_device+0x72/0x7f
 [<c0216f82>] pdc202xx_init_one+0x15/0x18
 [<c039182e>] ide_scan_pcidev+0x34/0x59
 [<c039186f>] ide_scan_pcibus+0x1c/0x88
 [<c039179f>] probe_for_hwifs+0xb/0xd
 [<c03917e5>] ide_init+0x44/0x59
 [<c037c6ce>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c021c2a6>] (ide_intr+0x0/0xee)
Disabling IRQ #10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hde: max request size: 128KiB
hde: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4
hdg: max request size: 128KiB
hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
hdg: cache flushes not supported
 hdg: hdg1
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
(...)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I already tried booting with options irqpoll, acpi=off, acpi=noirq etc, but
none of these things made the problem go away.

The only thing that made it really go away was when I disconnected the
/dev/hdg drive. Then, no scary message is shown, but, of course, I need the
/dev/hdg drive. :-(

Here is what /proc/interrupts says about my computer:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
           CPU0       
  0:    6083684          XT-PIC  timer
  1:          9          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:      14134          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:     321152          XT-PIC  acpi, uhci_hcd, uhci_hcd, eth0, eth1
 10:     662550          XT-PIC  ide2, ide3, ohci1394
 11:      30183          XT-PIC  Ensoniq AudioPCI, mga@PCI:1:0:0
 12:     100706          XT-PIC  i8042
 14:         26          XT-PIC  ide0
 15:         26          XT-PIC  ide1
NMI:          0 
LOC:    6083598 
ERR:         31
MIS:          0
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Is there anything that I can do to make this error message go away? Please,
don't hesitate to ask for any further information.


Thank you very much in advance for any help, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
