Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132134AbQLIR0C>; Sat, 9 Dec 2000 12:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbQLIRZw>; Sat, 9 Dec 2000 12:25:52 -0500
Received: from www.lightning.ch ([193.247.134.2]:56352 "EHLO www.lightning.ch")
	by vger.kernel.org with ESMTP id <S132134AbQLIRZt>;
	Sat, 9 Dec 2000 12:25:49 -0500
Message-ID: <3A3263E9.E4D5A345@lightning.ch>
Date: Sat, 09 Dec 2000 17:55:05 +0100
From: Jean-Christian de Rivaz <jcdr@lightning.ch>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG]test12-pre7: kernel BUG at buffer.c:827!
Content-Type: multipart/mixed;
 boundary="------------07C79560260774C0DB165182"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------07C79560260774C0DB165182
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I get this message while doing:
rsync -ac --exclude "/proc" --exclude "/raid" / /raid/
to move all data in the raid1 device. I expected to try the md
autodetect feature, but I am afraid something is wrong...

Know problem ?
--
Jean-Christian
--------------07C79560260774C0DB165182
Content-Type: text/plain; charset=us-ascii;
 name="bjork-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bjork-oops.txt"

Dec  9 17:33:44 bjork syslogd 1.3-3#33.1: restart.
Dec  9 17:33:44 bjork kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.
Dec  9 17:33:44 bjork kernel: Inspecting /boot/System.map-2.4.0-test12
Dec  9 17:33:45 bjork kernel: Loaded 12449 symbols from /boot/System.map-2.4.0-test12.
Dec  9 17:33:45 bjork kernel: Symbols match kernel version 2.4.0.
Dec  9 17:33:45 bjork kernel: Loaded 37 symbols from 2 modules.
Dec  9 17:33:45 bjork kernel: Linux version 2.4.0-test12 (root@urga) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Sat Dec 9 16:32:22 CET 2000
Dec  9 17:33:45 bjork kernel: BIOS-provided physical RAM map:
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 0000000000008000 @ 0000000007ff0000 (ACPI data)
Dec  9 17:33:45 bjork kernel:  BIOS-e820: 0000000000008000 @ 0000000007ff8000 (ACPI NVS)
Dec  9 17:33:45 bjork kernel: On node 0 totalpages: 32752
Dec  9 17:33:45 bjork kernel: zone(0): 4096 pages.
Dec  9 17:33:45 bjork kernel: zone(1): 28656 pages.
Dec  9 17:33:45 bjork kernel: zone(2): 0 pages.
Dec  9 17:33:45 bjork kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=301 BOOT_FILE=/vmlinuz idebus=66
Dec  9 17:33:45 bjork kernel: ide_setup: idebus=66
Dec  9 17:33:45 bjork kernel: Initializing CPU#0
Dec  9 17:33:45 bjork kernel: Detected 695.676 MHz processor.
Dec  9 17:33:45 bjork kernel: Console: colour VGA+ 80x25
Dec  9 17:33:45 bjork kernel: Calibrating delay loop... 1389.36 BogoMIPS
Dec  9 17:33:45 bjork kernel: Memory: 126920k/131008k available (1058k kernel code, 3700k reserved, 72k data, 172k init, 0k highmem)
Dec  9 17:33:45 bjork kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Dec  9 17:33:45 bjork kernel: Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Dec  9 17:33:45 bjork kernel: Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec  9 17:33:45 bjork kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Dec  9 17:33:45 bjork kernel: CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
Dec  9 17:33:45 bjork kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec  9 17:33:45 bjork kernel: CPU: L2 cache: 256K
Dec  9 17:33:45 bjork kernel: Intel machine check architecture supported.
Dec  9 17:33:45 bjork kernel: Intel machine check reporting enabled on CPU#0.
Dec  9 17:33:45 bjork kernel: CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Dec  9 17:33:45 bjork kernel: CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
Dec  9 17:33:45 bjork kernel: CPU: Common caps: 0383f9ff 00000000 00000000 00000000
Dec  9 17:33:45 bjork kernel: CPU: Intel Pentium III (Coppermine) stepping 03
Dec  9 17:33:45 bjork kernel: Enabling fast FPU save and restore... done.
Dec  9 17:33:45 bjork kernel: Enabling unmasked SIMD FPU exception support... done.
Dec  9 17:33:45 bjork kernel: Checking 'hlt' instruction... OK.
Dec  9 17:33:45 bjork kernel: POSIX conformance testing by UNIFIX
Dec  9 17:33:45 bjork kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Dec  9 17:33:45 bjork kernel: mtrr: detected mtrr type: Intel
Dec  9 17:33:45 bjork kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
Dec  9 17:33:45 bjork kernel: PCI: Using configuration type 1
Dec  9 17:33:45 bjork kernel: PCI: Probing PCI hardware
Dec  9 17:33:45 bjork kernel: Unknown bridge resource 0: assuming transparent
Dec  9 17:33:45 bjork kernel: Unknown bridge resource 1: assuming transparent
Dec  9 17:33:45 bjork kernel: Unknown bridge resource 2: assuming transparent
Dec  9 17:33:45 bjork kernel: PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Dec  9 17:33:45 bjork kernel: Linux NET4.0 for Linux 2.4
Dec  9 17:33:45 bjork kernel: Based upon Swansea University Computer Society NET3.039
Dec  9 17:33:45 bjork kernel: Initializing RT netlink socket
Dec  9 17:33:45 bjork kernel: apm: BIOS not found.
Dec  9 17:33:45 bjork kernel: ACPI: "Acer" found at 0x000fe030
Dec  9 17:33:45 bjork kernel: Starting kswapd v1.8
Dec  9 17:33:45 bjork kernel: Detected PS/2 Mouse Port.
Dec  9 17:33:45 bjork kernel: pty: 256 Unix98 ptys configured
Dec  9 17:33:45 bjork kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Dec  9 17:33:45 bjork kernel: ide: Assuming 66MHz system bus speed for PIO modes
Dec  9 17:33:45 bjork kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
Dec  9 17:33:45 bjork kernel: PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
Dec  9 17:33:45 bjork kernel: ALI15X3: chipset revision 193
Dec  9 17:33:45 bjork kernel: ALI15X3: not 100%% native mode: will probe irqs later
Dec  9 17:33:45 bjork kernel:     ide0: BM-DMA at 0x7090-0x7097, BIOS settings: hda:DMA, hdb:pio
Dec  9 17:33:45 bjork kernel:     ide1: BM-DMA at 0x7098-0x709f, BIOS settings: hdc:DMA, hdd:pio
Dec  9 17:33:45 bjork kernel: hda: IBM-DJNA-352030, ATA DISK drive
Dec  9 17:33:45 bjork kernel: hdc: IBM-DJNA-352030, ATA DISK drive
Dec  9 17:33:45 bjork kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  9 17:33:45 bjork kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  9 17:33:45 bjork kernel: hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63, UDMA(33)
Dec  9 17:33:45 bjork kernel: hdc: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63, UDMA(33)
Dec  9 17:33:45 bjork kernel: Partition check:
Dec  9 17:33:45 bjork kernel:  hda: hda1 hda2
Dec  9 17:33:45 bjork kernel:  hdc: hdc1 hdc2
Dec  9 17:33:45 bjork kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec  9 17:33:45 bjork kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec  9 17:33:45 bjork kernel: [drm] Initialized tdfx 1.0.0 20000928 on minor 63
Dec  9 17:33:45 bjork kernel: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Dec  9 17:33:45 bjork kernel: raid0 personality registered
Dec  9 17:33:45 bjork kernel: raid1 personality registered
Dec  9 17:33:45 bjork kernel: md.c: sizeof(mdp_super_t) = 4096
Dec  9 17:33:45 bjork kernel: autodetecting RAID arrays
Dec  9 17:33:45 bjork kernel: (read) hda2's sb offset: 19438208 [events: 0000000a]
Dec  9 17:33:45 bjork kernel: (read) hdc2's sb offset: 19438208 [events: 0000000a]
Dec  9 17:33:45 bjork kernel: autorun ...
Dec  9 17:33:45 bjork kernel: considering hdc2 ...
Dec  9 17:33:45 bjork kernel:   adding hdc2 ...
Dec  9 17:33:45 bjork kernel:   adding hda2 ...
Dec  9 17:33:45 bjork kernel: created md0
Dec  9 17:33:45 bjork kernel: bind<hda2,1>
Dec  9 17:33:45 bjork kernel: bind<hdc2,2>
Dec  9 17:33:45 bjork kernel: running: <hdc2><hda2>
Dec  9 17:33:45 bjork kernel: now!
Dec  9 17:33:45 bjork kernel: hdc2's event counter: 0000000a
Dec  9 17:33:45 bjork kernel: hda2's event counter: 0000000a
Dec  9 17:33:45 bjork kernel: md0: max total readahead window set to 124k
Dec  9 17:33:45 bjork kernel: md0: 1 data-disks, max readahead per data-disk: 124k
Dec  9 17:33:45 bjork kernel: raid1: device hdc2 operational as mirror 1
Dec  9 17:33:45 bjork kernel: raid1: device hda2 operational as mirror 0
Dec  9 17:33:45 bjork kernel: (checking disk 0)
Dec  9 17:33:45 bjork kernel: (really checking disk 0)
Dec  9 17:33:45 bjork kernel: (checking disk 1)
Dec  9 17:33:45 bjork kernel: (really checking disk 1)
Dec  9 17:33:45 bjork kernel: (checking disk 2)
Dec  9 17:33:45 bjork kernel: (checking disk 3)
Dec  9 17:33:45 bjork kernel: (checking disk 4)
Dec  9 17:33:45 bjork kernel: (checking disk 5)
Dec  9 17:33:45 bjork kernel: (checking disk 6)
Dec  9 17:33:45 bjork kernel: (checking disk 7)
Dec  9 17:33:45 bjork kernel: (checking disk 8)
Dec  9 17:33:45 bjork kernel: (checking disk 9)
Dec  9 17:33:45 bjork kernel: (checking disk 10)
Dec  9 17:33:45 bjork kernel: (checking disk 11)
Dec  9 17:33:45 bjork kernel: (checking disk 12)
Dec  9 17:33:45 bjork kernel: (checking disk 13)
Dec  9 17:33:45 bjork kernel: (checking disk 14)
Dec  9 17:33:45 bjork kernel: (checking disk 15)
Dec  9 17:33:45 bjork kernel: (checking disk 16)
Dec  9 17:33:45 bjork kernel: (checking disk 17)
Dec  9 17:33:45 bjork kernel: (checking disk 18)
Dec  9 17:33:45 bjork kernel: (checking disk 19)
Dec  9 17:33:45 bjork kernel: (checking disk 20)
Dec  9 17:33:45 bjork kernel: (checking disk 21)
Dec  9 17:33:45 bjork kernel: (checking disk 22)
Dec  9 17:33:45 bjork kernel: (checking disk 23)
Dec  9 17:33:45 bjork kernel: (checking disk 24)
Dec  9 17:33:45 bjork kernel: (checking disk 25)
Dec  9 17:33:45 bjork kernel: (checking disk 26)
Dec  9 17:33:45 bjork kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Dec  9 17:33:45 bjork kernel: md: updating md0 RAID superblock on device
Dec  9 17:33:45 bjork kernel: hdc2 [events: 0000000b](write) hdc2's sb offset: 19438208
Dec  9 17:33:45 bjork kernel: hda2 [events: 0000000b](write) hda2's sb offset: 19438208
Dec  9 17:33:45 bjork kernel: .
Dec  9 17:33:45 bjork kernel: ... autorun DONE.
Dec  9 17:33:45 bjork kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec  9 17:33:45 bjork kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec  9 17:33:45 bjork kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Dec  9 17:33:45 bjork kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec  9 17:33:45 bjork kernel: Linux IP multicast router 0.06 plus PIM-SM
Dec  9 17:33:45 bjork kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec  9 17:33:45 bjork kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec  9 17:33:45 bjork kernel: Freeing unused kernel memory: 172k freed
Dec  9 17:33:45 bjork kernel: Adding Swap: 499928k swap-space (priority -1)
Dec  9 17:33:45 bjork kernel: Linux Tulip driver version 0.9.11 (November 3, 2000)
Dec  9 17:33:45 bjork kernel: PCI: Found IRQ 10 for device 00:13.0
Dec  9 17:33:45 bjork kernel: eth0: Digital DS21140 Tulip rev 34 at 0x7000, 00:C0:F0:31:D6:A4, IRQ 10.
Dec  9 17:33:45 bjork kernel: eth0:  EEPROM default media type Autosense.
Dec  9 17:33:45 bjork kernel: eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
Dec  9 17:33:45 bjork kernel: eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Dec  9 17:33:45 bjork kernel: Real Time Clock Driver v1.10d
Dec  9 17:33:45 bjork kernel: eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
Dec  9 17:38:48 bjork kernel: attempt to access beyond end of device
Dec  9 17:38:48 bjork kernel: 03:01: rw=0, want=13798460, limit=499936
Dec  9 17:38:48 bjork kernel: attempt to access beyond end of device
Dec  9 17:38:48 bjork kernel: 03:01: rw=0, want=1267721926, limit=499936
Dec  9 17:38:48 bjork kernel: attempt to access beyond end of device
Dec  9 17:38:48 bjork kernel: 03:01: rw=0, want=1577260166, limit=499936
Dec  9 17:38:48 bjork kernel: kernel BUG at buffer.c:827!
Dec  9 17:38:48 bjork kernel: invalid operand: 0000
Dec  9 17:38:48 bjork kernel: CPU:    0
Dec  9 17:38:48 bjork kernel: EIP:    0010:[end_buffer_io_async+199/244]
Dec  9 17:38:48 bjork kernel: EFLAGS: 00010282
Dec  9 17:38:48 bjork kernel: eax: 0000001c   ebx: c11417a0   ecx: c020b3c8   edx: 00000001
Dec  9 17:38:48 bjork kernel: esi: c4391ec0   edi: 00000247   ebp: c4391f08   esp: c7625e3c
Dec  9 17:38:48 bjork kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 17:38:48 bjork kernel: Process rsync (pid: 189, stackpage=c7625000)
Dec  9 17:38:48 bjork kernel: Stack: c01d58d7 c01d5cba 0000033b c4391ec0 00000002 0000000c bc06290a c01584ab 
Dec  9 17:38:48 bjork kernel:        c4391ec0 00000000 c4391ec0 00000001 00000000 c7625ec8 c0158611 00000000 
Dec  9 17:38:48 bjork kernel:        c4391ec0 c4391e60 00000308 0000000a 00000400 c0131f31 00000000 00000004 
Dec  9 17:38:48 bjork kernel: Call Trace: [tvecs+18175/69864] [tvecs+19170/69864] [generic_make_request+239/268] [ll_rw_block+329/440] [block_read_full_page+429/544] [ext2_readpage+15/20] [ext2_get_block+0/1184] 
Dec  9 17:38:48 bjork kernel:        [generic_file_readahead+570/768] [do_generic_file_read+474/1352] [generic_file_read+91/120] [file_read_actor+0/84] [sys_read+150/204] [system_call+51/56] [startup_32+43/313] 
Dec  9 17:38:48 bjork kernel: Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00 

--------------07C79560260774C0DB165182
Content-Type: text/plain; charset=us-ascii;
 name="bjork-stat.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bjork-stat.txt"

bjork:/boot# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1               483886    286093    172797  62% /
/dev/md0              19132924    783984  17377032   4% /raid
bjork:/boot# cat /proc/mdstat 
Personalities : [raid0] [raid1] 
read_ahead 1024 sectors
md0 : active raid1 hdc2[1] hda2[0]
      19438208 blocks [2/2] [UU]
      
unused devices: <none>
bjork:/boot# fdisk /dev/hda

The number of cylinders for this disk is set to 2482.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 2482 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        63    499936+  83  Linux
Partition 1 does not end on cylinder boundary:
     phys=(991, 15, 63) should be (991, 254, 63)
/dev/hda2            63      2483  19438272   fd  Linux raid autodetect
Partition 2 does not end on cylinder boundary:
     phys=(1023, 15, 63) should be (1023, 254, 63)

Command (m for help): q

bjork:/boot# fdisk /dev/hdc

The number of cylinders for this disk is set to 39560.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hdc: 16 heads, 63 sectors, 39560 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1             1       992    499936+  82  Linux swap
/dev/hdc2           993     39560  19438272   fd  Linux raid autodetect

Command (m for help): q

bjork:/boot# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 2482/255/63, sectors = 39876480, start = 0
bjork:/boot# hdparm /dev/hdc

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 39560/16/63, sectors = 39876480, start = 0
bjork:/boot# 

--------------07C79560260774C0DB165182
Content-Type: text/plain; charset=us-ascii;
 name="config-2.4.0-test12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.4.0-test12"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_M686FXSR=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_FXSR=y
CONFIG_X86_XMM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
# CONFIG_PARIDE_ATEN is not set
# CONFIG_PARIDE_BPCK is not set
# CONFIG_PARIDE_COMM is not set
# CONFIG_PARIDE_DSTR is not set
# CONFIG_PARIDE_FIT2 is not set
# CONFIG_PARIDE_FIT3 is not set
# CONFIG_PARIDE_EPAT is not set
# CONFIG_PARIDE_EPIA is not set
# CONFIG_PARIDE_FRIQ is not set
# CONFIG_PARIDE_FRPW is not set
# CONFIG_PARIDE_KBIC is not set
# CONFIG_PARIDE_KTTI is not set
# CONFIG_PARIDE_ON20 is not set
# CONFIG_PARIDE_ON26 is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=m
# CONFIG_MD_BOOT is not set
CONFIG_AUTODETECT_RAID=y
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139TOO=m
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

--------------07C79560260774C0DB165182--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
