Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTJOWWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJOWWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 18:22:13 -0400
Received: from bcsii.com ([67.114.178.171]:15287 "EHLO mail.bcsii.com")
	by vger.kernel.org with ESMTP id S261719AbTJOWWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 18:22:09 -0400
Message-ID: <3F8DC990.1040203@bcsii.net>
Date: Wed, 15 Oct 2003 15:26:24 -0700
From: Andriy Rysin <arysin@bcsii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: 2.4.20, 2.4.22, 2.4.6-test7: system locks up completely when writing
 to floppy (2.2.20 is ok)
References: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got two motherboards on which I have this problem, they're ASUS 
P4S533-X and P4S533-MX. When I am trying to write something to a floppy 
the system hangs completely. dd, mkfs or mount + cp are all the sme. The 
floppy does several writing sounds and that's it, the light is on. No 
oppses, no panic no log/console messages. I have this with 2.4.20, 
2.4.22 both from RedHat and 2.4.6-test7 from 
http://people.redhat.com/arjanv/2.5/RPMS.kernel/
I don't have this with DOS :) or linux 2.2.20 from tomsrtbt floppy and I 
don't have this on any other motherboards.
I changed floppy, changed floppy cable, tried different BIOS settings, 
changed video card, changed hardrives, booted in S mode. Reproducible 100%.
It seems pretty like this message 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.2/1557.html
dmesg from 2.4.22 is below.
Please CC me if you reply or need more info.

Andriy


Linux version 2.4.22-20.1.2024.2.36.nptl 
(bhcompile@daffy.perf.redhat.com) (gcc version 3.2.3 20030422 (Red Hat 
Linux 3.2.3-6)) #1 Wed Sep 3 10:53:22 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5690
ACPI: RSDT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S533-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=2.4.22 ro 
BOOT_FILE=/boot/vmlinuz-2.4.22-20.1.2024.2.36.nptl acpi=ht hdc=ide-scsi 
root=LABEL=/ panic=60
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2200.180 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4390.91 BogoMIPS
Memory: 514312k/524272k available (1506k kernel code, 9572k reserved, 
1110k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.20GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xf1060, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1039/0962] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Asus Laptop ACPI Extras version 0.24a
  Couldn't get the DSDT table header
  Error registering Asus Laptop ACPI Extras Driver
        -0420: *** Error: Could not allocate an object descriptor
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00ETA0, ATA DISK drive
blk: queue c040f3a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: SONY CD-RW CRX225E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, 
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 145k freed


