Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbVKIV7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbVKIV7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbVKIV7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:59:34 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:63184 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030786AbVKIV7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:59:33 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131568336.24637.91.camel@gaston>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston>
Content-Type: multipart/mixed; boundary="=-M+4QRc5Z/Kwx1saKQx94"
Date: Wed, 09 Nov 2005 13:59:16 -0800
Message-Id: <1131573556.25354.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M+4QRc5Z/Kwx1saKQx94
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-10 at 07:32 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-11-09 at 12:17 -0800, Mike Kravetz wrote:
> > On Wed, Nov 09, 2005 at 06:21:25PM +0100, Christoph Hellwig wrote:
> > > Booting current mainline with 64K pagesize enabled gives me a purple (!)
> > > screen early during boot.
> > 
> > I seem to also be having problems with this patch.  My OpenPOWER 720
> > stopped booting with 2.6.14-git10(and later).  Just using defconfig.
> > 64k page size NOT enabled.  If I back out the 64k page size patch,
> > 2.6.14-git10 boots.  I'm trying to get more info but it is painful.
> > It dies before xmon is initialized.
> 
> There  have been a couple of fixes, try the very latest git. Also, try
> enabling early debug in arch/ppc64/kernel/setup.c
> 
> > I could have sworn that I booted 2.6.14-git7 with the 64k page size
> > patch applied.  But, I can't do that now either.
> > 
> > Some co-workers have successfully booted other POWER systems with these
> > kernels.  So, it must be specific to my hardware/LPAR configuration.
> 
> Ok, i'll do more tests here too.

I didn't have any luck on 2.6.14-git12 either.
I tried 64k page support on my P570. 

Here are the console messages:

Thanks,
Badari

--=-M+4QRc5Z/Kwx1saKQx94
Content-Disposition: attachment; filename=64kpage.out
Content-Type: text/plain; name=64kpage.out; charset=utf-8
Content-Transfer-Encoding: 7bit

boot: 2614git12
Please wait, loading kernel...
   Elf32 kernel loaded...

zImage starting: loaded at 0x00401a04 (sp: 0x019ffbe0)
Allocating 0x845378 bytes for kernel ...
gunzipping (0x1c00000 <- 0x407a04:0x63e99d)...done 0x6963d8 bytes
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: root=/dev/sda3 selinux=0 elevator=cfq
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000002460000
  alloc_top    : 0000000008000000
  alloc_top_hi : 00000000ed000000
  rmo_top      : 0000000008000000
  ram_top      : 00000000ed000000
Looking for displays
instantiating rtas at 0x00000000077c0000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002470000 -> 0x00000000024711de
Device tree struct  0x0000000002480000 -> 0x00000000024a0000
Calling quiesce ...
returning from prom_init
Page orders: linear mapping = 24, others = 12
Bogus initrd 00000000 00000000
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 #1 SMP Wed Nov 9 10:51:26 PST 2005
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000618a00
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0xed000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.14-git12 (root@elm3b157) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Wed Nov 9 10:51:26 PST 2005
[boot]0012 Setup Arch
Node 0 Memory: 0x0-0xed000000
Syscall map setup, 240 32-bit and 219 64-bit syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 206.999000 MHz
time_init: processor frequency   = 1655.992000 MHz
Page orders: linear mapping = 24, others = 12
Bogus initrd 00000000 00000000
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 #1 SMP Wed Nov 9 10:51:26 PST 2005
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000618a00
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0xed000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.14-git12 (root@elm3b157) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Wed Nov 9 10:51:26 PST 2005
[boot]0012 Setup Arch
Node 0 Memory: 0x0-0xed000000
Syscall map setup, 240 32-bit and 219 64-bit syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 206.999000 MHz
time_init: processor frequency   = 1655.992000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
freeing bootmem node 0
Memory: 3851648k/3883008k available (4928k kernel code, 31360k reserved, 1728k data, 1748k bss, 320k init)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 4096
softlockup thread 0 started up.
Processor 1 found.
softlockup thread 1 started up.
Processor 2 found.
softlockup thread 2 started up.
Processor 3 found.
Brought up 4 CPUs
softlockup thread 3 started up.
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging disabled
mapping IO 3fe00200000 -> d000080000000000, size: 100000
mapping IO 3fe00700000 -> d000080000100000, size: 100000
PCI: Probing PCI hardware done
SCSI subsystem initialized
i/pSeries Real Time Clock Driver v1.1
RTAS daemon started
audit: initializing netlink socket (disabled)
audit(1131572634.103:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpaphp: Slot [0001:00:02.4](PCI location=U787E.001.AAA1978-P2-C1) registered
rpaphp: Slot [0001:00:02.2](PCI location=U787E.001.AAA1978-P2-C2) registered
rpaphp: Slot [0001:00:02.6](PCI location=U787E.001.AAA1978-P2-C3) registered
HVSI: registered 0 devices
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
blk_queue_max_sectors: set to minimum 128
Floppy drive(s): fd0 is 2.88M
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20275: IDE controller at PCI slot 0000:cc:01.0
PDC20275: chipset revision 1
PDC20275: 100% native mode on irq 134
    ide2: BM-DMA at 0xdec00-0xdec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdec08-0xdec0f, BIOS settings: hdg:pio, hdh:pio
hde: IBM DROM00205J1 H0, ATAPI CD/DVD-ROM drive
ide2 at 0xde400-0xde407,0xddc02 on irq 134
hde: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
ipr: IBM Power RAID SCSI Device Driver version: 2.0.14 (May 2, 2005)
ipr 0000:d0:01.0: Found IOA with IRQ: 135
ipr 0000:d0:01.0: Starting IOA initialization sequence.
ipr 0000:d0:01.0: Adapter firmware version: 020A005E
ipr 0000:d0:01.0: IOA initialized.
scsi0 : IBM 570B Storage Adapter
  Vendor: IBM   H0  Model: HUS103014FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM   H0  Model: HUS103014FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM       Model: VSBPD4E2  U4SCSI  Rev: 7134
  Type:   Enclosure                          ANSI SCSI revision: 02
scsi: unknown device type 31
  Vendor: IBM       Model: 570B001           Rev: 0150
  Type:   Unknown                            ANSI SCSI revision: 00
SCSI device sda: 286748000 512-byte hdwr sectors (146815 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 286748000 512-byte hdwr sectors (146815 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:5:0: Attached scsi disk sda
SCSI device sdb: 286748000 512-byte hdwr sectors (146815 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 286748000 512-byte hdwr sectors (146815 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
sd 0:0:8:0: Attached scsi disk sdb
sd 0:0:5:0: Attached scsi generic sg0 type 0
sd 0:0:8:0: Attached scsi generic sg1 type 0
 0:0:15:0: Attached scsi generic sg2 type 13
 0:255:255:255: Attached scsi generic sg3 type 31
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
oprofile: using ppc64/power5 performance monitoring.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 6, 4194304 bytes)
TCP established hash table entries: 1048576 (order: 8, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 320k freed
INIT: version 2.85 booting
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
INIT: PANIC: segmentation violation! sleeping for 30 seconds.



--=-M+4QRc5Z/Kwx1saKQx94--

