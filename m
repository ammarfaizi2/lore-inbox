Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTLWT3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTLWT3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:29:47 -0500
Received: from mailhub3.state.ma.us ([146.243.12.157]:60043 "EHLO
	mailhub3.state.ma.us") by vger.kernel.org with ESMTP
	id S262321AbTLWT2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:28:23 -0500
Message-Id: <E464D3B1D478D711BFD5009027EE8107052E22@ITD-WNTS-MB7>
From: "Bielecki, Andrew (ITD)" <Andrew.Bielecki@state.ma.us>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: Problem with IRQ routing in 2.6 kernel on HP LH3 server
Date: Tue, 23 Dec 2003 14:27:51 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
I have old HP LH3 dual 400Mhz server which running mandrake Cooker. Any
Kernel 2.4.X works fine on the system but any mandrake 2.6 or compiled
kernel from kernel.org will panic on boot. I narrow the problem to IRQ
routing since all 2.4 kernels will report my megaraid controller on IRQ 9
and Intel EtherPro100 on IRQ 10 when 2.6 kernel reporting them on IRQ 25 and
26 respectively. Are there any lilo switches I can use to make IRQs behave
like under 2.4 kernel.

Andrew Bielecki
Enterprise Network Security
ITD Commonwealth of Massachusetts


Kernel 2.6 boot log:

LILO 22.5.7.2 boot: 260-1ent
Loading 260-1ent.......................................
BIOS data check successful
Linux version 2.6.0-1mdkenterprise (nplanel@no.mandrakesoft.com
<mailto:nplanel@no.mandrakesoft.com> ) (gcc version 3.3.1 (Mandrake Linux
9.2 3.3.1-4mdk)) #1 SMP Thu Dec 18 16:11:28 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 000f69b0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH 3         APIC at: 0xFEE00000
Processor #1 6:5 APIC version 17
Processor #0 6:5 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=260-1ent ro root=801 devfs=mount
console=ttyS0,9600n8 hdc=ide-scsi acpi=off panic=60
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 399.479 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 513052k/524288k available (2078k kernel code, 10488k reserved, 887k
data, 312k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 786.43 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 531k freed
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1464.17 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 796.67 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1583.10 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 399.0262 MHz.
..... host bus clock speed is 99.0815 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 32
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaa7, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f69c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa987, dseg 0x400
pnp: 00:01: ioport range 0xc00-0xc08 has been reserved
pnp: 00:01: ioport range 0xca8-0xcab has been reserved
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x2180-0x218f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:04.3 [8000:803f]
PCI: Address space collision on region 8 of bridge 0000:00:04.3 [2180:219f]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI->APIC IRQ transform: (B0,I7,P0) -> 25
PCI->APIC IRQ transform: (B2,I2,P0) -> 26
vesafb: framebuffer at 0xfc000000, mapped to 0xe0800000, size 1024k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:2994
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
apm: BIOS not found.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au
<mailto:rgooch@atnf.csiro.au> )
devfs: boot_options: 0x1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.3-2003/11/14: looking for picture.... no good signature
found.
Console: switching to colour frame buffer device 100x37
pty: 1024 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported Intel chipset (device id: 7192)
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
hda: CD-ROM CDU611-H, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Console: switching to colour frame buffer device 100x37
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
lirc_dev: IR Remote Control driver registered, at major 61 
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
BIOS EDD facility v0.10 2003-Oct-11, 2 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
<http://domsch.com/linux/edd30/results.html> 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Red Hat nash verSCSI subsystem initialized
sion 3.4.43-mdk megaraid: v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST
2003)
starting
Loadinmegaraid: found 0x8086:0x1960:bus 0:g scsi_mod.ko moslot 7:func 1
dule
Loading mescsi0:Found MegaRAID controller at 0xe0901000, IRQ:25
garaid.ko modulemegaraid: Couldn't register IRQ 25!

Error inserting '/lib/megaraid.ko': -1 No such device
ERROR: /bin/insmod exited abnormally!
Loading sd_mod.ko module
Loading reiserfs.ko module
Mounting /proc filesystem
Creating root device
Mounting root filesystem with flags notail
mount: error 6 mounting reiserfs flags notail
well, retrying without the option flags
mount: error 6 mounting reiserfs
well, retrying read-only without any flag
mount: error 6 mounting reiserfs
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
Remounting devfs at correct place if necessary
Mounted devfs on /dev
Freeing unused kernel memory: 312k freed
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 60 seconds..


kernel 2.4 boot messages:

LILO 22.5.7.2 boot: 
Loading 2422-21ent...................................
BIOS data check successful
Linux version 2.4.22-21mdkenterprise (qateam@updates.mandrakesoft.com
<mailto:qateam@updates.mandrakesoft.com> ) (gcc version 3.3.1 (Mandrake
Linux 9.2 3.3.1-2mdk)) #1 SMP Fri Oct 24 19:48:37 MDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 000f69b0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
DMI not present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH 3         APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2422-21ent ro root=801 devfs=mount
console=ttyS0,9600n8 hdc=ide-scsi acpi=off panic=60
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 399.325 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 509408k/524288k available (1642k kernel code, 10268k reserved,
-2287k data, 176k init, 0k highmem, 0k BadRAM)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au
<mailto:rgooch@atnf.csiro.au> )
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1460.42 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 797.90 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1594.16 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 399.3195 MHz.
..... host bus clock speed is 99.8296 MHz.
cpu: 0, clocks: 998296, slice: 332765
CPU0<T0:998288,T1:665520,D:3,S:332765,C:998296>
cpu: 1, clocks: 998296, slice: 332765
CPU1<T0:998288,T1:332752,D:6,S:332765,C:998296>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfdaa7, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI->APIC IRQ transform: (B0,I7,P0) -> 9
PCI->APIC IRQ transform: (B2,I2,P0) -> 10
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
kinoded started
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au
<mailto:rgooch@atnf.csiro.au> )
devfs: boot_options: 0x1
vesafb: framebuffer at 0xfc000000, mapped to 0xe0800000, size 1024k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:2994
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Looking for splash picture.... no good signature found.
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
hda: CD-ROM CDU611-H, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 500k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Red Hat nash version 3.4.43-mdk SCSI subsystem driver Revision: 1.00
starting
Loadinmegaraid: v1.18j (Release Date: Mon Jul  7 14:39:55 EDT 2003)
g scsi_mod.o modmegaraid: found 0x8086:0x1960:idx 0:bus 0:slot 7:func 1
ule
Loading megscsi0 : Found a MegaRAID controller at 0xe0925000, IRQ: 9
araid.o module
megaraid: [  D :  B ] detected 2 logical drives
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
scsi0 : LSI Logic MegaRAID   D  254 commands 15 targs 5 chans 7 luns
blk: queue c1cca218, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning virtual channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID0 17365R  Rev:   D 
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c1cca018, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: MegaRAID  Model: LD1 RAID5 34708R  Rev:   D 
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c1a00c18, I/O limit 4095Mb (mask 0xffffffff)
scsi0: scanning physical channel 0 for devices.
scsi0: scanning physical channel 1 for devices.
  Vendor: HP        Model: C1537A            Rev: L708
  Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue c19dd018, I/O limit 4095Mb (mask 0xffffffff)
Loading sd_mod.oAttached scsi disk sda at scsi0, channel 0, id 0, lun 0
 module
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35563520 512-byte hdwr sectors (18209 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
SCSI device sdb: 71081984 512-byte hdwr sectors (36394 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
Loading reiserfs.o module
reiserfs journal head cache initialized
Mounting /proc filesystereiserfs: found format "3.6" with standard journal
m
Creating root device
Mounting root filesystem with flags notail
reiserfs: using ordered data mode
reiserfs: checking transaction log (device sd(8,1)) ...
for (sd(8,1))
sd(8,1):Using r5 hash to sort names
Remounting devfs at correct place if necessary
Mounted devfs on /dev
Freeing unused kernel memory: 176k freed
INIT: version 2.85 booting
....


[root@itd-linux-eh3 root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 399.325
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 796.26

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 399.325
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 797.90


[root@itd-linux-eh3 root]# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(AGP disabled) (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at fcd0 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at fce0 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:07.0 PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge] (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 56, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.1 I2O: Intel Corp. 80960RP [i960RP Microprocessor] (rev 03) (prog-if
01)
        Subsystem: Hewlett-Packard Company MegaRAID T5, Integrated HP
NetRAID
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 9
        BIST result: 00
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=32K]

00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 57, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=36
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: 00000000eff00000-00000000eff00000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:0b.0 System peripheral: Hewlett-Packard Company NetServer Smart IRQ
Router (rev a0)
        Subsystem: Hewlett-Packard Company: Unknown device 0001
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]

00:0d.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45) (prog-if 00
[VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fedf7000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

02:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
02)
        Subsystem: Hewlett-Packard Company NetServer 10/100TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at efffe000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ece0 [size=32]
        Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
