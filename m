Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVFSAV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVFSAV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 20:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVFSAV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 20:21:58 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:14530 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262210AbVFSAVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 20:21:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@muc.de>
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sun, 19 Jun 2005 01:21:13 +0100
User-Agent: KMail/1.8.1
References: <200506181452.52921.s0348365@sms.ed.ac.uk> <20050618190921.GA59126@muc.de>
In-Reply-To: <20050618190921.GA59126@muc.de>
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5pLtCLhvwZZ7PeB"
Message-Id: <200506190121.13253.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5pLtCLhvwZZ7PeB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andi,

On Saturday 18 Jun 2005 20:09, you wrote:
> On Sat, Jun 18, 2005 at 02:52:52PM +0100, Alistair John Strachan wrote:
> > Hi,
> >
> > I upgraded my nForce3 x86-64 desktop from 2.6.12-rc5 to 2.6.12 today and
> > something strange started happening. Waay back in 2.6.x I had problems
> > with the "noapic" default for nForce boards on x86-64, and so used the
> > "apic" kernel boot parameter to force the apic on; this worked
> > successfully for a long time with no timer problems.
>
> apic hasn't been needed for several kernel releases now, since the
> timer override problem on the Nforce has been workarounded.

Well, I used it back in 2.6.9 because my device drivers didn't work. It was 
left on mostly by accident, but it does reduce IRQ sharing. I imagine the 
difference on a desktop system is cosmetic..

[snip]
>
> Are you sure the problem is new?
>
> Can you post the full output of a failing case with apic=verbose?

Yes, the problem is definitely new insofar as I can boot my system and 2/3 
times it will not boot, and when it does boot it works perfectly. This did 
not happen on 2.6.9, 2.6.10, 2.6.11 or 2.6.12-rc5, which have all worked 
flawlessly on this machine.

Here's a copy of my dmesg from a boot with apic=verbose. I see warnings about 
a buggy NMI and a broken timer pin, but I think I've always had those 
problems. (BTW, I've switched mailer recently and I haven't figured out how 
to do inline attachments, I apologise for the encoded one.)

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

--Boundary-00=_5pLtCLhvwZZ7PeB
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Bootdata ok (command line is root=/dev/sda1 apic=verbose md=0,/dev/sda2,/dev/sdb2 md=1,/dev/sda3,/dev/sdb3 md=2,/dev/hde1,/dev/hdg1)
Linux version 2.6.12 (root@damocles) (gcc version 3.4.4) #2 Sun Jun 19 01:09:05 BST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
 BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f71e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff7a00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258032 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 apic=verbose md=0,/dev/sda2,/dev/sdb2 md=1,/dev/sda3,/dev/sdb3 md=2,/dev/hde1,/dev/hdg1
md: Will configure md0 (super-block) from /dev/sda2,/dev/sdb2, below.
md: Will configure md1 (super-block) from /dev/sda3,/dev/sdb3, below.
md: Will configure md2 (super-block) from /dev/hde1,/dev/hdg1, below.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2009.826 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1026956k/1048512k available (2177k kernel code, 20848k reserved, 666k data, 152k init)
Calibrating delay loop... 3973.12 BogoMIPS (lpj=1986560)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
enabled ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 3d.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
 failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
testing NMI watchdog ... CPU#0: NMI appears to be stuck (11->11)!
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
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
.................................... done.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
SGI XFS with large block/inode numbers, no debug enabled
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-2510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
PDC20270: IDE controller at PCI slot 0000:02:09.0
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xa9 -> IRQ 19 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 169
PDC20270: chipset revision 2
PDC20270: 100% native mode on irq 169
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y120P0, ATA DISK drive
ide2 at 0x9800-0x9807,0x9c02 on irq 169
Probing IDE interface ide3...
hdg: Maxtor 6Y120P0, ATA DISK drive
ide3 at 0xa000-0xa007,0xa402 on irq 169
hde: max request size: 128KiB
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes supported
 hde: hde1
hdg: max request size: 128KiB
hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb1 -> IRQ 23 Mode:1 Active:0)
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE400 irq 177
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE408 irq 177
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 185
Yenta: CardBus bridge found at 0000:02:0a.0 [0000:0000]
Yenta: ISA IRQ mask 0x0000, PCI irq 185
Socket status: 30000820
mice: PS/2 mouse device common for all mice
input: PC Speaker
md: raid0 personality registered as nr 2
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Loading md0: /dev/sda2
md: bind<sda2>
input: AT Translated Set 2 keyboard on isa0060/serio0
md: bind<sdb2>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb2
raid0:   comparing sdb2(20008832) with sdb2(20008832)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(20008832) with sdb2(20008832)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 40017664 blocks.
raid0 : conf->hash_spacing is 40017664 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: Loading md1: /dev/sda3
md: bind<sda3>
md: bind<sdb3>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb3
raid0:   comparing sdb3(169124160) with sdb3(169124160)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda3
raid0:   comparing sda3(169124160) with sdb3(169124160)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 338248320 blocks.
raid0 : conf->hash_spacing is 338248320 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: Loading md2: /dev/hde1
md: bind<hde1>
md: bind<hdg1>
md2: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdg1
raid0:   comparing hdg1(120060736) with hdg1(120060736)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(120060736) with hdg1(120060736)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 240121472 blocks.
raid0 : conf->hash_spacing is 240121472 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 152k freed
Loaded prism54 driver, version 1.2
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 185
lirc_dev: IR Remote Control driver registered, at major 61 
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 193
bttv0: Bt878 (rev 17) at 0000:02:08.0, irq: 193, latency: 32, mmio: 0xdd000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom: Hauppauge: model = 61344, rev = D421, serial# = 3883524
tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
tveeprom: audio_processor = MSP3415 (type = 6)
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3415D-B3 +nicam +simple mode=simple
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 1-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 1-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
lirc_i2c: chip found @ 0x18 (Hauppauge IR)
lirc_dev: lirc_register_plugin: sample_rate: 10
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 185
Installing spdif_bug patch: Audigy 2 Platinum [SB0240P]
XFS mounting filesystem md0
Ending clean XFS mount for filesystem: md0
XFS mounting filesystem md1
Ending clean XFS mount for filesystem: md1
XFS mounting filesystem md2
Ending clean XFS mount for filesystem: md2
Adding 524280k swap on /var/cache/swapfile.  Priority:1 extents:2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xd0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xc9 -> IRQ 22 Mode:1 Active:0)
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 201, io mem 0xde001000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:0)
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 209
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 209, io mem 0xde002000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd9 -> IRQ 20 Mode:1 Active:0)
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 217, io mem 0xde003000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0300 bound to 0000:00:05.0
usb 2-1: new low speed USB device using ohci_hcd and address 3
usb 2-2: new low speed USB device using ohci_hcd and address 4
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xe1 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 225
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7664  Wed May 25 22:14:12 PDT 2005
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:07.2[B] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 193
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[dc01a000-dc01a7ff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:02:0c.0, from 10 to 9
ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[169]  MMIO=[dc019000-dc0197ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091023fd7]
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0010dc00006dd781]
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:02.1-1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:02.1-1
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
wlan: resetting device...
wlan: uploading firmware...
wlan: firmware version: 1.0.4.3
wlan: firmware upload complete
wlan: interface reset complete
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode

--Boundary-00=_5pLtCLhvwZZ7PeB--
