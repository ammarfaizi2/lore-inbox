Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUGFRQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUGFRQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 13:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUGFRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 13:16:14 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:36480
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S264228AbUGFRPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 13:15:51 -0400
Date: Tue, 6 Jul 2004 10:15:47 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040706171547.GB1453@tumblerings.org>
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com> <1089054464.15675.56.camel@dhcppc4> <20040706164839.GA1094@tumblerings.org> <1089133780.15675.468.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089133780.15675.468.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 01:09:40PM -0400, Len Brown wrote:
> On Tue, 2004-07-06 at 12:48, Zack Brown wrote:
> > Hi Len,
> > 
> > On Mon, Jul 05, 2004 at 03:07:44PM -0400, Len Brown wrote:
> > > On Sat, 2004-07-03 at 22:05, Zack Brown wrote:
> > > > Hi folks,
> > > > 
> > > > When booting vanilla 2.4.26 with SMP enabled, I get a lockup before the
> > > > boot sequence is completed. The same kernel with SMP disabled boots and runs
> > > > just fine. Both CPUs are detected by the system at bootup, before lilo takes
> > > > over. Here's the error as I wrote it down from the screen, followed by the
> > > > .config file:
> > > e 
> > > > ------------------------------ cut here
> > > > Using local APIC timer interrupts.
> > > > Calibrating APIC timer...
> > > > ..... CPU clock speed is 1004.4785 MHZ
> > > > ..... hostbus clock speed is 133.9304 MHz
> > > > cpu: 0, clocks: 1339304, slice: 446434
> > > > CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> > > > cpu: 1, clocks: 1339304, slice: 446434
> > > > CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> > > > ------------------------------ cut here
> > > 
> > > complete dmesg from success case would help,
> > > but try booting with "acpi=off", as that will
> > > disable ACPI for CPU enumeration, and if there
> > > is a bug in your ACPI tables, it would avoid it.
> > 
> > I tried acpi=off, and got a hang at boot right after the line:
> > 
> > CPU0<T0:1339376,T1:892912,D:4,S:446460,C:1339380
> 
> sounds like there is no SMP success case on this box with any OS?

No, I have 2.6.6 working pretty well now. I thought you just wanted a
2.4 success case. My dmesg output from 2.6.6 is appended.

> Maybe a hardware problem.  See if you
> can simplify the hardware by ripping stuff out
> until it works.  Alternatively, if you find a
> different OS or version of linux that boots SMP,
> then that suggests a Linux specific issue.

It may be a Linux-specific issue then.

Be well,
Zack

------------------------------ cut here ------------------------------
Linux version 2.6.6 (root@tumblerings.org) (gcc version 3.3.4 (Debian)) #1 SMP Mon Jul 5 10:51:47 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f54c0
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6800
ACPI: RSDT (v001 ASUS   CUV4XDLS 0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CUV4XDLS 0x30303031 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CUV4XDLS 0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CUV4XDLS 0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CUV4XDLS 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.6 ro root=301
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1004.475 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513052k/524272k available (4446k kernel code, 10428k reserved, 1301k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1978.36 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.07 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2002.94 BogoMIPS
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3981.31 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1004.0303 MHz.
..... host bus clock speed is 133.0907 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d00, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
00:00:04[A] -> 2-11 -> IRQ 11 level low
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
00:00:04[B] -> 2-10 -> IRQ 10 level low
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
00:00:0c[A] -> 2-16 -> IRQ 16 level low
00:00:0c[B] -> 2-17 -> IRQ 17 level low
00:00:0c[C] -> 2-18 -> IRQ 18 level low
00:00:0c[D] -> 2-19 -> IRQ 19 level low
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
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
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Simple Boot Flag at 0x3a set to 0x80
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
QNX4 filesystem 0.2.3 registered.
udf: registering filesystem
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:04.2, from 5 to 10
PCI: Via IRQ fixup for 0000:00:04.3, from 5 to 10
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1, 16 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:09.0 (0004 -> 0007)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0x9800, 00:A0:CC:5F:A3:A3, IRQ 19.
PCI: Enabling device 0000:00:0d.0 (0004 -> 0007)
tulip1:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0x8800, 00:A0:CC:5F:A1:86, IRQ 19.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 36147H8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/512KiB Cache, CHS=65535/16/63
 hda: hda1 hda2 hda3 hda4
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 7)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0J
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym0: <1010-33> rev 0x1 at pci 0000:00:08.0 irq 19
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi1 : sym-2.1.18j
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(1:0:0:0): Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
scsi(1:0:0:0): Ending Domain Validation
sym1: <1010-33> rev 0x1 at pci 0000:00:08.1 irq 16
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi2 : sym-2.1.18j
libata version 1.02 loaded.
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
ieee1394: raw1394: /dev/raw1394 device initialized
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:04.2: irq 10, io base 0000b400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:04.3: irq 10, io base 0000b000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 228k freed
usb 1-2: new full speed USB device using address 2
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 307192k swap on /swapfile.  Priority:-1 extents:78
Disabled Privacy Extensions on device c0633d00(lo)
eth0: Setting half-duplex based on MII#1 link partner capability of 40a1.
eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth0: no IPv6 routers present
eth1: no IPv6 routers present
------------------------------ cut here ------------------------------

> 
> cheers,
> -Len
> 
> 

-- 
Zack Brown
