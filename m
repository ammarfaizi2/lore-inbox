Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIYTYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbTIYTYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:24:22 -0400
Received: from devil.servak.biz ([209.124.81.2]:40674 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261352AbTIYTYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:24:06 -0400
Subject: Oops at boot with SMP, RAID5, 2.6.0-test5-mm4
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064517840.18499.29.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 12:24:01 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first time I've tried to start a 2.6 kernel on this machine 
- dual P3 800, 512 MB, Tyan MB, Promise & onboard VIA IDE controllers

The machine has been stable for a long time using Red Hat 9's latest
kernel.  This was captured via serial console.

Happy to provide more information if it would be helpful...

Linux version 2.6.0-test5-mm4 (thoffman@rivendell.arnor.net) (gcc
version 3.2.2 20030222 (Red Hat Linux3
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5940
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda1 console=tty0
console=ttyS1,57600n8
current: c0333b00
current->thread_info: c03aa000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 800.090 MHz processor.
Console: colour VGA+ 80x25
Memory: 515104k/524224k available (1932k kernel code, 8372k reserved,
789k data, 180k init, 0k highmem)
Calibrating delay loop... 1437.69 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.19 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1638.40 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3076.09 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 799.0486 MHz.
..... host bus clock speed is 133.0247 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
zapping low mappings.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbcc0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbcf0, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 0000:00:07.0
PCI: No IRQ known for interrupt pin A of device 0000:01:00.0. Probably
buggy MP table.
aty128fb: Rage128 BIOS located at d8000000
aty128fb: Rage128 RF (AGP) [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 RF (AGP)
aty128fb: Rage128 MTRR set to ON
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized r128 2.5.0 20030725 on minor 0
[drm] Initialized mga 3.1.0 20021029 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 4G120J6, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:00:14.0
PDC20268: chipset revision 1
PDC20268: 100% native mode on irq 11
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 4W060H4, ATA DISK drive
hdf: Maxtor 4W060H4, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xe002 on irq 11
hdg: Maxtor 4W060H4, ATA DISK drive
hdh: Maxtor 4W060H4, ATA DISK drive
ide3 at 0xe400-0xe407,0xe802 on irq 11
hda: max request size: 1024KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(66)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hde: max request size: 128KiB
hde: Host Protected Area detected.
        current capacity is 117347328 sectors (60081 MB)
        native  capacity is 120103200 sectors (61492 MB)
hde: 117347328 sectors (60081 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hde: hde1
hdf: max request size: 128KiB
hdf: Host Protected Area detected.
        current capacity is 117347328 sectors (60081 MB)
        native  capacity is 120103200 sectors (61492 MB)
hdf: 117347328 sectors (60081 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdf: hdf1
hdg: max request size: 128KiB
hdg: Host Protected Area detected.
        current capacity is 117347328 sectors (60081 MB)
        native  capacity is 120103200 sectors (61492 MB)
hdg: 117347328 sectors (60081 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdg: hdg1
hdh: max request size: 128KiB
hdh: Host Protected Area detected.
        current capacity is 117347328 sectors (60081 MB)
        native  capacity is 120103200 sectors (61492 MB)
hdh: 117347328 sectors (60081 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdh: hdh1
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1188.000 MB/sec
   8regs_prefetch:   952.000 MB/sec
   32regs    :   532.000 MB/sec
   32regs_prefetch:   524.000 MB/sec
   pIII_sse  :  1296.000 MB/sec
   pII_mmx   :  1632.000 MB/sec
   p5_mmx    :  1736.000 MB/sec
raid5: using function: pIII_sse (1296.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdh1 ...
md:  adding hdh1 ...
md:  adding hdg1 ...
md:  adding hdf1 ...
md:  adding hde1 ...
md:  adding hda3 ...
md: created md0
md: bind<hda3>
md: bind<hde1>
md: bind<hdf1>
md: bind<hdg1>
md: bind<hdh1>
md: running: <hdh1><hdg1><hdf1><hde1><hda3>
md: md0: raid array is not clean -- starting background reconstruction
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0283f02
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c0283f02>]    Not tainted VLI
EFLAGS: 00010286
EIP is at md_probe+0x12/0xf0
eax: 00000000   ebx: dfd3ebe0   ecx: dfd41a80   edx: 00000000
esi: dfd41a8c   edi: dfd41a8c   ebp: c152fd8c   esp: c152fd74
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c152e000 task=c152d900)
Stack: dfd41a8c c152fd8c c0149661 dfd3ebe0 dfd41a8c dfd41a8c c152fddc
c0284192
       00000000 00000000 00000000 c152fdb8 00000282 00000400 00000004
c03e0fe1
       00000246 c152fddc c0124d93 0000000a 00000400 c0300fe1 c152fde8
dfd3ebe0
Call Trace:
 [<c0149661>] invalidate_inode_pages+0x21/0x30
 [<c0284192>] do_md_run+0x192/0x470
 [<c0124d93>] printk+0x143/0x1c0
 [<c02847af>] autorun_array+0x9f/0xd0
 [<c0124d93>] printk+0x143/0x1c0
 [<c0284a0a>] autorun_devices+0x22a/0x270
 [<c0124d93>] printk+0x143/0x1c0
 [<c028791a>] autostart_arrays+0x2a/0xc6
 [<c0164384>] do_open+0x114/0x3f0
 [<c0163cf0>] bdev_test+0x0/0x20
 [<c0163d10>] bdev_set+0x0/0x20
 [<c0285dfc>] md_ioctl+0x74c/0x790
 [<c015afbc>] dentry_open+0x13c/0x1f0
 [<c015ae76>] filp_open+0x66/0x70
 [<c023a127>] blkdev_ioctl+0xa7/0x447
 [<c016e295>] sys_ioctl+0xf5/0x271
 [<c03ae9d1>] md_run_setup+0x71/0xa0
 [<c03ad1d1>] prepare_namespace+0x11/0x110
 [<c01349d2>] init_workqueues+0x12/0x29
 [<c01070f1>] init+0x51/0x150
 [<c01070a0>] init+0x0/0x150
 [<c010b27d>] kernel_thread_helper+0x5/0x18
                                                                                                        
Code: 0d ea ff 89 34 24 e8 7e f5 ff ff e9 34 ff ff ff 89 75 cc e9 c4 fe
ff ff 90 55 89 e5 83 ec 18 89 7
 <0>Kernel panic: Attempted to kill init!


-- 
Torrey Hoffman <thoffman@arnor.net>

