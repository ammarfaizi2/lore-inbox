Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSKVXYb>; Fri, 22 Nov 2002 18:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSKVXYb>; Fri, 22 Nov 2002 18:24:31 -0500
Received: from mail.transzap.com ([66.179.36.84]:17903 "HELO
	connect.oildex.com") by vger.kernel.org with SMTP
	id <S265400AbSKVXYW>; Fri, 22 Nov 2002 18:24:22 -0500
Message-ID: <CA3FD75251B0CE43B9B6CA87786E2E4307B37D@tzi.transzap.com>
From: Bill Gardner <bgardner@transzap.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: aic7xxx driver error at boot for Adaptec AIC-7899P U160
Date: Fri, 22 Nov 2002 16:31:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We are seeing some strange errors at boot time from the aic7xxx driver.

Relevant HW/SW Info:

   Host: Racksaver (Model: RS-1129) with dual AMD Athlon(tm) MP 2100+ cpu's
   Motherboard: Tyan S2468 with an onboard Adaptec AIC-7899P U160/m (rev
01). 
   Dist: Redhat 7.3
   Kernel: Linux version 2.4.18-3smp (bhcompile@porky.devel.redhat.com) 
      (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu
Apr 18 06:59:55 EDT 2002

Relevant Console errors:

   scsi0:0:0:0: Attempting to queue an ABORT message
   scsi0: Dumping Card State while idle, at SEQADDR 0x44

   ...whole bunch of aic7xxx dump messages (see below for complete list)

   scsi0:0:0:0: Command already completed
   aic7xxx_abort returns 0x2002
   scsi0:0:0:0: Attempting to queue an ABORT message
   scsi0: Dumping Card State while idle, at SEQADDR 0x44

   ...more dump messages, and finally (ditto)

   scsi0:0:0:0: Command already completed
   aic7xxx_abort returns 0x2002
   scsi0:0:0:0: Attempting to queue a TARGET RESET message
   scsi0:0:0:0: Is not an active device
   aic7xxx_dev_reset returns 0x2002
   scsi: device set offline - not ready or command retry failed after bus
reset: host 0 channel 0 id 0 lun 0
     Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
     Type:   Direct-Access                      ANSI SCSI revision: 03
   scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
   Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
   (scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
   SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)


Once the driver sees the IBM disk at scsi0:A:6 everything seems fine and the
hosts seem to
run fine after this but I am naturally concerned when I see a whole lotta
error messages
when I boot these things.

I have included below:

1. Contents of /proc/scsi/scsi
2. Contents of /proc/scsi/aic7xxx/0
3. Complete console messages from a boot with modules.conf options entry for
the aic7xxx:
   options aic7xxx aic7xxx='"verbose"'
4. Contents of /proc/cpuinfo
5. Output from lspci -vv

Thanks for any pointers...

..billg

Contents of /proc/scsi/scsi
============================================================================
============

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: IC35L018UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03


Contents of /proc/scsi/aic7xxx/0
============================================================================
=============

# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.2.5
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 6 Lun 0 Settings
                Commands Queued 7691
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)


Console Messages from serial console:
============================================================================
=============

  Booting 'Red Hat Linux (2.4.18-3smp)'

root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz-2.4.18-3smp ro root=/dev/sda2 console=ttyS0,38400n8
   [Linux-bzImage, setup=0x1400, size=0x10c200]
initrd /initrd-2.4.18-3smp.img
   [Linux-initrd @ 0x37fb3000, 0x3ca99 bytes]

  Linux version 2.4.18-3smp (bhcompile@porky.devel.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 06:59:55 EDT
2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
found SMP MP-table at 000f7180
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: ro root=/dev/sda2 console=ttyS0,38400n8
Initializing CPU#0
Detected 1733.406 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 1029996k/1048064k available (1224k kernel code, 17680k reserved,
839k data, 304k init, 130560k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU0: AMD Athlon(tm) MP 2100+ stepping 02
per-CPU timeslice cutoff: 731.26 usecs.
task migration cache decay timeout: 10 msecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3460.30 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6920.60 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1733.3544 MHz.
..... host bus clock speed is 266.6699 MHz.
cpu: 0, clocks: 2666699, slice: 888899
CPU0<T0:2666688,T1:1777776,D:13,S:888899,C:2666699>
cpu: 1, clocks: 2666699, slice: 888899
CPU1<T0:2666688,T1:888880,D:10,S:888899,C:2666699>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router default [1022/7443] at 00:07.3
BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: MATSHITA CR-176, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 242k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.3.10 starSCSI subsystem driver Revision: 1.00
ting
Loading sckmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno
= 2
si_mod module
Loading sd_mod module
Loading aic7xxx module
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x44
ACCUM = 0x3, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x0
SCSIPHASE = 0x0
STACK == 0x175, 0x0, 0x0, 0x3
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x0, s 0x7, l 0, t 0xff) 1(c 0x0, s 0x67, l 0, t
0xff) 2(c 0x0, s 0x0, l 0, t 0xff) 3(c 0x0, s 0x67, l 0, t 0xff) 4(c 0x0, s
0x0, l 0, t 0xff) 5(c 0x0, s 0x67, l 0, t 0xff) 6(c 0x0, s 0x67, l 0, t
0xff) 7(c 0x0, s 0x67, l 0, t 0xff) 8(c 0x0, s 0x67, l 0, t 0xff) 9(c 0x0, s
0x67, l 0, t 0xff) 10(c 0x0, s 0x67, l 0, t 0xff) 11(c 0x0, s 0x67, l 0, t
0xff) 12(c 0x0, s 0x67, l 0, t 0xff) 13(c 0x0, s 0x67, l 0, t 0xff) 14(c
0x0, s 0x67, l 0, t 0xff) 15(c 0x0, s 0x67, l 0, t 0xff) 16(c 0x0, s 0x67, l
0, t 0xff) 17(c 0x0, s 0x67, l 0, t 0xff) 18(c 0x0, s 0x67, l 0, t 0xff)
19(c 0x0, s 0x67, l 0, t 0xff) 20(c 0x0, s 0x67, l 0, t 0xff) 21(c 0x0, s
0x67, l 0, t 0xff) 22(c 0x0, s 0x67, l 0, t 0xff) 23(c 0x0, s 0x67, l 0, t
0xff) 24(c 0x0, s 0x67, l 0, t 0xff) 25(c 0x0, s 0x67, l 0, t 0xff) 26(c
0x0, s 0x67, l 0, t 0xff) 27(c 0x0, s 0x67, l 0, t 0xff) 28(c 0x0, s 0x67, l
0, t 0xff) 29(c 0x0, s 0x67, l 0, t 0xff) 30(c 0x0, s 0x67, l 0, t 0xff)
31(c 0x0, s 0x67, l 0, t 0xff)
Pending list:
Kernel Free SCB list: 3 1 0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x44
ACCUM = 0x2, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x0
SCSIPHASE = 0x0
STACK == 0x175, 0x0, 0x0, 0x3
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x0, s 0x7, l 0, t 0xff) 1(c 0x0, s 0x67, l 0, t
0xff) 2(c 0x0, s 0x0, l 0, t 0xff) 3(c 0x0, s 0x67, l 0, t 0xff) 4(c 0x0, s
0x0, l 0, t 0xff) 5(c 0x0, s 0x67, l 0, t 0xff) 6(c 0x0, s 0x67, l 0, t
0xff) 7(c 0x0, s 0x67, l 0, t 0xff) 8(c 0x0, s 0x67, l 0, t 0xff) 9(c 0x0, s
0x67, l 0, t 0xff) 10(c 0x0, s 0x67, l 0, t 0xff) 11(c 0x0, s 0x67, l 0, t
0xff) 12(c 0x0, s 0x67, l 0, t 0xff) 13(c 0x0, s 0x67, l 0, t 0xff) 14(c
0x0, s 0x67, l 0, t 0xff) 15(c 0x0, s 0x67, l 0, t 0xff) 16(c 0x0, s 0x67, l
0, t 0xff) 17(c 0x0, s 0x67, l 0, t 0xff) 18(c 0x0, s 0x67, l 0, t 0xff)
19(c 0x0, s 0x67, l 0, t 0xff) 20(c 0x0, s 0x67, l 0, t 0xff) 21(c 0x0, s
0x67, l 0, t 0xff) 22(c 0x0, s 0x67, l 0, t 0xff) 23(c 0x0, s 0x67, l 0, t
0xff) 24(c 0x0, s 0x67, l 0, t 0xff) 25(c 0x0, s 0x67, l 0, t 0xff) 26(c
0x0, s 0x67, l 0, t 0xff) 27(c 0x0, s 0x67, l 0, t 0xff) 28(c 0x0, s 0x67, l
0, t 0xff) 29(c 0x0, s 0x67, l 0, t 0xff) 30(c 0x0, s 0x67, l 0, t 0xff)
31(c 0x0, s 0x67, l 0, t 0xff)
Pending list:
Kernel Free SCB list: 2 1 0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Is not an active device
aic7xxx_dev_reset returns 0x2002
scsi: device set offline - not ready or command retry failed after bus
reset: host 0 channel 0 id 0 lun 0
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3
Loading jbd module
Journalled Block Device driver loaded
Loading ext3 module
Mounting /proc filesystem
Creating root device
Mounting root filesystem
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 304k freed
INIT: version 2.84 booting
                Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Unmounting initrd:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Thu Nov 21 18:06:08 MST 2002 [ OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname silver:  [  OK  ]
Checking root filesystem
/: clean, 74684/1978592 files, 378971/3956006 blocks
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda2
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
/boot: clean, 47/12048 files, 15831/48163 blocks
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmapper: [  OK  ]
Initializing random number generator:  [  OK  ]
Starting sshd:  [  OK  ]
Starting xinetd: [  OK  ]
Starting sendmail: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]

Red Hat Linux release 7.3 (Valhalla)
Kernel 2.4.18-3smp on an i686

Contents of /proc/cpuinfo
============================================================================
======
# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 2100+
stepping        : 2
cpu MHz         : 1733.406
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3460.30

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1733.406
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3460.30

Output from lspci -vv
============================================================================
=======
#lspci -vv

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f6200000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1810 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP
Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev
04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Tyan Computer: Unknown device 2468
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at 1000 [disabled] [size=256]
        Region 1: Memory at f4000000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Tyan Computer: Unknown device 2468
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin B routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 1400 [disabled] [size=256]
        Region 1: Memory at f4001000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: f4100000-f5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

02:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at f4101000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 2400 [size=128]
        Region 1: Memory at f4102000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:09.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2480 [size=128]
        Region 1: Memory at f4102400 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

.

bill gardner     (v) 303.222.6110
it/noc manager   (m) 303.818.8248
transzap, inc.   (f) 303.863.0505

1580 lincoln st, suite 930, denver, co 80203

