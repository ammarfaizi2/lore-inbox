Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTKIVFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTKIVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:05:41 -0500
Received: from continuum.cm.nu ([216.113.193.225]:11664 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S262795AbTKIVF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:05:29 -0500
Date: Sun, 9 Nov 2003 13:05:27 -0800
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: 2.4.23 crash on Intel SDS2
Message-ID: <20031109210527.GA1936@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
X-Delivery-Agent: TMDA/0.86 (Venetian Way)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted some weeks ago regarding a crash I was
experiencing with 2.4.23-pre4.  I am just writing to
confirm that 2.4.23-pre9 is still unable to run relyably on
this machine.  In my earlier post, I thought acpi might be
the culprit as I had it enabled due to a bios bug.  Intel
since fixed that so I was able to boot 2.4.23-pre9 with
acpi totally disabled in make config.

The problem is that after some time, usually between 30
seconds and 15 minutes in, the system locks up.  Nothing
gets printed into the kernel logs or onto the console. 
After 60 seconds, the IPMI watchdog kicks in and reboots
the system.  I run Linux 2.4.22 over here with no problems
with and without acpi.

It's an Intel server board model SDS2 with a dual Pentium
III tualatin 1.13ghz.  I am attaching the dmesg output from
the kernel in case it is helpful but as there is no panics
or oops being printed, I am not sure how best I can help
track this down.  If there is anything further I can do or
any other information needed, let me know.

Shane

Linux version 2.4.23-pre9 (shane@continuum) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Sun Nov 9 12:09:56 PST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 0000000007fc0000 (usable)
BIOS-e820: 0000000007fc0000 - 0000000007fffc00 (ACPI data)
BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
BIOS-e820: 0000000008000000 - 0000000040000000 (usable)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f65d0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
ACPI: RSDP (v000 INTEL                                     ) @ 0x000f65b0
ACPI: RSDT (v001 INTEL    RSDT   0x06040001 MSFT 0x00000000) @ 0x07ffa6e2
ACPI: FADT (v001 INTEL  0268     0x06040001 MSFT 0x01000000) @ 0x07fffb05
ACPI: MADT (v001 INTEL    APIC   0x06040001 MSFT 0x00000000) @ 0x07fffb79
ACPI: BOOT (v001 INTEL  $SBFTBL$ 0x06040001 MSFT 0x00000001) @ 0x07fffbd9
ACPI: DSDT (v001 INTEL  0268     0x06040001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 Pentium(tm) Pro APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: SDS2         APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Enabling APIC mode: Flat.	Using 2 I/O APICs
Processors: 2
Kernel command line: root=/dev/md0 ro
Initializing CPU#0
Detected 1127.945 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2247.88 BogoMIPS
Memory: 1033128k/1048576k available (1431k kernel code, 14800k reserved, 594k data, 112k init, 131072k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.40 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2254.43 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Total of 2 processors activated (4502.32 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-2, 3-4, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
00 003 03  0    0    0   0   0    1    1    31
01 003 03  0    0    0   0   0    1    1    39
02 000 00  1    0    0   0   0    0    0    00
03 003 03  0    0    0   0   0    1    1    41
04 003 03  0    0    0   0   0    1    1    49
05 003 03  0    0    0   1   0    1    1    51
06 003 03  0    0    0   0   0    1    1    59
07 003 03  0    0    0   0   0    1    1    61
08 003 03  0    0    0   0   0    1    1    69
09 003 03  0    0    0   1   0    1    1    71
0a 003 03  0    0    0   1   0    1    1    79
0b 003 03  0    0    0   0   0    1    1    81
0c 003 03  0    0    0   0   0    1    1    89
0d 003 03  0    0    0   0   0    1    1    91
0e 003 03  0    0    0   0   0    1    1    99
0f 003 03  0    0    0   0   0    1    1    A1

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
00 003 03  1    1    0   1   0    1    1    A9
01 003 03  1    1    0   1   0    1    1    B1
02 003 03  1    1    0   1   0    1    1    B9
03 003 03  1    1    0   1   0    1    1    C1
04 000 00  1    0    0   0   0    0    0    00
05 003 03  1    1    0   1   0    1    1    C9
06 003 03  1    1    0   1   0    1    1    D1
07 003 03  1    1    0   1   0    1    1    D9
08 003 03  1    1    0   1   0    1    1    E1
09 000 00  1    0    0   0   0    0    0    00
0a 000 00  1    0    0   0   0    0    0    00
0b 000 00  1    0    0   0   0    0    0    00
0c 000 00  1    0    0   0   0    0    0    00
0d 000 00  1    0    0   0   0    0    0    00
0e 000 00  1    0    0   0   0    0    0    00
0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1127.9277 MHz.
..... host bus clock speed is 132.6969 MHz.
cpu: 0, clocks: 1326969, slice: 442323
CPU0<T0:1326960,T1:884624,D:13,S:442323,C:1326969>
cpu: 1, clocks: 1326969, slice: 442323
CPU1<T0:1326960,T1:442304,D:10,S:442323,C:1326969>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd9d1, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I4,P0) -> 19
PCI->APIC IRQ transform: (B0,I8,P0) -> 23
PCI->APIC IRQ transform: (B0,I9,P0) -> 24
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I8,P0) -> 21
PCI->APIC IRQ transform: (B1,I9,P0) -> 22
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I4,P1) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 146
SvrWks CSB5: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0x2470-0x2477, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0x2478-0x247f, BIOS settings: hdc:pio, hdd:pio
PDC20269: IDE controller at PCI slot 01:09.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
ide2: BM-DMA at 0x2490-0x2497, BIOS settings: hde:pio, hdf:pio
ide3: BM-DMA at 0x2498-0x249f, BIOS settings: hdg:pio, hdh:pio
hda: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
hde: Maxtor 4A250J0, ATA DISK drive
blk: queue c034cf78, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x24b0-0x24b7,0x24aa on irq 22
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 490234752 sectors (251000 MB) w/2048KiB Cache, CHS=30515/255/63, UDMA(133)
Partition check:
hde: hde1
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
<Adaptec aic7899 Ultra160 SCSI adapter>
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
<Adaptec aic7899 Ultra160 SCSI adapter>
aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c1c99018, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Vendor: COMPAQPC  Model: ATLAS10K2-TY092L  Rev: DDC2
Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ff8e18, I/O limit 4095Mb (mask 0xffffffff)
Vendor: COMPAQPC  Model: ATLAS10K2-TY092L  Rev: DDC2
Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ff8c18, I/O limit 4095Mb (mask 0xffffffff)
Vendor: COMPAQPC  Model: ATLAS10K2-TY092L  Rev: DDC2
Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c1c9f218, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
scsi0:A:2:0: Tagged Queuing enabled.  Depth 64
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sda: 17773500 512-byte hdwr sectors (9100 MB)
sda: sda1 sda2 sda3
SCSI device sdb: 17773500 512-byte hdwr sectors (9100 MB)
sdb: sdb1 sdb2 sdb3
SCSI device sdc: 17773500 512-byte hdwr sectors (9100 MB)
sdc: sdc1 sdc2 sdc3
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
[events: 00000177]
[events: 00000177]
[events: 00000177]
md: autorun ...
md: considering sdc2 ...
md:  adding sdc2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2,1>
md: bind<sdb2,2>
md: bind<sdc2,3>
md: running: <sdc2><sdb2><sda2>
md: sdc2's event counter: 00000177
md: sdb2's event counter: 00000177
md: sda2's event counter: 00000177
md0: max total readahead window set to 1536k
md0: 3 data-disks, max readahead per data-disk: 512k
raid0: looking at sda2
raid0:   comparing sda2(8779392) with sda2(8779392)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb2
raid0:   comparing sdb2(8779392) with sda2(8779392)
raid0:   EQUAL
raid0: looking at sdc2
raid0:   comparing sdc2(8779392) with sda2(8779392)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda2 ... contained as device 0
(8779392) is smallest!.
raid0: checking sdb2 ... contained as device 1
raid0: checking sdc2 ... contained as device 2
raid0: zone->nb_dev: 3, size: 26338176
raid0: current zone offset: 8779392
raid0: done.
raid0 : md_size is 26338176 blocks.
raid0 : conf->smallest->size is 26338176 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: sdc2 [events: 00000178]<6>(write) sdc2's sb offset: 8779456
md: sdb2 [events: 00000178]<6>(write) sdb2's sb offset: 8779456
md: sda2 [events: 00000178]<6>(write) sda2's sb offset: 8779456
md: ... autorun DONE.
LVM version 1.0.7(28/03/2003)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 64252k swap-space (priority 1)
Adding Swap: 64252k swap-space (priority 1)
Adding Swap: 64252k swap-space (priority 1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
Real Time Clock Driver v1.10e
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
Hardware receive checksums enabled
cpu cycle saver enabled

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
Hardware receive checksums enabled
cpu cycle saver enabled

Creative EMU10K1 PCI Audio Driver, version 0.20, 12:14:33 Nov  9 2003
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0x2440-0x245f, IRQ 24
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
Uniform CD-ROM driver unloaded
hda: attached ide-scsi driver.
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
Vendor: HL-DT-ST  Model: RW/DVD GCC-4480B  Rev: 1.00
Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf8894000, IRQ 10
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
loop: loaded (max 8 devices)
hub.c: new USB device 00:0f.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0xbc7/0x4) is not claimed by any active driver.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
e100: eth0 NIC Link is Up 100 Mbps Full duplex
e100: eth1 NIC Link is Up 100 Mbps Half duplex
ipmi message handler version v27
IPMI watchdog driver version v27
ipmi_kcs: Acquiring BMC @ port=0xca2
MOXA Smartio family driver version 1.2.1
Tty devices major number = 174, callout devices major number = 175
Found MOXA C168H/PCI series board(BusNo=0,DevNo=8)
