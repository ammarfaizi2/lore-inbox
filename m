Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992612AbWJTSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992612AbWJTSaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992530AbWJTSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:30:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51665 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030334AbWJTSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:30:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=klJL+KIqH2YbZeXpeMOhXkDPXzgnKEDJgB1gFqTOpLc+vGZ1oceJs18I5B0g8F59Koj7YJgyAMnJCOy4KjNkF9NexzghHdM2T8VCjEKYnjsTbxQ7vyrdmoUVyHj9r4xD+EVTKXwy4ZbMsexwktZ5YMwpzNUo99qqS4hOAbyw/Q8=
Message-ID: <3b0ffc1f0610201130i8f15e49oec2cdc68abb8dbd@mail.gmail.com>
Date: Fri, 20 Oct 2006 14:30:08 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Jeff Garzik" <jeff@garzik.org>
Subject: Re: Linux 2.6.19-rc2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Ok, it's a week since -rc1, so -rc2 is out there.

A bit behind, but booting still takes ages on my laptop as
libata/ata_piix tries to probe a device that isn't there (I reported
this previously against -rc1, but got no response):

Linux version 2.6.19-rc2 (root@farstrider) (gcc version 4.1.2 20061007
(prerelease) (Debian 4.1.1-16)) #1 PREEMPT Tue Oct 17 11:40:02 EDT
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6f0000 (usable)
 BIOS-e820: 000000003f6f0000 - 000000003f6fb000 (ACPI data)
 BIOS-e820: 000000003f6fb000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1014MB LOWMEM available.
Entering add_active_range(0, 0, 259824) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   259824
early_node_map[1] active PFN ranges
    0:        0 ->   259824
On node 0 totalpages: 259824
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1997 pages used for memmap
  Normal zone: 253731 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 FUJ                                   ) @ 0x000f5d80
ACPI: RSDT (v001 FUJ    FJNB189  0x01070000 FUJ  0x00000100) @ 0x3f6f4c92
ACPI: FADT (v001 FUJ    FJNB189  0x01070000 FUJ  0x00000100) @ 0x3f6faf8c
ACPI: SSDT (v001 FUJ    FJNB189  0x01070000 INTL 0x20030522) @ 0x3f6fab42
ACPI: BOOT (v001 FUJ    FJNB189  0x01070000 FUJ  0x00000100) @ 0x3f6faf64
ACPI: DSDT (v001 FUJ    FJNB189  0x01070000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xfc08
Allocating PCI resources starting at 50000000 (gap: 40000000:bec10000)
Detected 1100.104 MHz processor.
Built 1 zonelists.  Total pages: 257795
Kernel command line: root=/dev/sda3 ro acpi_sleep=s3_bios
resume2=file:/dev/sda3:0x1f2df40
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=b0348000 soft=b0347000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1027448k/1039296k available (1660k kernel code, 11372k
reserved, 525k data, 120k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
    vmalloc : 0xf0000000 - 0xffff6000   ( 255 MB)
    lowmem  : 0xb0000000 - 0xef6f0000   (1014 MB)
      .init : 0xb0324000 - 0xb0342000   ( 120 kB)
      .data : 0xb029f263 - 0xb0322a2c   ( 525 kB)
      .text : 0xb0100000 - 0xb029f263   (1660 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2200.79 BogoMIPS (lpj=1100399)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040
00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1100MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0800)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd982, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region fc00-fc7f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fc80-fcbf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #01 (-#03)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 2, cardbus bridge: 0000:01:0a.0
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 56000000-57ffffff
PCI: Bus 3, cardbus bridge: 0000:01:0a.1
  IO window: 00003c00-00003cff
  IO window: 00001000-000010ff
  PREFETCH window: 52000000-53ffffff
  MEM window: 58000000-59ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: d0200000-d02fffff
  PREFETCH window: 50000000-53ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:0a.1[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x7f set to 0x1
SGI XFS with no debug enabled
io scheduler noop registered
io scheduler cfq registered (default)
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xd8000000
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHT2080A 0022 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA755 DVD/CDRW 1.00 PQ: 0 ANSI: 5

As is actually detected, there's a hard drive on the first channel and
a DVD-ROM/CDRW on the second channel.

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated
Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
01:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
01:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
01:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 03)
01:0a.3 System peripheral: Ricoh Co Ltd R5C576 SD Bus Host Adapter (rev 01)
01:0a.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter
01:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:0d.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
