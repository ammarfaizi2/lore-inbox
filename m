Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279483AbRKMVhz>; Tue, 13 Nov 2001 16:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279472AbRKMVhq>; Tue, 13 Nov 2001 16:37:46 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:28059 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S279462AbRKMVhm>;
	Tue, 13 Nov 2001 16:37:42 -0500
Date: Tue, 13 Nov 2001 13:37:41 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Oops: 2.4.15pre1
Message-ID: <20011113133740.A5490@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure why this happened.  Anybody have any ideas?  Web serving box
with Dual PIII 800s and 512 MB ECC-SDRAM.

Unable to handle kernel paging request at virtual address 14084791
c0125a3d
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0125a3d>]    Not tainted
EFLAGS: 00010202
eax: 14084789   ebx: cb0dea20   ecx: 00000011   edx: 00007283
esi: c189ca0c   edi: cb0dead0   ebp: 00000001   esp: d832bf48
ds: 0018   es: 0018   ss: 0018
Process miva (pid: 7569, stackpage=d832b000)
Stack: 00000000 08155198 00000000 00002000 00001000 00000001 00000000 00000000 
       cb0dea20 c0125da5 dbf23dc0 dbf23de0 d832bf8c c0125cdc dbf23dc0 ffffffea 
       00000000 00001000 00001000 08156198 00000000 c01321ab dbf23dc0 08155198 
Call Trace: [<c0125da5>] [<c0125cdc>] [<c01321ab>] [<c0106dbb>] 
Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 60 01 00 00 
Error (Oops_bfd_perror): set_section_contents Section has no contents

>>EIP; c0125a3c <do_generic_file_read+1b0/450>   <=====
Trace; c0125da4 <generic_file_read+70/8c>
Trace; c0125cdc <file_read_actor+0/58>
Trace; c01321aa <sys_read+8e/c4>
Trace; c0106dba <system_call+32/38>

...Entire bootup:

Linux version 2.4.15-pre1 (root@devel) (gcc version 2.95.4 20011006 (Debian prerelease)) #5 SMP Wed Nov 7 23:48:23 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6a60
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: STL2         APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Processors: 2
Kernel command line: BOOT_IMAGE=linux ro root=801 console=ttyS0,115200n8 console=tty0
Initializing CPU#0
Detected 799.826 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 513028k/524224k available (1426k kernel code, 10808k reserved, 490k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 732.10 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1599.07 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3194.88 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 799.7856 MHz.
..... host bus clock speed is 133.2974 MHz.
cpu: 0, clocks: 1332974, slice: 444324
CPU0<T0:1332960,T1:888624,D:12,S:444324,C:1332974>
cpu: 1, clocks: 1332974, slice: 444324
CPU1<T0:1332960,T1:444304,D:8,S:444324,C:1332974>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb57, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I6,P0) -> 26
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x5440-0x5447, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x5448-0x544f, BIOS settings: hdc:DMA, hdd:DMA
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
Configuring GDT-PCI HA at 0/6 IRQ 26
scsi0 : GDT6528RS
  Vendor: ICP       Model: Host Drive  #00   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 71682030 512-byte hdwr sectors (36701 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Unable to handle kernel paging request at virtual address 14084791
 printing eip:
c0125a3d
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0125a3d>]    Not tainted
EFLAGS: 00010202
eax: 14084789   ebx: cb0dea20   ecx: 00000011   edx: 00007283
esi: c189ca0c   edi: cb0dead0   ebp: 00000001   esp: d832bf48
ds: 0018   es: 0018   ss: 0018
Process miva (pid: 7569, stackpage=d832b000)
Stack: 00000000 08155198 00000000 00002000 00001000 00000001 00000000 00000000 
       cb0dea20 c0125da5 dbf23dc0 dbf23de0 d832bf8c c0125cdc dbf23dc0 ffffffea 
       00000000 00001000 00001000 08156198 00000000 c01321ab dbf23dc0 08155198 
Call Trace: [<c0125da5>] [<c0125cdc>] [<c01321ab>] [<c0106dbb>] 

Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 60 01 00 00 
 <6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK killalL showMem showPc unRaw Sync showTasks Unmount 
SysRq : Emergency Remount R/O

Shift-pgup/pgdown didn't work...SysRq would print messages but not
do anything.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
