Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTJZLzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJZLzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:55:17 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:3157 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S263102AbTJZLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:55:01 -0500
Message-ID: <3F9BC429.6060608@planet.nl>
Date: Sun, 26 Oct 2003 13:55:05 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Heavy disk activity without apperant reason (added more info)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my AMD athlon system with 512MB memory I sometimes get a lot of disk 
activity the activity normaly lasts for about 10 seconds and after that 
the disk stays relativily quiet as expected with the load on the system. 
When I look into top I don't see any programs that could explain the 
disk activity. The system is in most cases not using any swap.

The system configuration is as following.

Software
Slackware 8.0
glibc 2.3.1
gcc 3.3.1
kernel 2.6.0-test9
all the needed software updates to run 2.5 and 2.6 kernels

AMD athlon 1400
512MB main mem
18GB scsi disk 10K
29160 adaptec scsi controller
using a via kt2666 chipset

Disk setup

bash-2.05$ cat /etc/fstab
/dev/sda1       /        ext2        defaults        1  1
/dev/sda6       /squid   reiserfs    defaults        1  1
/dev/sda5       /home    reiserfs    defaults        1  1
/dev/sda7       none     swap        defaults        0  0
/dev/sda8       /usr     reiserfs    defaults        1  1
none            /dev/pts devpts      gid=5,mode=620  0  0
none            /proc    proc        defaults        0  0
none            /proc/bus/usb  usbfs  defaults  0  0
/dev/hda5       /music   ext2        defaults        1  1

dmesg

bash-2.05# dmesg
Linux version 2.6.0-test9 (root@made0120) (gcc version 3.3.2) #18 Sat 
Oct 25 23:05:26 CEST 2003
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
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=801
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1402.029 MHz processor.
Console: colour VGA+ 80x25
Memory: 514988k/524224k available (2153k kernel code, 8488k reserved, 
635k data, 344k init, 0k highmem)
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xe0816000, 00:e0:4c:3b:5d:84, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:pio, hdd:DMA
hda: WDC WD205BA, ATA DISK drive
hdb: AOpen 12xDVD-ROM DRIVE 10172000, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: OnStream DI-30, ATAPI TAPE drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
 hda: hda1 hda4 < hda5 hda6 >
hdb: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-tape: hdd <-> ht0: OnStream DI-30 rev 1.09
ide-tape: hdd <-> ht0: Tape length 14429MB (19239 frames/track, 24 
tracks = 461736 blocks, density: 64Kbpi)
ide-tape: hdd <-> ht0: 990KBps, 64*32kB buffer, 10208kB pipeline, 62ms 
tDSC, DMAscsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
 
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V_18_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 35861388 512-byte hdwr sectors (18361 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: PS2++ Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0xd800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 344k freed
Adding 136512k swap on /dev/sda7.  Priority:-1 extents:1
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda6, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda6) for (sda6)
reiserfs: replayed 8 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda5, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda5) for (sda5)
reiserfs: replayed 12 transactions in 1 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda8, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda8) for (sda8)
reiserfs: replayed 7 transactions in 1 seconds
Using r5 hash to sort names
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1


I'm not sure if I should log a bug and what the problem area could be.

Thanks in advance for helping out,

Stef
