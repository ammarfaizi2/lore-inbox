Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUIMRZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUIMRZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIMRZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:25:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46483 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268848AbUIMRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:24:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-rc1-mm5
Date: Mon, 13 Sep 2004 10:24:08 -0700
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <414566DC.8000008@yahoo.com.au>
In-Reply-To: <414566DC.8000008@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4edRBBgFzRXbS0F"
Message-Id: <200409131024.08643.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4edRBBgFzRXbS0F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, September 13, 2004 2:22 am, Nick Piggin wrote:
> In particular, anyone who was having trouble with sched-domains and/or CPU
> hotplug please test this.
>
> It is supposed to fix all known issues, but some patches are fairly
> involved, and not having been tested on problem hardware, there could be
> still some bugs. Please let me know if anything goes bug.
>
> Also, ia64 sched-domains setup is possibly still broken. If anyone boots
> this on an Altix, please send over the full dmesg! Thanks.

Didn't you get my last mail about this?  Looks like the lack 
of !defined(SD_NODE_INIT) in sched.h made its way to Andrew.  Here's the 
dmesg from a 2p, 1 node box, I'll send out a more complete one later (unless 
Paul beat me to it, I'm still only part way through my lkml mailbox).

Thanks,
Jesse

--Boundary-00=_4edRBBgFzRXbS0F
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.9-rc1-mm5 (jbarnes@tomahawk.engr.sgi.com) (gcc version 3.4.1) #1 SMP Mon Sep 13 10:10:54 PDT 2004
EFI v1.02 by SGI: SALsystab=0x30047c4600 ACPI 2.0=0x30047c4dd0
ACPI: RSDP (v002    SGI                                ) @ 0x00000030047c4dd0
ACPI: XSDT (v001    SGI  XSDTSN2 0x00010001  0x00000001) @ 0x00000030047c4e10
ACPI: MADT (v001    SGI  APICSN2 0x00010001  0x00000001) @ 0x00000030047c4e70
ACPI: SRAT (v001    SGI  SRATSN2 0x00010001  0x00000001) @ 0x00000030047c4ed0
ACPI: SLIT (v001    SGI  SLITSN2 0x00010001  0x00000001) @ 0x00000030047c4f60
ACPI: FADT (v003    SGI  FACPSN2 0x00030001  0x00000001) @ 0x00000030047c5030
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x00000030047c4ff0
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000000000000000
Number of logical nodes in system = 1
Number of memory chunks in system = 1
SAL 2.9: SGI SN2 version 3.40
SAL Platform features: ITC_Drift
SAL: AP wakeup using external interrupt vector 0x12
ACPI: Local APIC address 0xc0000000fee00000
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 52
GSI 52 (level, low) -> CPU 0 (0x0000) vector 48
2 CPUs available, 2 CPUs total
Increasing MCA rendezvous timeout from 20000 to 49000 milliseconds
MCA related initialization done
SGI SAL version 3.40
Virtual mem_map starts at 0xa0007fffce938000
On node 0 totalpages: 375305
  DMA zone: 375305 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:\EFI\sgi\vmlinuz.jb root=/dev/sda3 console=ttySG0 profile=1
kernel profiling enabled (shift: 1)
PID hash table entries: 4096 (order: 12, 131072 bytes)
CPU 0: base freq=200.000MHz, ITC ratio=10/2, ITC freq=1000.000MHz+/--1ppm
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
Memory: 5923712k/6004880k available (7125k code, 93232k reserved, 3433k data, 352k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 1481.36 BogoMIPS (lpj=722944)
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
CPU 1: base freq=200.000MHz, ITC ratio=10/2, ITC freq=1000.000MHz+/--1ppm
Calibrating delay loop... 16.44 BogoMIPS (lpj=8176)
Brought up 2 CPUs
Total of 2 processors activated (1498.80 BogoMIPS).
CPU0:
 domain 0: span 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000003
  groups: 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
  domain 1: does not balance
CPU1:
 domain 0: span 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000003
  groups: 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
  domain 1: does not balance
NET: Registered protocol family 16
ACPI: Subsystem revision 20040816
ACPI: SCI (ACPI GSI 52) not registered
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)
SGI XFS with ACLs, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
IA-PC Multimedia Timer: v1.0, 25 MHz
EFI Time Services Driver v0.4
sn_console: Console driver init
ttySG0 at I/O 0x0 (irq = 0) is a SGI SN L1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.9 (August 30, 2004)
ACPI: PCI interrupt 0000:01:04.0[A]: no GSI
eth0: Tigon3 [partno(030-1771-000) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 08:00:69:13:ee:3b
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI interrupt 0000:01:01.0[A]: no GSI
SGIIOC4: IDE controller at PCI slot 0000:01:01.0, revision 79
ide0: BM-DMA at 0xc00000080f200140-0xc00000080f200163
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0xc00000080f200100-0xc00000080f200107,0xc00000080f200120 on irq 55
ide1: I/O resource 0x376-0x376 not free.
ide1: ports already in use, skipping probe
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
ide3: I/O resource 0x36E-0x36E not free.
ide3: ports already in use, skipping probe
ide4: I/O resource 0x3E6-0x3E6 not free.
ide4: ports already in use, skipping probe
ide5: I/O resource 0x366-0x366 not free.
ide5: ports already in use, skipping probe
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(16)
Uniform CD-ROM driver Revision: 3.20
qla1280: QLA12160 found on PCI bus 1, dev 3
ACPI: PCI interrupt 0000:01:03.0[A]: no GSI
scsi(0): Enabling SN2 PCI DMA dual channel lockup workaround
scsi(0): Enabling SN2 PCI DMA workaround
scsi(0:0): Resetting SCSI BUS
scsi(0:1): Resetting SCSI BUS
scsi0 : QLogic QLA12160 PCI to SCSI Host Adapter
       Firmware version: 10.04.32, Driver version 3.24.4
  Vendor: SGI       Model: ST318453LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(0:0:1:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
  Vendor: SGI       Model: ST373307LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(0:0:2:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
QLogic Fibre Channel HBA Driver (a0000001007e0840)
libata version 1.02 loaded.
SCSI device sda: 35843686 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Fusion MPT base driver 3.01.16
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.16
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   ia64      :  2080.768 MB/sec
raid5: using function: ia64 (2080.768 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP: routing cache hash table of 131072 buckets, 2048Kbytes
TCP: Hash tables configured (established 4194304 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 352kB freed
cdrom: hda: mmc-3 profile capable, current profile: 8h
cdrom: hda: mmc-3 profile capable, current profile: 8h
cdrom: hda: mmc-3 profile capable, current profile: 8h
cdrom: hda: mmc-3 profile capable, current profile: 8h
cdrom: hda: mmc-3 profile capable, current profile: 8h
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.

--Boundary-00=_4edRBBgFzRXbS0F--
