Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263581AbUDURzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbUDURzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDURzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:55:09 -0400
Received: from mail-res.bigfish.com ([63.161.60.61]:30362 "EHLO
	mail3-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S263581AbUDURyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:54:24 -0400
Message-ID: <4086B539.9050807@lehman.com>
Date: Wed, 21 Apr 2004 13:54:01 -0400
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [x86_64] Problem booting 2.6.6-rc{1,2} on Sun v60x aka Newisys
 2100, ACPI issue?
X-WSS-ID: 6C986AB1826408-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think there might be a timer IRQ routing issue with 2.6 on this 
particular hardware.  I have tried 2.6.6-rc1-bk4 and 2.6.6-rc2-mm1 and 
both hang after loading the RAM disk.  After the hang, the system 
continues to respond to Ctrl-Alt-Del but does not come up in multi-user 
mode.  However, Redhat AS3 kernel (2.4.21-9.0.1.ELsmp)  works perfectly 
on this machine.
I noticed a difference in timer detection between the two kernel.

2.4 reports:

..TIMER: vector=0x31 pin1=2 pin2=0

2.6.6-rc1-bk4 reports:

..TIMER: vector=0x31 pin1=2 pin2=-1

2.6 is able to boot with acpi=off, though it only comes up in 
uniprocessor mode.
Thanks in advance for any help.  Attached is the complete dmesg output 
for 2.4 and 2.6.

Shantanu

2.4:

Bootdata ok (command line is ro root=LABEL=/ console=tty1 console=ttyS0)
Linux version 2.4.21-9.0.1.ELsmp (bhcompile@dolly.devel.redhat.com) (gcc 
version 3.2.3 20030502 (Red Hat Linux 3.2.3-26)) #1 SMP Mon Feb 9 
22:11:50 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-d000
Scanning NUMA topology in Northbridge 24
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007ff70000
Node 2 bogus settings 80000000-ffffff. Ignored.
Node 3 bogus settings 80000000-ffffff. Ignored.
Node 0 bogus settings 80000000-ffffff. Ignored.
Node 1 bogus settings 80000000-ffffff. Ignored.
Node 2 bogus settings 80000000-ffffff. Ignored.
Node 3 bogus settings 80000000-ffffff. Ignored.
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ff70000
found SMP MP-table at 000f7d60
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009b000 reserved twice.
hm, page 0009c000 reserved twice.
setting up node 0 0-3ffff
On node 0 totalpages: 262143
zone(0): 4096 pages.
zone(1): 258047 pages.
zone(2): 0 pages.
setting up node 1 40000-7ff70
On node 1 totalpages: 262000
zone(0): 0 pages.
zone(1): 262000 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 PTLTD                      ) @ 0x00000000000f7d00
ACPI: XSDT (v001 PTLTD       XSDT   01540.00000) @ 0x000000007ff7108b
ACPI: FADT (v003 NWS    1U2P     01540.00000) @ 0x000000007ff72e46
ACPI: MADT (v001 PTLTD       APIC   01540.00000) @ 0x000000007ff72f3a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 01540.00000) @ 0x000000007ff72fb0
ACPI: DSDT (v001    NWS   1U2P   01540.00000) @ 0x0000000000000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: IOAPIC (id[0x03] address[0xfd000000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfd000000, IRQ 24-27
ACPI: IOAPIC (id[0x04] address[0xfd001000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfd001000, IRQ 28-31
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] 
trigger[0x1])
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=LABEL=/ console=tty1 console=ttyS0
Initializing CPU#0
time.c: Detected 1.193182 MHz PIT timer.
time.c: Detected 1991.941 MHz TSC timer.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 2032020k/2096576k available (1888k kernel code, 0k reserved, 
1939k data, 224k init)
Dentry cache hash table entries: 262144 (order: 10, 4194304 bytes)
Inode cache hash table entries: 131072 (order: 9, 2097152 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 10, 4194304 bytes)
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/8 way)
Machine Check Reporting enabled for CPU#0
POSIX conformance testing by UNIFIX
mtrr: v2.02 (20020716))
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/8 way)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 5121.74 usecs.
task migration cache decay timeout: 10 msecs.
Booting processor 1/1 rip 6000 page 000001003fffa000
Initializing CPU#1
Calibrating delay loop... 3971.48 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/8 way)
Machine Check Reporting enabled for CPU#1
CPU1: AMD Engineering Sample 00 stepping 08
Total of 2 processors activated (7942.96 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
Detected 12.449 MHz APIC timer.
cpu: 0, clocks: 1991940, slice: 663980
CPU0<T0:1991936,T1:1327952,D:4,S:663980,C:1991940>
cpu: 1, clocks: 1991940, slice: 663980
CPU1<T0:1991936,T1:663968,D:8,S:663980,C:1991940>
checking TSC synchronization across CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Starting migration thread for cpu 0
Starting migration thread for cpu 1
ACPI: Subsystem revision 20030619
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:..........................................................................
Table [DSDT](id F004) - 291 Objects with 30 Devices 74 Methods 35 Regions
ACPI Namespace successfully loaded at root ffffffff80564640
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
0000000000008020 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 47 [_GPE] 4 regs at 
00000000000080B0 on int 9
Completing Region/Field/Buffer/Package 
initialization:....................................................................
Initialized 35/35 Regions 0/0 Fields 20/20 Buffers 13/13 Packages (299 
nodes)
Executing all Device _STA and_INI methods:...............................
31 Devices found containing: 31 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
PCI: Using ACPI for IRQ routing
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
PCI-DMA: Disabling IOMMU.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 131036
aio_setup: sizeof(struct page) = 104
Hugetlbfs mounted.
Total HugeTLB memory allocated, 0
IA32 emulation $Id: sys_ia32.c,v 1.56 2003/04/10 10:45:37 ak Exp $
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
register_serial(): autoconfig failed
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 256 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) UDMA100 
controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Red Hat nash verSCSI subsystem driver Revision: 1.00
sion 3.5.13 starFusion MPT base driver 2.05.05+
ting
Loading scCopyright (c) 1999-2002 LSI Logic Corporation
si_mod.o modulemptbase: Initiating ioc0 bringup

Loading sd_mod.o module
Loading mptbase.o module
ioc0: 53C1030: Capabilities={Initiator}
mptbase: 1 MPT adapter found, 1 installed.
Loading mptscsihFusion MPT SCSI Host driver 2.05.05+
.o module
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=27
Starting timer : 0 0
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
Starting timer : 0 0
mptscsih: ioc0: scsi0: Id=1 Lun=0: Queue depth=31
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Loading jbd.o moJournalled Block Device driver loaded
dule
Loading ext3.o module
Mounting /proc filesystemkjournald starting.  Commit interval 5 seconds

Creating block devices
Creating root device
Mounting root filesystem
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 224k freed
INIT: version 2.85 booting
        Welcome to Red Hat Enterprise Linux AS
        Press 'I' to enter interactive startup.
Unmounting initrd:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (utc): Tue Apr 20 16:13:46 EDT 2004 [  OK  ]
Setting hostname njlxlabstinger2:  [  OK  ]
Initializing USB controller (usb-ohci):  [  OK  ]
Mounting USB filesystem:  [  OK  ]
Initializing USB HID interface:  [  OK  ]
Initializing USB keyboard:  [  OK  ]
Initializing USB mouse:  [  OK  ]
Checking root filesystem
/: clean, 73445/513024 files, 384561/1024143 blocks
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda2
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Activating swap partitions:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
/boot: clean, 46/26104 files, 29941/104391 blocks
/local/0: clean, 46911/2998272 files, 296305/5988220 blocks
/tmp: clean, 28/128520 files, 24786/514048 blocks
/var: clean, 649/127744 files, 16144/255024 blocks
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1
[/sbin/fsck.ext3 (1) -- /local/0] fsck.ext3 -a /dev/sda10
[/sbin/fsck.ext3 (1) -- /tmp] fsck.ext3 -a /dev/sda8
[/sbin/fsck.ext3 (1) -- /var] fsck.ext3 -a /dev/sda7
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Applying iptables firewall rules: [  OK  ]
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS statd: [  OK  ]
Starting keytable:  [  OK  ]
Initializing random number generator:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Setting NIS domain name linux.lehman.com:  [  OK  ]
Binding to the NIS domain: [  OK  ]
Listening for an NIS domain server.
Starting automount:[  OK  ]
Starting acpi daemon: [  OK  ]
Starting krbchk:  [  OK  ]
Starting sshd:[  OK  ]
Starting xinetd: [  OK  ]
ntpd: Synchronizing with time server: [  OK  ]
Starting ntpd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: Checking whether ypbind is running...
[  OK  ]
Starting xfs: [  OK  ]
Starting atd: [  OK  ]
Starting Red Hat Network Daemon: [  OK  ]
Starting mdmpd: [  OK  ]

Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
Kernel 2.4.21-9.0.1.ELsmp on an x86_64

njlxlabstinger2 login:


2.6:

Linux version 2.6.6-rc1-bk4-x86_64 (root@njlxlabstinger2) (gcc version 
3.2.3 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Tue Apr 20 13:25:44 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
init_memory_mapping
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007ff70000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
nodedata_phys d000
bootmap start 61440 pages 8
Bootmem setup node 1 0000000040000000-000000007ff70000
nodedata_phys 40000000
bootmap start 1073750016 pages 8
Scan SMP from 0000010000000000 for 1024 bytes.
No mptable found.
Scan SMP from 000001000009fc00 for 1024 bytes.
No mptable found.
Scan SMP from 00000100000f0000 for 65536 bytes.
setting up node 0 0-3ffff
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
setting up node 1 40000-7ff70
On node 1 totalpages: 262000
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262000 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 PTLTD                                     ) @ 
0x00000000000f7d00
ACPI: XSDT (v001 PTLTD       XSDT   0x06040000  LTP 0x00000000) @ 
0x000000007ff7108b
ACPI: FADT (v003 NWS    1U2P     0x06040000 PTEC 0x000f4240) @ 
0x000000007ff72e46
ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @ 
0x000000007ff72f3a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 
0x000000007ff72fb0
ACPI: DSDT (v001    NWS   1U2P   0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
set_pte_phys ffffffffff5fd000 to fee00000
spp_getpage 0000010040e18000
spp_getpage 0000010040e19000
Boot CPU = 0
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
    Bootup CPU
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
set_pte_phys ffffffffff5fc000 to fec00000
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfd000000] global_irq_base[0x18])
set_pte_phys ffffffffff5fb000 to fd000000
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfd000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfd001000] global_irq_base[0x1c])
set_pte_phys ffffffffff5fa000 to fd001000
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfd001000, GSI 28-31
Bus #0 is ISA
Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-0
Int: type 0, pol 0, trig 0, bus 0, irq 1, 2-1
Int: type 0, pol 0, trig 0, bus 0, irq 3, 2-3
Int: type 0, pol 0, trig 0, bus 0, irq 4, 2-4
Int: type 0, pol 0, trig 0, bus 0, irq 5, 2-5
Int: type 0, pol 0, trig 0, bus 0, irq 6, 2-6
Int: type 0, pol 0, trig 0, bus 0, irq 7, 2-7
Int: type 0, pol 0, trig 0, bus 0, irq 8, 2-8
Int: type 0, pol 0, trig 0, bus 0, irq 9, 2-9
Int: type 0, pol 0, trig 0, bus 0, irq 10, 2-10
Int: type 0, pol 0, trig 0, bus 0, irq 11, 2-11
Int: type 0, pol 0, trig 0, bus 0, irq 12, 2-12
Int: type 0, pol 0, trig 0, bus 0, irq 13, 2-13
Int: type 0, pol 0, trig 0, bus 0, irq 14, 2-14
Int: type 0, pol 0, trig 0, bus 0, irq 15, 2-15
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Int: type 0, pol 1, trig 1, bus 0, irq 0, 2-2
Int: type 0, pol 3, trig 3, bus 0, irq 9, 2-9
Using ACPI (MADT) for SMP configuration information
set_pte_phys ffffffffff5fd000 to fee00000
mapped APIC to ffffffffff5fd000 (        fee00000)
set_pte_phys ffffffffff5fc000 to fec00000
mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
set_pte_phys ffffffffff5fb000 to fd000000
mapped IOAPIC to ffffffffff5fb000 (00000000fd000000)
set_pte_phys ffffffffff5fa000 to fd001000
mapped IOAPIC to ffffffffff5fa000 (00000000fd001000)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=tty1 console=ttyS0
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1991.987 MHz processor.
Console: colour VGA+ 80x25
Memory: 2061436k/2096576k available (2277k kernel code, 0k reserved, 
1232k data, 200k init)
Calibrating delay loop... 3915.77 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 1024.34 usecs.
task migration cache decay timeout: 2 msecs.
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 10000
Getting LVT1: 10000
masked ExtINT on CPU#0
ESR value before enabling vector: 00000008
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 rip 6000 rsp 1007ff17f58
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3981.31 BogoMIPS
Stack at about 000001007ff17f3c
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
OK.
AMD Engineering Sample 00 stepping 08
CPU has booted.
Before bogomips.
Total of 2 processors activated (7897.08 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
Synchronizing Arb IDs.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.449 MHz APIC timer.
checking TSC synchronization across 2 CPUs: cpu 1: waiting for commence
passed.
time.c: Using PIT/TSC based timekeeping.
waiting for cpu 1
cpu 1: setting up apic clock
cpu 1: enabling apic timer
cpu 1 eSetting cpu_online_map
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
testing the IO APIC.......................



.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
PCI-DMA: Disabling IOMMU.
set_pte_phys ffffffffff600000 to 4d4000
spp_getpage 0000010040e7f000
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1082491656.442:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S5)
BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Red Hat nash verSCSI subsystem initialized
sion 3.5.16.1 stFusion MPT base driver 3.01.03
arting
Loading Copyright (c) 1999-2004 LSI Logic Corporation
scsi_mod.ko modumptbase: Initiating ioc0 bringup
le
Loading sd_mod.ko module
Loading mptbase.ko module
ioc0: 53C1030: Capabilities={Initiator}
Loading mptscsihFusion MPT SCSI Host driver 3.01.03
.ko module
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=27
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Loading jbd.ko module
Loading ext3.ko module
Mounting /proc filesystem
Mountikjournald starting.  Commit interval 5 seconds
ng sysfs
CreatiEXT3-fs: mounted filesystem with ordered data mode.
ng block devices
Creating root device
Mounting root filesystem
Freeing unused kernel memory: 200k freed
INIT: version 2.85 booting



------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the designated recipient(s) named above.  If you are not the intended recipient of this message you are hereby notified that any review, dissemination, distribution or copying of this message is strictly prohibited.  This communication is for information purposes only and should not be regarded as an offer to sell or as a solicitation of an offer to buy any financial product, an official confirmation of any transaction, or as an official statement of Lehman Brothers.  Email transmission cannot be guaranteed to be secure or error-free.  Therefore, we do not represent that this information is complete or accurate and it should not be relied upon as such.  All information is subject to change without notice.

