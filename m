Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUDCAXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDCAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:23:44 -0500
Received: from A8bb4.a.pppool.de ([213.6.139.180]:38531 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S261419AbUDCAXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:23:31 -0500
Message-ID: <406E03F0.8040603@A8bb4.a.pppool.de>
Date: Sat, 03 Apr 2004 02:23:12 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>	<20040328200710.66a4ae1a.akpm@osdl.org>	<4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>	<1080570227.20685.93.camel@watt.suse.com>	<406D21F6.8080005@A88c0.a.pppool.de>	<20040402022348.00d55268.akpm@osdl.org>	<406DD2E2.7030602@A88be.a.pppool.de> <20040402131309.238729bb.akpm@osdl.org>
In-Reply-To: <20040402131309.238729bb.akpm@osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andreas Hartmann <andihartmann@freenet.de> wrote:
>>
>> > What device drivers are running at the time?  disk/network/usb/etc?
[..]
> No.  I mean which drivers were actually doing significant amounts of work
> during the test?
> 
> (you appear to not have any disks)

Surely do I have disks - I forgot them :-). I've got two IDE-HD's, 
/dev/hda and /dev/hdb. /dev/hdb is switched off during boot with hdparm. 
On /dev/hda, the whole work is done.
There is a cdrom and a cd-writer on /dev/hdd and /dev/hdc. They have been 
not used during the tests.

I think it is best, if I post the whole boot-entries from messages:


Apr  2 08:14:56 athlon kernel: PI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 
5 6 7 10 *11 12 14 15)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 
5 6 7 *10 11 12 14 15)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 
*5 6 7 10 11 12 14 15)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 
5 6 7 10 *11 12 14 15)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22)
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23)
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 
0xa9 -> IRQ 16 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:08[A] -> 2-16 -> IRQ 16
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 
0xb1 -> IRQ 17 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:08[B] -> 2-17 -> IRQ 17
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 
0xb9 -> IRQ 18 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:08[C] -> 2-18 -> IRQ 18
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 
0xc1 -> IRQ 19 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:08[D] -> 2-19 -> IRQ 19
Apr  2 08:14:56 athlon kernel: _CRS returns NULL! Using IRQ 21 fordevice 
(PCI Interrupt Link [ALKB]).
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKB] enabled at 
IRQ 21
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 
0xc9 -> IRQ 21 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:10[A] -> 2-21 -> IRQ 21
Apr  2 08:14:56 athlon kernel: _CRS returns NULL! Using IRQ 20 fordevice 
(PCI Interrupt Link [ALKA]).
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKA] enabled at 
IRQ 20
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 
0xd1 -> IRQ 20 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:11[A] -> 2-20 -> IRQ 20
Apr  2 08:14:56 athlon kernel: _CRS returns NULL! Using IRQ 22 fordevice 
(PCI Interrupt Link [ALKC]).
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKC] enabled at 
IRQ 22
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 
0xd9 -> IRQ 22 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:11[C] -> 2-22 -> IRQ 22
Apr  2 08:14:56 athlon kernel: _CRS returns NULL! Using IRQ 23 fordevice 
(PCI Interrupt Link [ALKD]).
Apr  2 08:14:56 athlon kernel: ACPI: PCI Interrupt Link [ALKD] enabled at 
IRQ 23
Apr  2 08:14:56 athlon kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 
0xe1 -> IRQ 23 Mode:1 Active:1)
Apr  2 08:14:56 athlon kernel: 00:00:11[D] -> 2-23 -> IRQ 23
Apr  2 08:14:56 athlon kernel: number of MP IRQ sources: 15.
Apr  2 08:14:56 athlon kernel: number of IO-APIC #2 registers: 24.
Apr  2 08:14:56 athlon kernel: testing the IO APIC.......................
Apr  2 08:14:56 athlon kernel: IO APIC #2......
Apr  2 08:14:56 athlon kernel: .... register #00: 02000000
Apr  2 08:14:56 athlon kernel: .......    : physical APIC id: 02
Apr  2 08:14:56 athlon kernel: .......    : Delivery Type: 0
Apr  2 08:14:56 athlon kernel: .......    : LTS          : 0
Apr  2 08:14:56 athlon kernel: .... register #01: 00178003
Apr  2 08:14:56 athlon kernel: .......     : max redirection entries: 0017
Apr  2 08:14:56 athlon kernel: .......     : PRQ implemented: 1
Apr  2 08:14:56 athlon kernel: .......     : IO APIC version: 0003
Apr  2 08:14:56 athlon kernel: .... IRQ redirection table:
Apr  2 08:14:56 athlon kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest 
Deli Vect:
Apr  2 08:14:56 athlon kernel:  00 000 00  1    0    0   0   0    0    0    00
Apr  2 08:14:56 athlon kernel:  01 001 01  0    0    0   0   0    1    1    39
Apr  2 08:14:56 athlon kernel:  02 001 01  0    0    0   0   0    1    1    31
Apr  2 08:14:56 athlon kernel:  03 001 01  0    0    0   0   0    1    1    41
Apr  2 08:14:56 athlon kernel:  04 001 01  0    0    0   0   0    1    1    49
Apr  2 08:14:56 athlon kernel:  05 001 01  0    0    0   0   0    1    1    51
Apr  2 08:14:56 athlon kernel:  06 001 01  0    0    0   0   0    1    1    59
Apr  2 08:14:56 athlon kernel:  07 001 01  0    0    0   0   0    1    1    61
Apr  2 08:14:56 athlon kernel:  08 001 01  0    0    0   0   0    1    1    69
Apr  2 08:14:56 athlon kernel:  09 001 01  0    1    0   1   0    1    1    71
Apr  2 08:14:56 athlon kernel:  0a 001 01  0    0    0   0   0    1    1    79
Apr  2 08:14:56 athlon kernel:  0b 001 01  0    0    0   0   0    1    1    81
Apr  2 08:14:56 athlon kernel:  0c 001 01  0    0    0   0   0    1    1    89
Apr  2 08:14:56 athlon kernel:  0d 001 01  0    0    0   0   0    1    1    91
Apr  2 08:14:56 athlon kernel:  0e 001 01  0    0    0   0   0    1    1    99
Apr  2 08:14:56 athlon kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Apr  2 08:14:56 athlon kernel:  10 001 01  1    1    0   1   0    1    1    A9
Apr  2 08:14:56 athlon kernel:  11 001 01  1    1    0   1   0    1    1    B1
Apr  2 08:14:56 athlon kernel:  12 001 01  1    1    0   1   0    1    1    B9
Apr  2 08:14:56 athlon kernel:  13 001 01  1    1    0   1   0    1    1    C1
Apr  2 08:14:56 athlon kernel:  14 001 01  1    1    0   1   0    1    1    D1
Apr  2 08:14:56 athlon kernel:  15 001 01  1    1    0   1   0    1    1    C9
Apr  2 08:14:56 athlon kernel:  16 001 01  1    1    0   1   0    1    1    D9
Apr  2 08:14:56 athlon kernel:  17 001 01  1    1    0   1   0    1    1    E1
Apr  2 08:14:56 athlon kernel: IRQ to pin mappings:
Apr  2 08:14:56 athlon kernel: IRQ0 -> 0:2
Apr  2 08:14:56 athlon kernel: IRQ1 -> 0:1
Apr  2 08:14:56 athlon kernel: IRQ3 -> 0:3
Apr  2 08:14:56 athlon kernel: IRQ4 -> 0:4
Apr  2 08:14:56 athlon kernel: IRQ5 -> 0:5
Apr  2 08:14:56 athlon kernel: IRQ6 -> 0:6
Apr  2 08:14:56 athlon kernel: IRQ7 -> 0:7
Apr  2 08:14:56 athlon kernel: IRQ8 -> 0:8
Apr  2 08:14:56 athlon kernel: IRQ9 -> 0:9
Apr  2 08:14:56 athlon kernel: IRQ10 -> 0:10
Apr  2 08:14:56 athlon kernel: IRQ11 -> 0:11
Apr  2 08:14:56 athlon kernel: IRQ12 -> 0:12
Apr  2 08:14:56 athlon kernel: IRQ13 -> 0:13
Apr  2 08:14:56 athlon kernel: IRQ14 -> 0:14
Apr  2 08:14:56 athlon kernel: IRQ15 -> 0:15
Apr  2 08:14:56 athlon kernel: IRQ16 -> 0:16
Apr  2 08:14:56 athlon kernel: IRQ17 -> 0:17
Apr  2 08:14:56 athlon kernel: IRQ18 -> 0:18
Apr  2 08:14:56 athlon kernel: IRQ19 -> 0:19
Apr  2 08:14:56 athlon kernel: IRQ20 -> 0:20
Apr  2 08:14:56 athlon kernel: IRQ21 -> 0:21
Apr  2 08:14:56 athlon kernel: IRQ22 -> 0:22
Apr  2 08:14:56 athlon kernel: IRQ23 -> 0:23
Apr  2 08:14:56 athlon kernel: .................................... done.
Apr  2 08:14:56 athlon kernel: PCI: Using ACPI for IRQ routing
Apr  2 08:14:56 athlon kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Apr  2 08:14:56 athlon kernel: Initializing Cryptographic API
Apr  2 08:14:56 athlon kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 
11 to 5
Apr  2 08:14:56 athlon kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 
10 to 5
Apr  2 08:14:56 athlon kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Apr  2 08:14:56 athlon kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Apr  2 08:14:56 athlon kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Apr  2 08:14:56 athlon kernel: VP_IDE: chipset revision 6
Apr  2 08:14:56 athlon kernel: VP_IDE: not 100% native mode: will probe 
irqs later
Apr  2 08:14:56 athlon kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 
controller on pci0000:00:11.1
Apr  2 08:14:56 athlon kernel:     ide0: BM-DMA at 0xe400-0xe407, BIOS 
settings: hda:DMA, hdb:DMA
Apr  2 08:14:56 athlon kernel:     ide1: BM-DMA at 0xe408-0xe40f, BIOS 
settings: hdc:DMA, hdd:DMA
Apr  2 08:14:56 athlon kernel: hda: WDC WD205AA, ATA DISK drive
Apr  2 08:14:56 athlon kernel: hdb: WDC WD450AA-00BAA0, ATA DISK drive
Apr  2 08:14:56 athlon kernel: Using anticipatory io scheduler
Apr  2 08:14:56 athlon kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr  2 08:14:56 athlon kernel: hdc: PLEXTOR CD-R PX-W1610A, ATAPI 
CD/DVD-ROM drive
Apr  2 08:14:56 athlon kernel: hdd: ATAPI CDROM 48X, ATAPI CD/DVD-ROM drive
Apr  2 08:14:56 athlon kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr  2 08:14:56 athlon kernel: hda: max request size: 128KiB
Apr  2 08:14:56 athlon kernel: hda: 40079088 sectors (20520 MB) w/2048KiB 
Cache, CHS=39761/16/63, UDMA(66)
Apr  2 08:14:56 athlon kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 
hda8 hda9 hda10 >
Apr  2 08:14:56 athlon kernel: hdb: max request size: 128KiB
Apr  2 08:14:56 athlon kernel: hdb: 87930864 sectors (45020 MB) w/2048KiB 
Cache, CHS=65535/16/63, UDMA(66)
Apr  2 08:14:56 athlon kernel:  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 
hdb10 hdb11 hdb12 hdb13 hdb14 hdb15 >
Apr  2 08:14:56 athlon kernel: ieee1394: raw1394: /dev/raw1394 device 
initialized
Apr  2 08:14:56 athlon kernel: mice: PS/2 mouse device common for all mice
Apr  2 08:14:56 athlon kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr  2 08:14:56 athlon kernel: input: PS/2 Logitech Mouse on isa0060/serio1
Apr  2 08:14:56 athlon kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr  2 08:14:56 athlon kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Apr  2 08:14:56 athlon kernel: NET: Registered protocol family 2
Apr  2 08:14:56 athlon kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Apr  2 08:14:56 athlon kernel: TCP: Hash tables configured (established 
32768 bind 65536)
Apr  2 08:14:56 athlon kernel: ip_conntrack version 2.1 (4095 buckets, 
32760 max) - 296 bytes per conntrack
Apr  2 08:14:56 athlon kernel: ip_tables: (C) 2000-2002 Netfilter core team
Apr  2 08:14:56 athlon kernel: ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Apr  2 08:14:56 athlon kernel: arp_tables: (C) 2002 David S. Miller
Apr  2 08:14:56 athlon kernel: ACPI: (supports S0 S1 S4 S5)
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.5" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device hda1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (hda1) 
for (hda1)
Apr  2 08:14:56 athlon kernel: Using tea hash to sort names
Apr  2 08:14:56 athlon kernel: VFS: Mounted root (reiserfs filesystem).
Apr  2 08:14:56 athlon kernel: Freeing unused kernel memory: 144k freed
Apr  2 08:14:56 athlon kernel: NET: Registered protocol family 1
Apr  2 08:14:56 athlon kernel: Adding 514040k swap on /dev/hda9. 
Priority:-1 extents:1
Apr  2 08:14:56 athlon kernel: device-mapper: 4.1.0-ioctl (2003-12-10) 
initialised: dm@uk.sistina.com
Apr  2 08:14:56 athlon kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB 
Cache, DMA
Apr  2 08:14:56 athlon kernel: Uniform CD-ROM driver Revision: 3.20
Apr  2 08:14:56 athlon kernel: hdd: ATAPI CD-ROM drive, 128kB Cache, UDMA(33)
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device hda8, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (hda8) 
for (hda8)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device dm-13, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (dm-13) 
for (dm-13)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device hda7, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (hda7) 
for (hda7)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device dm-8, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (dm-8) 
for (dm-8)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device dm-11, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (dm-11) 
for (dm-11)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device dm-10, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (dm-10) 
for (dm-10)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device dm-9, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (dm-9) 
for (dm-9)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: found reiserfs format "3.6" with standard 
journal
Apr  2 08:14:56 athlon kernel: reiserfs: using ordered data mode
Apr  2 08:14:56 athlon kernel: Reiserfs journal params: device hda5, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Apr  2 08:14:56 athlon kernel: reiserfs: checking transaction log (hda5) 
for (hda5)
Apr  2 08:14:56 athlon kernel: Using r5 hash to sort names
Apr  2 08:14:56 athlon kernel: blk: queue dfd55c00, I/O limit 4095Mb (mask 
0xffffffff)
Apr  2 08:14:56 athlon kernel: blk: queue dfd55800, I/O limit 4095Mb (mask 
0xffffffff)
Apr  2 08:14:56 athlon kernel: parport0: PC-style at 0x378 (0x778), irq 7 
[PCSPP(,...)]
Apr  2 08:14:56 athlon kernel: lp0: using parport0 (interrupt-driven).
Apr  2 08:14:56 athlon kernel: usbcore: registered new driver usbfs
Apr  2 08:14:56 athlon kernel: usbcore: registered new driver hub
Apr  2 08:14:56 athlon kernel: USB Universal Host Controller Interface 
driver v2.2
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.0: VIA Technologies, 
Inc. USB
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.0: irq 21, io base 0000d800
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.0: new USB bus 
registered, assigned bus number 1
Apr  2 08:14:56 athlon kernel: hub 1-0:1.0: USB hub found
Apr  2 08:14:56 athlon kernel: hub 1-0:1.0: 2 ports detected
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.1: VIA Technologies, 
Inc. USB (#2)
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.1: irq 21, io base 0000dc00
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.1: new USB bus 
registered, assigned bus number 2
Apr  2 08:14:56 athlon kernel: hub 2-0:1.0: USB hub found
Apr  2 08:14:56 athlon kernel: hub 2-0:1.0: 2 ports detected
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.2: VIA Technologies, 
Inc. USB (#3)
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.2: irq 21, io base 0000e000
Apr  2 08:14:56 athlon kernel: uhci_hcd 0000:00:10.2: new USB bus 
registered, assigned bus number 3
Apr  2 08:14:56 athlon kernel: hub 3-0:1.0: USB hub found
Apr  2 08:14:56 athlon kernel: hub 3-0:1.0: 2 ports detected
Apr  2 08:14:56 athlon kernel: SCSI subsystem initialized
Apr  2 08:14:56 athlon kernel: Initializing USB Mass Storage driver...
Apr  2 08:14:56 athlon kernel: usbcore: registered new driver usb-storage
Apr  2 08:14:56 athlon kernel: USB Mass Storage support registered.
Apr  2 08:14:56 athlon kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 
8 ports, IRQ sharing disabled
Apr  2 08:14:56 athlon kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr  2 08:14:56 athlon kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr  2 08:14:56 athlon kernel: sis900.c: v1.08.07 11/02/2003
Apr  2 08:14:56 athlon kernel: eth0: SiS 900 Internal MII PHY transceiver 
found at address 1.
Apr  2 08:14:56 athlon kernel: eth0: Using transceiver found at address 1 
as default
Apr  2 08:14:56 athlon kernel: eth0: SiS 900 PCI Fast Ethernet at 0xd000, 
IRQ 17, 00:40:33:e2:43:71.
Apr  2 08:14:56 athlon kernel: eth0: Media Link Off
Apr  2 08:14:56 athlon kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Apr  2 08:14:56 athlon kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Apr  2 08:14:56 athlon kernel: eth1: 0000:00:0c.0, 00:02:B3:8F:F9:11, IRQ 18.
Apr  2 08:14:56 athlon kernel:   Board assembly 751767-004, Physical 
connectors present: RJ45
Apr  2 08:14:56 athlon kernel:   Primary interface chip i82555 PHY #1.
Apr  2 08:14:56 athlon kernel:     Secondary interface chip i82555.
Apr  2 08:14:56 athlon kernel:   General self-test: passed.
Apr  2 08:14:56 athlon kernel:   Serial sub-system self-test: passed.
Apr  2 08:14:56 athlon kernel:   Internal registers self-test: passed.
Apr  2 08:14:56 athlon kernel:   ROM checksum self-test: passed (0x3258698e).


Regards,
Andreas Hartmann
