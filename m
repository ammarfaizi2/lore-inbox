Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSFNRUR>; Fri, 14 Jun 2002 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSFNRUQ>; Fri, 14 Jun 2002 13:20:16 -0400
Received: from maild.telia.com ([194.22.190.101]:14076 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S311710AbSFNRUO>;
	Fri, 14 Jun 2002 13:20:14 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206140929050.2576-100000@home.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jun 2002 19:20:03 +0200
Message-ID: <m2znxxaibg.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 10 Jun 2002, Peter Osterlund wrote:
> >
> > It doesn't help unfortunately. The network card is not detected at
> > boot and I get the same oops at shutdown as with a vanilla 2.5.21
> > kernel.
> 
> Actually, the card seems to be detected, but:
> 
> 	PCI: Device 01:00.0 not available because of resource collisions
> 
> Can you enable PCI debugging and send a full log of that?

OK, the log is below.

I wonder if this has anything to do with my problem:

        PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask

I've been seeing this for a long time in 2.5, but never bothered to
investigate because before 2.5.21 it didn't seem to cause any harm.
Passing pci=usepirqmask as boot argument to the kernel doesn't make
any difference.



Linux version 2.5.21-packet (petero@p4.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #17 Fri Jun 14 18:50:59 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000004000000 (usable)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=test ro root=304 BOOT_FILE=/vmlinuz console=ttyS0,115200n8
Initializing CPU#0
Detected 233.866 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 62696k/65536k available (1152k kernel code, 2452k reserved, 287k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: BIOS32 Service Directory structure at 0xc00e8050
PCI: BIOS32 Service Directory entry at 0xeaf90
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=02
PCI: PCI BIOS revision 2.10 entry at 0xeafd0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Scanning bus 00
Found 00:00 [8086/7100] 000600 00
PCI: Calling quirk c01d5650 for 00:00.0
Found 00:38 [8086/7110] 000680 00
PCI: Calling quirk c01d5650 for 00:07.0
Found 00:39 [8086/7111] 000101 00
PCI: Calling quirk c01d5650 for 00:07.1
PCI: IDE base address fixup for 00:07.1
Found 00:3a [8086/7112] 000c03 00
PCI: Calling quirk c01d5650 for 00:07.2
PCI: Calling quirk c0273da0 for 00:07.2
Found 00:3b [8086/7113] 000680 00
PCI: Calling quirk c01d5650 for 00:07.3
PCI: Calling quirk c01d5720 for 00:07.3
PCI: Calling quirk c0273be0 for 00:07.3
Found 00:40 [5333/8c01] 000300 00
PCI: Calling quirk c01d5650 for 00:08.0
Found 00:50 [104c/ac17] 000607 02
PCI: Calling quirk c01d5650 for 00:0a.0
Found 00:51 [104c/ac17] 000607 02
PCI: Calling quirk c01d5650 for 00:0a.1
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:0a.0, config 000000, pass 0
Scanning behind PCI bridge 00:0a.1, config 000000, pass 0
Scanning behind PCI bridge 00:0a.0, config 000000, pass 1
Scanning behind PCI bridge 00:0a.1, config 000000, pass 1
Bus scan for 00 returning with max=08
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fe840
00:07 slot=00 0:00/1eb8 1:00/1eb8 2:00/1eb8 3:63/0400
00:0a slot=00 0:60/0400 1:61/0400 2:00/0400 3:00/0400
00:0c slot=00 0:60/1eb8 1:00/1eb8 2:00/1eb8 3:00/1eb8
PCI: Attempting to find IRQ router for 8086:122e
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
00:0a.1: ignoring bogus IRQ 255
IRQ for 00:0a.0:0 -> PIRQ 60, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
IRQ for 00:0a.1:1 -> PIRQ 61, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
PCI: Allocating resources
PCI: Resource 00001100-0000110f (f=101, d=0, p=0)
PCI: Resource 0000f300-0000f31f (f=101, d=0, p=0)
PCI: Resource c0000000-c3ffffff (f=200, d=0, p=0)
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1220
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1220 (#2)
PCI: Sorting device list...
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
PCI: Calling quirk c0273950 for 00:00.0
Limiting direct PCI/PCI transfers.
PCI: Calling quirk c0273e10 for 00:00.0
PCI: Calling quirk c0273e10 for 00:07.0
PCI: Calling quirk c0273e10 for 00:07.1
PCI: Calling quirk c0273e10 for 00:07.2
PCI: Calling quirk c0273e10 for 00:07.3
PCI: Calling quirk c0273e10 for 00:08.0
PCI: Calling quirk c0273e10 for 00:0a.0
PCI: Calling quirk c0273e10 for 00:0a.1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 224 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: unknown interface: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
hda: TOSHIBA MK4006MAV, DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 8007552 sectors, CHS=7944/16/63
 hda: [PTBL] [993/128/63] hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for ATAPI devices
scsi: device set offline - command error recover failed: host 0 channel 0 id 0 lun 0
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:0a.0:0 -> PIRQ 60, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 -> edge ... OK
PCI: Assigned IRQ 10 for device 00:0a.0
IRQ for 00:0a.1:1 -> PIRQ 61, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:0a.1
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.0 (512 buckets, 4096 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000068
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
Scanning bus 01
Found 01:00 [13d1/ab02] 000200 00
PCI: Calling quirk c01d5650 for 01:00.0
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
PCI: Device 01:00.0 not available because of resource collisions
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
INIT: version 2.78 booting
			Welcome to Red Hat Linux

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
