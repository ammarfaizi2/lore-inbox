Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTKXX7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTKXX7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:59:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20743
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261796AbTKXX6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:58:19 -0500
Date: Mon, 24 Nov 2003 15:58:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
Message-ID: <20031124235807.GA1586@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031121121116.61db0160.akpm@osdl.org> <20031124225527.GB1343@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:41:58PM -0500, Zwane Mwaikambo wrote:
> On Mon, 24 Nov 2003, Mike Fedyk wrote:
> 
> > I'm getting an oops on boot, right after serial is initialised.
> >
> > Two things it says:
> > BAD EIP!
> > Trying to kill init!
> >
> > Yes, I'm using preempt.  I'll try without, and see if that "fixes" the
> > problem, and try some other versions, since the last 2.6 booted on this
> > machine is 2.6.0-test6-mm4.
> 
> Any chance you can capture the oops in it's entirety? It might also be
> worth booting with the 'initcall_debug' kernel parameter.

I just compiled witout preempt and it still gives an oops at the same spot.

It doesn't give a trace.  Will it still be helpful for you, and the eip was
something like 00095

Here is a boot from my most recent previous kernel:

Linux version 2.6.0-test6-mm4 (root@srv-lr2600) (gcc version 3.3.2 20030908 (Debian prerelease)) #2 SMP Mon Oct 6 02:32:09 PDT 2003
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
 BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393212
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 163836 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5dc0
ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc000
ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc030
ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc058
ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro vga=extended nmi_watchdog=2 ide=reverse
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2083.203 MHz processor.
Console: colour VGA+ 80x50
Memory: 1552416k/1572848k available (2270k kernel code, 19280k reserved, 884k data, 192k init, 655344k highmem)
Calibrating delay loop... 4104.19 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(TM) XP 2600+ stepping 01
per-CPU timeslice cutoff: 731.36 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2082.0719 MHz.
..... host bus clock speed is 333.0235 MHz.
Starting migration thread for cpu 0
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf15e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9bf0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c20, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:07[A] -> 2-17 -> IRQ 17
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
sage repeated 2 times
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23 Mode:1 Active:1)
00:00:12[A] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
divert: not allocating divert_blk for non-ethernet device lo
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled


It oopses here.


ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x8400-0x8407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DPTA-372730, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SiI680: IDE controller at PCI slot 0000:00:0e.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133 
SiI680: 100%% native mode on irq 17
    ide2: MMIO-DMA at 0xf880a000-0xf880a007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf880a008-0xf880a00f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y160P0, ATA DISK drive
ide2 at 0xf880a080-0xf880a087,0xf880a08a on irq 17
hdg: Maxtor 6Y160P0, ATA DISK drive
ide3 at 0xf880a0c0-0xf880a0c7,0xf880a0ca on irq 17
PDC20269: IDE controller at PCI slot 0000:00:0c.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 19
    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio
hdi: Maxtor 6Y160P0, ATA DISK drive
ide4 at 0xd800-0xd807,0xd402 on irq 19
hdk: Maxtor 6Y160P0, ATA DISK drive
ide5 at 0xd000-0xd007,0xb802 on irq 19
hda: max request size: 128KiB
hda: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hda: hda1 hda2
hde: max request size: 64KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hde: hde1 hde2 hde3
hdg: max request size: 64KiB
hdg: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdg: hdg1 hdg2
hdi: max request size: 1024KiB
hdi: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdi: hdi1 hdi3
hdk: max request size: 1024KiB
hdk: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdk: hdk1 hdk2 hdk3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3148.000 MB/sec
   8regs_prefetch:  2768.000 MB/sec
   32regs    :  1996.000 MB/sec
   32regs_prefetch:  1748.000 MB/sec
   pIII_sse  :  1704.000 MB/sec
   pII_mmx   :  5548.000 MB/sec
   p5_mmx    :  7372.000 MB/sec
raid5: using function: pIII_sse (1704.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
BIOS EDD facility v0.09 2003-Jan-22, 5 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdk3 ...
md:  adding hdk3 ...
md: hdk1 has different UUID to hdk3
md:  adding hdi3 ...
md:  adding hde3 ...
md: hde1 has different UUID to hdk3
md: created md0
md: bind<hde3>
md: bind<hdi3>
md: bind<hdk3>
md: running: <hdk3><hdi3><hde3>
raid5: device hdk3 operational as raid disk 2
raid5: device hdi3 operational as raid disk 1
raid5: device hde3 operational as raid disk 0
raid5: allocated 3148kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 0
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hde3
 disk 1, o:1, dev:hdi3
 disk 2, o:1, dev:hdk3
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hde1 ...
md: created md1
md: bind<hde1>
md: bind<hdk1>
md: running: <hdk1><hde1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
NET: Registered protocol family 1
Adding 364888k swap on /dev/hda2.  Priority:1 extents:1
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12
8139too Fast Ethernet driver 0.9.26
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
divert: allocating divert_blk for eth0
eth0: VIA VT6102 Rhine-II at 0xf7000000, 00:0c:6e:1f:81:95, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
inserting floppy driver for 2.6.0-test6-mm4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
Adding 262136k swap on /usr/swap_file.  Priority:2 extents:68
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 21, pci mem f8875000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:10.0: UHCI Host Controller
uhci-hcd 0000:00:10.0: irq 21, io base 00009400
uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci-hcd 0000:00:10.1: UHCI Host Controller
uhci-hcd 0000:00:10.1: irq 21, io base 00009000
uhci-hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci-hcd 0000:00:10.2: UHCI Host Controller
uhci-hcd 0000:00:10.2: irq 21, io base 00008800
uhci-hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 2-0:1.0: new USB device on port 2, assigned address 2
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
nfs warning: mount version older than kernel
sage repeated 3 times
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
process `named' is using obsolete setsockopt SO_BSDCOMPAT
sage repeated 5 times
input: Logitech USB Mouse on usb-0000:00:10.0-2
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
nfs: server fs not responding, still trying
sage repeated 2 times
nfs: server fs OK
sage repeated 2 times
nfs: server fs not responding, still trying
sage repeated 3 times
nfs: server fs OK
sage repeated 3 times
nfs: server fs not responding, still trying
nfs: server fs not responding, still trying
nfs: server fs OK
nfs: server fs OK
process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
Kernel logging (proc) stopped.
Kernel log daemon terminating.
