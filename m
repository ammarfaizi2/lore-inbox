Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUKSTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUKSTMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUKSTMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:12:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14099 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261540AbUKSTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:11:58 -0500
Date: Fri, 19 Nov 2004 20:11:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041119191156.GA2754@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30020B7225@hdsmsx401.amr.corp.intel.com> <20041119155705.GA2766@stusta.de> <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:36:12AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 19 Nov 2004, Adrian Bunk wrote:
> > 
> > It's not a problem (I just wasn't sure, whether enabling APIC might 
> > change something relevant.
> 
> It did. You no longer show the problem. No irq storm.
> 
> So can you disable APIC again, and just remove the non-relevant APIC print 
> calls to get it to compile?

dmesg is below.

> 		Linus

cu
Adrian

Linux version 2.6.10-rc2 (bunk@r063144.stusta.swh.mhn.de) (gcc version 3.4.2 (Debian 3.4.2-3)) #16 Fri Nov 19 19:40:36 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fab70
ACPI: RSDT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff0000
ACPI: FADT (v001 AMIINT SiS740XX 0x00000011 MSFT 0x0100000b) @ 0x0fff0030
ACPI: MADT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff00c0
ACPI: DSDT (v001    SiS      746 0x00000100 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=test ro root=301 mode=1280x1024@760 apic=debug acpi_dbg_level=1
Initializing CPU#0
CPU 0 irqstacks, hard=c0466000 soft=c0465000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1800.276 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255340k/262080k available (2364k kernel code, 6172k reserved, 943k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS (lpj=1781760)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
NTFS driver 2.1.22 [Flags: R/O].
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon QY  DDR SGRAM 64 MB
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xd0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler cfq registered
elevator: using cfq as default io scheduler
irq 6: nobody cared!
 [<c012c0d4>] __report_bad_irq+0x24/0x80
 [<c012c1e1>] note_interrupt+0x81/0xa0
 [<c012bc13>] __do_IRQ+0x143/0x170
 [<c01040ce>] do_IRQ+0x3e/0x60
 =======================
 [<c010271a>] common_interrupt+0x1a/0x20
 [<c0116720>] __do_softirq+0x30/0x90
 [<c01041d1>] do_softirq+0x41/0x50
 =======================
 [<c012ba55>] irq_exit+0x35/0x40
 [<c01040d5>] do_IRQ+0x45/0x60
 [<c010271a>] common_interrupt+0x1a/0x20
 [<c012be74>] setup_irq+0x94/0x110
 [<c0258300>] floppy_hardint+0x0/0x120
 [<c012c07c>] request_irq+0x7c/0xb0
 [<c02584df>] fd_request_irq+0x2f/0x60
 [<c025edab>] floppy_grab_irq_and_dma+0x4b/0x3b0
 [<c044ec5c>] floppy_init+0x1ec/0x5b0
 [<c025ece0>] floppy_find+0x0/0x80
 [<c043c813>] do_initcalls+0x53/0xb0
 [<c0100400>] init+0x0/0x110
 [<c0100400>] init+0x0/0x110
 [<c010042a>] init+0x2a/0x110
 [<c0100818>] kernel_thread_helper+0x0/0x18
 [<c010081d>] kernel_thread_helper+0x5/0x18
handlers:
[<c0258300>] (floppy_hardint+0x0/0x120)
Disabling IRQ #6
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
sis900.c: v1.08.07 11/02/2003
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 6, 00:00:00:00:00:00.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV1604N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.2: irq 10, pci mem 0xcffff000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xd800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 176 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 987988k swap on /dev/hda2.  Priority:-1 extents:1
eth0: Media Link On 10mbps half-duplex 
