Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315088AbSDWITq>; Tue, 23 Apr 2002 04:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315103AbSDWITp>; Tue, 23 Apr 2002 04:19:45 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:43018 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315088AbSDWITn>; Tue, 23 Apr 2002 04:19:43 -0400
Subject: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 23 Apr 2002 01:18:14 -0700
Message-Id: <1019549894.1450.41.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should probably add the /proc/ksyms snapshotting stuff to 
get the module information for you as well.  I hope this 
current batch of info helps, for starters.

ksymoops 2.4.4 on i686 2.4.7-10.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.9/ (specified)
     -m /boot/System.map-2.5.9 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01fb579>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000004   ebx: cf44be24   ecx: 00000000   edx: 00000000
esi: cf44bd90   edi: c03426bc   ebp: 00000296   esp: c02ddeac
ds: 0018   es: 0018   ss: 0018
Stack: 00000001 cf44bd90 cf44be24 c03426bc 00000001 c01ff62f c03426bc 00000001 
       00000000 d98f164d c03426bc 00000001 cf44bd50 00000000 cf44bd90 cf44be24 
       cff26500 d98f227b c02ddf0c c03426bc 00000000 c02ddf10 00000000 c01fce26 
Call Trace: [<c01ff62f>] [<d98f164d>] [<d98f227b>] [<c01fce26>] [<c01fd433>] 
   [<d98f2250>] [<c0108709>] [<c01088eb>] [<c0105310>] [<c010730e>] [<c0105310>] 
   [<c0105310>] [<c0105337>] [<c01053b6>] [<c0105000>] 
Code: c7 04 90 00 00 00 00 8b 53 0c 8b 87 20 02 00 00 0f b3 10 8b 

>>EIP; c01fb579 <__ide_end_request+109/190>   <=====
Trace; c01ff62f <ide_end_request+f/20>
Trace; d98f164d <END_OF_CODE+195a2039/????>
Trace; d98f227b <END_OF_CODE+195a2c67/????>
Trace; c01fce26 <ide_do_request+36/a0>
Trace; c01fd433 <ide_intr+103/1c0>
Trace; d98f2250 <END_OF_CODE+195a2c3c/????>
Trace; c0108709 <handle_IRQ_event+39/70>
Trace; c01088eb <do_IRQ+8b/110>
Trace; c0105310 <default_idle+0/30>
Trace; c010730e <common_interrupt+22/28>
Trace; c0105310 <default_idle+0/30>
Trace; c0105310 <default_idle+0/30>
Trace; c0105337 <default_idle+27/30>
Trace; c01053b6 <cpu_idle+36/40>
Trace; c0105000 <_stext+0/0>
Code;  c01fb579 <__ide_end_request+109/190>
00000000 <_EIP>:
Code;  c01fb579 <__ide_end_request+109/190>   <=====
   0:   c7 04 90 00 00 00 00      movl   $0x0,(%eax,%edx,4)   <=====
Code;  c01fb580 <__ide_end_request+110/190>
   7:   8b 53 0c                  mov    0xc(%ebx),%edx
Code;  c01fb583 <__ide_end_request+113/190>
   a:   8b 87 20 02 00 00         mov    0x220(%edi),%eax
Code;  c01fb589 <__ide_end_request+119/190>
  10:   0f b3 10                  btr    %edx,(%eax)
Code;  c01fb58c <__ide_end_request+11c/190>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning and 1 error issued.  Results may not be reliable.


Linux version 2.5.9 (root@turbulence.megapathdsl.net) (gcc version 3.0.4 (Red Hat Linux 7.2 3.0.4-1)) #4 2BIOS-provided physical RAM map:                                   
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)          
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)        
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
 BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65504
zone(0): 4096 pages.
zone(1): 61408 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fae70
ACPI: RSDT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff0000
ACPI: FADT (v001 GATEWA 8DT-084  00529.06553) @ 0x0fff1000
Kernel command line: ro root=/dev/hda6 hdd=ide-scsi console=ttyS0,38400 video=riva:1600x1200-16@76
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 848.364 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 256916k/262016k available (1509k kernel code, 4712k reserved, 391k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 848.3696 MHz.
..... host bus clock speed is 199.6163 MHz.
cpu: 0, clocks: 1996163, slice: 998081
CPU0<T0:1996160,T1:998064,D:15,S:998081,C:1996163>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
ACPI: Bus Driver revision 20020404
ACPI: Core Subsystem revision 20020403
PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1
PCI: Using configuration type 1
 tbxface-0101 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................
83 Control Methods found and parsed (271 nodes total)
ACPI Namespace successfully loaded at root c03276f8
evxfevnt-0080 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:............... exfldio-0100 [21] Ex_setup_region       : Field) exfldio-0110 [21] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)  uteval-0421 [07] Ut_execute_STA        : _STA on PS2M failed AE_AML_REGION_LIMIT
...........
26 Devices found containing: 25 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................................
 Initialized 12/15 Regions 1/1 Fields 21/21 Buffers 8/9 Packages (271 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Root Bridge [PCI0] (00:00:00.00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
      00:00:11[A] -> \_SB_.LNKA[0]
      00:00:11[B] -> \_SB_.LNKB[0]
      00:00:11[C] -> \_SB_.LNKC[0]
      00:00:11[D] -> \_SB_.LNKD[0]
      00:00:12[A] -> \_SB_.LNKB[0]
      00:00:12[B] -> \_SB_.LNKC[0]
      00:00:12[C] -> \_SB_.LNKD[0]
      00:00:12[D] -> \_SB_.LNKA[0]
      00:00:13[A] -> \_SB_.LNKC[0]
      00:00:13[B] -> \_SB_.LNKD[0]
      00:00:13[C] -> \_SB_.LNKA[0]
      00:00:13[D] -> \_SB_.LNKB[0]
      00:00:14[A] -> \_SB_.LNKB[0]
      00:00:14[B] -> \_SB_.LNKC[0]
      00:00:14[C] -> \_SB_.LNKD[0]
      00:00:14[D] -> \_SB_.LNKA[0]
      00:00:0F[A] -> \_SB_.LNKA[0]
      00:00:0F[B] -> \_SB_.LNKB[0]
      00:00:0F[C] -> \_SB_.LNKC[0]
      00:00:0F[D] -> \_SB_.LNKD[0]
      00:00:07[D] -> \_SB_.LNKD[0]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
      00:01:05[A] -> \_SB_.LNKA[0]
 exfldio-0100 [21] Ex_setup_region       : Field [PS2E] access width (4 bytes) too large for region [PSRG) exfldio-0110 [21] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [)acpi_pci_link-0164 [09] acpi_pci_link_get_poss: Resource is not an IRQ entry
acpi_pci_link-0164 [09] acpi_pci_link_get_poss: Resource is not an IRQ entry
acpi_pci_link-0164 [09] acpi_pci_link_get_poss: Resource is not an IRQ entry
acpi_pci_link-0164 [09] acpi_pci_link_get_poss: Resource is not an IRQ entry
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
acpi_pci_link-0330 [02] acpi_pci_link_get_irq : Invalid link context
pci_root-0160 [01] acpi_prt_get_irq      : Unable to reslove IRQ
PCI: No IRQ known for interrupt pin A of device 00:14.0
acpi_pci_link-0330 [02] acpi_pci_link_get_irq : Invalid link context
pci_root-0160 [01] acpi_prt_get_irq      : Unable to reslove IRQ
PCI: No IRQ known for interrupt pin B of device 00:14.1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 200x75
rivafb: PCI nVidia NV16 framebuffer ver 0.9.2a (GeForce-DDR, 32MB @ 0xE8000000)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 0) is a 16550A
block: 256 slots per queue, batch=32
loop: loaded (max 8 devices)
acpi_pci_link-0330 [02] acpi_pci_link_get_irq : Invalid link context
pci_root-0160 [01] acpi_prt_get_irq      : Unable to reslove IRQ
PCI: No IRQ known for interrupt pin A of device 00:13.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:13.0: 3Com PCI 3c905C Tornado at 0xfc00. Vers LK1.1.17
phy=0, phyx=24, mii_status=0x782d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 64M @ 0xf8000000
ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>
ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: IDE controller on PCI slot 00:07.1
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: chipset revision 3
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: not 100% native mode: will probe irqs later
AMD_IDE: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 03) UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xcb00-0xcb07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcb08-0xcb0f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP LM30, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-114 0117, ATAPI CD/DVD-ROM drive
hdd: R/RW 4x4x24, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63, UDMA(66)
Partition check:
 hda: [PTBL] [3649/255/63] hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000098]
 [events: 00000098]
md: autorun ...
md: considering hda12 ...
md:  adding hda12 ...
md:  adding hda11 ...
md: created md0
md: bind<hda11,1>
md0: WARNING: hda12 appears to be on the same physical disk as hda11. True
     protection against single-disk failure might be compromised.
md: bind<hda12,2>
md: running: <hda12><hda11>
md: hda12's event counter: 00000098
md: hda11's event counter: 00000098
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at hda11
raid0:   comparing hda11(1028032) with hda11(1028032)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda12
raid0:   comparing hda12(1028032) with hda11(1028032)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hda11 ... contained as device 0
  (1028032) is smallest!.
raid0: checking hda12 ... contained as device 1
raid0: zone->nb_dev: 2, size: 2056064
raid0: current zone offset: 1028032
raid0: done.
raid0 : md_size is 2056064 blocks.
raid0 : conf->smallest->size is 2056064 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hda12 [events: 00000099]<6>(write) hda12's sb offset: 1028032
md: hda11 [events: 00000099]<6>(write) hda11's sb offset: 1028032
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: AppleTalk 0.18a for Linux NET4.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
INIT: version 2.78 booting
                        Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Mon Apr 22 22:15:59 PDT 2002 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname turbulence.megapathdsl.net:  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB controller (usb-ohci):  [  OK  ]
Initializing USB HID interface:  [  OK  ]
Initializing USB mouse:  modprobe: Can't locate module mousedev
[FAILED]
Checking root filesystem
/: clean, 313674/1921984 files, 2266435/3841535 blocks
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda6 
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Finding module dependencies:  [  OK  ]
Starting up RAID devices: md0 
Checking filesystems
/boot: clean, 77/84336 files, 53660/337333 blocks
/home: clean, 13228/257024 files, 173634/514016 blocks
Logical sector size is zero.dosfsck 2.7, 14 Feb 2001, FAT32, LFN

Logical sector size is zero.dosfsck 2.7, 14 Feb 2001, FAT32, LFN

Logical sector size is zero.dosfsck 2.7, 14 Feb 2001, FAT32, LFN
dosfsck 2.7, 14 Feb 2001, FAT32, LFN
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/hda5 
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/md0 
[/sbin/fsck.vfat (1) -- /mnt/test1] fsck.vfat -a /dev/hda7 
[/sbin/fsck.vfat (1) -- /mnt/test2] fsck.vfat -a /dev/hda8 
[/sbin/fsck.vfat (1) -- /mnt/test3] fsck.vfat -a /dev/hda9 
[/sbin/fsck.vfat (1) -- /mnt/test4] fsck.vfat -a /dev/hda10 

Logical sector size is zero.
[PASSED]
Mounting local filesystems:  mount: wrong fs type, bad option, bad superblock on /dev/hda7,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on /dev/hda8,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on /dev/hda9,
       or too many mounted file systems
mount: mount point /mnt/test4 does not exist
[FAILED]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01fb579>]    Not tainted
EFLAGS: 00010002
eax: 00000004   ebx: cf44be24   ecx: 00000000   edx: 00000000
esi: cf44bd90   edi: c03426bc   ebp: 00000296   esp: c02ddeac
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c02dc000 task=c02bf3e0)
Stack: 00000001 cf44bd90 cf44be24 c03426bc 00000001 c01ff62f c03426bc 00000001 
       00000000 d98f164d c03426bc 00000001 cf44bd50 00000000 cf44bd90 cf44be24 
       cff26500 d98f227b c02ddf0c c03426bc 00000000 c02ddf10 00000000 c01fce26 
Call Trace: [<c01ff62f>] [<d98f164d>] [<d98f227b>] [<c01fce26>] [<c01fd433>] 
   [<d98f2250>] [<c0108709>] [<c01088eb>] [<c0105310>] [<c010730e>] [<c0105310>] 
   [<c0105310>] [<c0105337>] [<c01053b6>] [<c0105000>] 

Code: c7 04 90 00 00 00 00 8b 53 0c 8b 87 20 02 00 00 0f b3 10 8b 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

