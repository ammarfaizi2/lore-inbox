Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSKNQ4i>; Thu, 14 Nov 2002 11:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKNQ4i>; Thu, 14 Nov 2002 11:56:38 -0500
Received: from kenga.kmv.ru ([217.106.84.5]:12813 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id <S264976AbSKNQ4e>;
	Thu, 14 Nov 2002 11:56:34 -0500
Date: Thu, 14 Nov 2002 20:03:19 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc1 SMP problem...
Message-ID: <20021114200319.U20656@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-AV-Scanned: Avp!
X-Spam-Score: 10 total
X-Data-Status: msg.XXwoWuwB@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

have a problem... with latest 2.4.20-rc1 kernel. 
-- console output --
LILO
Loading new.....................
Linux version 2.4.20-rc1 (root@kenga-new.kmv.ru) (gcc version 2.96 20000731
(Red Hat Linux 7.3 2.96-110)) #6 SMP Wed Nov 13 01:09:17 MSK 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fff000 (ACPI data)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB LOWMEM available.
found SMP MP-table at 000f72d0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: N440BX       APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=new ro root=802
BOOT_FILE=/boot/vmlinuz-2.4.20-rc1 panic=15 console=ttyS0,38400 console=tty0
nmi_watchdog=1
Initializing CPU#0
Detected 448.885 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 126444k/131008k available (1587k kernel code, 4172k reserved, 409k
data, 304k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1464.52 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 894.56 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (1789.13 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 448.8881 MHz.
..... host bus clock speed is 99.7524 MHz.
cpu: 0, clocks: 997524, slice: 332508
CPU0<T0:997520,T1:665008,D:4,S:332508,C:997524>
cpu: 1, clocks: 997524, slice: 332508
CPU1<T0:997520,T1:332496,D:8,S:332508,C:997524>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdaf0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
PCI: Cannot allocate resource region 4 of device 00:12.1
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) 82558-based Integrated Ethernet with Wake on LAN*
  Mem:0xfa104000  IRQ:5  Speed:0 Mbps  Dx:N/A

PPP generic driver version 2.4.2
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected
sym53c8xx: at PCI bus 0, device 13, function 1
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected
sym53c875-0: rev 0x37 on pci bus 0 device 13 function 0 irq 11
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c875-1: rev 0x37 on pci bus 0 device 13 function 1 irq 10
sym53c875-1: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
  Vendor: IBM       Model: DORS-32160        Rev: WA6A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
sym53c875-1-<0,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 15)
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Partition check:
 sda: sda1 sda2
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 5461)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed

Red Hat Linux release 7.3 (Valhalla)
Kernel 2.4.20-rc1 on an i686

-- end --
Without any active process - works good, but if i try recompile kernel -
it's hangs. Hangs wothout any messages. NMI watchdog not help.

PS: what mean 'PCI: Cannot allocate resource region 4 of device 00:12.1' ?


-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

