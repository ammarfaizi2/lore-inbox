Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312935AbSDEPBw>; Fri, 5 Apr 2002 10:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312937AbSDEPBm>; Fri, 5 Apr 2002 10:01:42 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:2318 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S312935AbSDEPBd>;
	Fri, 5 Apr 2002 10:01:33 -0500
Date: Fri, 5 Apr 2002 16:01:46 +0100
From: Chris Wilson <chris@jakdaw.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4/i845 Strange clock drifting
Message-Id: <20020405160146.34075997.chris@jakdaw.org>
In-Reply-To: <Pine.LNX.4.44.0204051614230.31733-100000@netfinity.realnet.co.sz>
Organization: Hah!
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zwane,

Thanks for your message.

> All P4s have a local APIC, however your bios can play a part in making it 
> unavailable (global enable flag in apic base MSR). Please send me your 
> dmesg.

I've looked through the motherboard manual and it doesn't look like there
are any settings that should affect this. dmesg is at the bottom of this
message.

> Have you tried the various reboot kernel parameters? You can try the 
> following.
> 
> reboot=w - Sets warm reboot flag
> reboot=c - Sets cold reboot flag
> reboot=b - Reboot via jump to BIOS
> 
> and finally if you're really desperate ;)
> 
> reboot=h - do a hard reboot, i think this is does a triple fault

Thanks - I wasn't aware of them! I'll see whether that fixes the reboot problem!

Cheers,

Chris

dmesg:

Linux version 2.4.18 (root@lightning) (gcc version 2.95.3 20010315 (release)) #5 Wed Apr 3 19:21:02 BST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=Linux ro root=900
Initializing CPU#0
Detected 1999.834 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 1029912k/1048512k available (1019k kernel code, 18216k reserved, 300k data, 212k init, 131008k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb1a0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 18
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: IC35L040AVVA07-0, ATA DISK drive
hdb: IC35L040AVVA07-0, ATA DISK drive
hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=5005/255/63, UDMA(100)
hdb: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=5005/255/63, UDMA(100)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2
 hdb: hdb1 hdb2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 12 for device 02:06.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:51:01:AF, IRQ 12.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PCI: Found IRQ 11 for device 02:07.0
PCI: Sharing IRQ 11 with 02:08.0
eth1: OEM i82557/i82558 10/100 Ethernet, 00:30:48:51:01:AE, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000024]
 [events: 00000024]
md: autorun ...
md: considering hdb1 ...
md:  adding hdb1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1,1>
md: bind<hdb1,2>
md: running: <hdb1><hda1>
md: hdb1's event counter: 00000024
md: hda1's event counter: 00000024
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb1 operational as mirror 0
raid1: device hda1 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdb1 [events: 00000025]<6>(write) hdb1's sb offset: 39150272
md: hda1 [events: 00000025]<6>(write) hda1's sb offset: 39150272
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
