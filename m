Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGEVFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGEVFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUGEVFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:05:52 -0400
Received: from bender.bawue.de ([193.7.176.20]:37070 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262328AbUGEVE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:04:28 -0400
Date: Mon, 5 Jul 2004 23:04:20 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Len Brown <len.brown@intel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: System not booting after acpi_power_off()
Message-ID: <20040705210420.GA23177@sommrey.de>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <A6974D8E5F98D511BB910002A50A6647615FF35A@hdsmsx403.hd.intel.com> <1089059128.15675.77.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1089059128.15675.77.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 05, 2004 at 04:25:28PM -0400, Len Brown wrote:
> On Wed, 2004-06-30 at 16:36, Joerg Sommrey wrote:
> > Hello,
> > 
> > my box behaves a bit strange after "shutdown -h".  The system performs
> > a
> > clean shutdown, but afterwards the front-side power button doesn't
> > power-on anymore.  After turning off power completely for 5 - 10 sec
> > using the power supply's rear-side switch system boots again.  I found
> > a
> > hint that this might be caused by a power supply that doesn't fully
> > conform to ATX 2.01.  Though this might be the real cause of my
> > problem,
> > I'd like to know if there is a workaround.  Shutting down from an
> > older
> > Knoppix-CD (kernel 2.4.20 using apm) works fine, i.e. "front-side
> > power-on" works.  However, with 2.6 running on a SMP box there seems
> > to
> > be no way to poweroff via apm.
> > 
> > Is there a way to let machine_power_off() behave like apm_power_off()
> > on
> > a SMP box?
> > 
> > My system:
> > kernel: 2.6.7-mm1 (same with other 2.4 and 2.6)
> > CPU:    2 x Athlon MP
> > board:  Tyan Tiger MPX (S2466)
> 
> It is possible that you have a Control Method power button
> rather than Fixed Function, and that it is currently disabled
> as a wakeup device.  complete dmesg or output from acpidmp
> would tell.
> 
> -Len
> 
dmesg output attached.

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-07-04 23:37 /home/jo/.signature

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.7-mm5 (jo@bear) (gcc version 3.3.4 (Debian)) #20 SMP Thu Jul 1 21:32:37 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003feff000 (ACPI data)
 BIOS-e820: 000000003feff000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7170
On node 0 totalpages: 262016
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32640 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7100
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fefcf28
ACPI: FADT (v001 AMD    TECATE   0x06040000 PTL  0x000f4240) @ 0x3fefef2e
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x3fefefa2
ACPI: DSDT (v001    AMD  AMDACPI 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 root=/dev/sda1 nmi_watchdog=2 aic7xxx=tag_info:{{15,,,,,,,,15}}
CPU 0 irqstacks, hard=c03f3000 soft=c03f1000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1667.062 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034660k/1048064k available (1986k kernel code, 12444k reserved, 834k data, 176k init, 130496k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3293.18 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) MP 2000+ stepping 02
per-CPU timeslice cutoff: 731.01 usecs.
task migration cache decay timeout: 1 msecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
CPU 1 irqstacks, hard=c03f4000 soft=c03f2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3325.95 BogoMIPS
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6619.13 BogoMIPS).
testing NMI watchdog ... OK.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1666.0570 MHz.
..... host bus clock speed is 266.0651 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
CPU1:  online
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7d0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040615
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 11) *9
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 18 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:02:00.0[D] -> GSI 19 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 16 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 17 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 19 (level, low) -> IRQ 177
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   1   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    B9
 11 003 03  1    1    0   1   0    1    1    C1
 12 003 03  1    1    0   1   0    1    1    A9
 13 003 03  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
Using vector-based indexing
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ185 -> 0:16
IRQ193 -> 0:17
IRQ169 -> 0:18
IRQ177 -> 0:19
.................................... done.
vesafb: framebuffer at 0xf0000000, mapped to 0xf8808000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:c7a0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Initializing Cryptographic API
BIOS failed to enable PCI standards compliance, fixing this error.
Console: switching to colour frame buffer device 128x48
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 16 (level, low) -> IRQ 185
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5): 7.812MB/s transfers (7.812MHz, offset 15)
  Vendor: ARCHIVE   Model: Python 28388-XXX  Rev: 5.45
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:8): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5CS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:8:0: Tagged Queuing enabled.  Depth 15
(scsi0:A:9): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DDRS-34560W       Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:9:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 8, lun 0
SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET: Registered protocol family 1
NET: Registered protocol family 15
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 955856k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
Real Time Clock Driver v1.12
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: Printer, hp deskjet 5550
lp0: using parport0 (interrupt-driven).
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
ip_conntrack version 2.1 (8188 buckets, 65504 max) - 304 bytes per conntrack
amd76x_pm: Version 20031109
WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
hw_random: AMD768 system management I/O registers at 0x8000.
hw_random hardware driver 1.0.0 loaded
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 169
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:06.0: 3Com PCI 3c900 Cyclone 10Mbps Combo at 0x2400. Vers LK1.1.19
0000:02:06.0:  Media override to transceiver type 0 (10baseT).
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 19 (level, low) -> IRQ 177
0000:02:08.0: 3Com PCI 3c905C Tornado at 0x2480. Vers LK1.1.19
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
st0: Block limits 1 - 16777215 bytes.
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem dm-4
Starting XFS recovery on filesystem: dm-4 (dev: dm-4)
Ending XFS recovery on filesystem: dm-4 (dev: dm-4)
XFS mounting filesystem dm-10
Ending clean XFS mount for filesystem: dm-10
XFS mounting filesystem dm-7
Starting XFS recovery on filesystem: dm-7 (dev: dm-7)
Ending XFS recovery on filesystem: dm-7 (dev: dm-7)
XFS mounting filesystem dm-8
Starting XFS recovery on filesystem: dm-8 (dev: dm-8)
Ending XFS recovery on filesystem: dm-8 (dev: dm-8)
XFS mounting filesystem dm-6
Starting XFS recovery on filesystem: dm-6 (dev: dm-6)
Ending XFS recovery on filesystem: dm-6 (dev: dm-6)
XFS mounting filesystem dm-5
Starting XFS recovery on filesystem: dm-5 (dev: dm-5)
Ending XFS recovery on filesystem: dm-5 (dev: dm-5)
XFS mounting filesystem dm-9
Starting XFS recovery on filesystem: dm-9 (dev: dm-9)
Ending XFS recovery on filesystem: dm-9 (dev: dm-9)
XFS mounting filesystem dm-1
Starting XFS recovery on filesystem: dm-1 (dev: dm-1)
Ending XFS recovery on filesystem: dm-1 (dev: dm-1)
XFS mounting filesystem dm-11
Starting XFS recovery on filesystem: dm-11 (dev: dm-11)
Ending XFS recovery on filesystem: dm-11 (dev: dm-11)
XFS mounting filesystem dm-2
Starting XFS recovery on filesystem: dm-2 (dev: dm-2)
Ending XFS recovery on filesystem: dm-2 (dev: dm-2)
CAPI Subsystem Rev 1.1.2.8
b1: revision 1.1.2.2
b1dma: revision 1.1.2.3
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 17 (level, low) -> IRQ 193
b1pci: PCI BIOS reports AVM-B1 at i/o 0x2840, irq 193
kcapi: Controller 1: b1pci-2840 attached
b1pci: AVM B1 PCI at i/o 0x2840, irq 193, revision 2
b1pci: revision 1.1.2.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xec000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:02:00.0[D] -> GSI 19 (level, low) -> IRQ 177
ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
ohci_hcd 0000:02:00.0: reset, control = 0x600
ohci_hcd 0000:02:00.0: irq 177, pci mem f8cb5000
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:00.0: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb usb1: Manufacturer: Linux 2.6.7-mm5 ohci_hcd
usb usb1: SerialNumber: 0000:02:00.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
ohci_hcd 0000:02:00.0: created debug files
ohci_hcd 0000:02:00.0: OHCI controller state
ohci_hcd 0000:02:00.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:02:00.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:02:00.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:02:00.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:02:00.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:02:00.0: hcca frame #003f
ohci_hcd 0000:02:00.0: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:02:00.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:02:00.0: roothub.status 00008000 DRWE
ohci_hcd 0000:02:00.0: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:02:00.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:02:00.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:02:00.0: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:02:00.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 1-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ohci_hcd 0000:02:00.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
usb 1-1: new low speed USB device using address 2
usb 1-1: skipped 1 descriptor after interface
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: default language 0x0409
usb 1-1: Product: Cypress Ultra Mouse
usb 1-1: Manufacturer: Cypress Semi.
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 177
usbcore: registered new driver hiddev
usbhid 1-1:1.0: usb_probe_interface
usbhid 1-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Cypress Semi. Cypress Ultra Mouse] on usb-0000:02:00.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver

--qMm9M+Fa2AknHoGS--
