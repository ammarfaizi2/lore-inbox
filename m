Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318779AbSIDBjE>; Tue, 3 Sep 2002 21:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318770AbSIDBjE>; Tue, 3 Sep 2002 21:39:04 -0400
Received: from rom.cscaper.com ([216.19.195.129]:5029 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S318758AbSIDBi5>;
	Tue, 3 Sep 2002 21:38:57 -0400
Subject: Re: CRH  Out of Town
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Tue, 3 Sep 2002 18:45 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020904013857Z318758-685+42497@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Folks,

I am trying to determine the cause of the poor performance of a
an IDE DVD device on my new machine.  I have an IDE Panasonic DF-210-type
DVD-RAM/R/ROM in a new machine with Soyo KT333 motherboard.  It
transfers data slowly (below DVD speed), consumes large amounts of
system time, and slows down the user interface and even system
clock (which can run as slow as 1/4 speed while the drive is
going).

The interrupt ERR count below seems to be mostly related to use
of the DVD drive.

Maybe it's something simple.  If not, I'll be glad to do further
work to help diagnose the problem.

Here are some possibly relevant details:

# uname -a
Linux dhcppc4 2.4.20-pre5-ac1 #4 Sun Sep 1 22:06:11 PDT 2002 i686 unknown

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2100+
stepping        : 2
cpu MHz         : 1729.054
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3447.19

# cat /proc/interrupts
           CPU0
  0:    2389082          XT-PIC  timer
  1:          4          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        107          XT-PIC  usb-uhci
  8:    1293953          XT-PIC  rtc
 10:          0          XT-PIC  usb-uhci
 11:     124849          XT-PIC  eth0, EMU10K1
 12:      46058          XT-PIC  usb-uhci, usb-uhci, ehci-hcd, cmpci
 14:      56020          XT-PIC  ide0
 15:          7          XT-PIC  ide1
NMI:          0
LOC:    2388955
ERR:        927
MIS:          0

# dmesg | more

Linux version 2.4.20-pre5-ac1 (root@dhcppc4) (gcc version 2.96 20000731 (Red Hat
 Linux 7.3 2.96-110)) #4 Sun Sep 1 22:06:11 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
 BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
 BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393200
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 163824 pages.
Kernel command line: auto BOOT_IMAGE=2.4.20.p5ac1 ro root=305 BOOT_FILE=/boot/vm
linuz-2.4.20-pre5-ac1 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1729.054 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3447.19 BogoMIPS
Memory: 1548660k/1572800k available (1116k kernel code, 23756k reserved, 464k da
ta, 136k init, 655296k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=193582 max_file_pages=0 max_inodes=0 max_dentries=193582
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1729.0935 MHz.
..... host bus clock speed is 266.0142 MHz.
cpu: 0, clocks: 2660142, slice: 1330071
CPU0<T0:2660128,T1:1330048,D:9,S:1330071,C:2660142>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router default [1106/3099] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SER
IAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT372: IDE controller at PCI slot 00:0f.0
HPT372: chipset revision 5
HPT372: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=bi
osirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JB-00CRA1, ATA DISK drive
hdb: WDC WD1200JB-00CRA1, ATA DISK drive
hdc: ASUS CRW-4816A, ATAPI CD/DVD-ROM drive
hdd: MATSHITADVD-RAM LF-D310, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63, UDMA(100)
hdb: host protected area => 1
hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdb: hdb1 hdb2 < hdb5 hdb6 >
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
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 119k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
Adding Swap: 1052248k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 21:01:49 Sep  1 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xc000, IRQ 5
usb-uhci.c: Detected 2 ports

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   8, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 7).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xb000 [0xb01f].
  Bus  0, device   8, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 7).
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb407].
  Bus  0, device   9, function  0:
    FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 70).
      IRQ 5.
      Master Capable.  Latency=32.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xef002000 [0xef0027ff].
      I/O at 0xb800 [0xb87f].
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xbc00 [0xbcff].
      Non-prefetchable 32 bit memory at 0xef000000 [0xef0000ff].
  Bus  0, device  14, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 80).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc01f].
  Bus  0, device  14, function  1:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 80).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xc400 [0xc41f].
  Bus  0, device  17, function  2:
    USB Controller: VIA Technologies, Inc. USB (#3) (rev 35).
      IRQ 12.
      Master Capable.  Latency=32.
      I/O at 0xe400 [0xe41f].
  Bus  0, device  17, function  3:
    USB Controller: VIA Technologies, Inc. USB (#4) (rev 35).
      IRQ 12.
      Master Capable.  Latency=32.
      I/O at 0xe800 [0xe81f].
  Bus  0, device  14, function  2:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 81).
      IRQ 12.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xef001000 [0xef0010ff].
  Bus  0, device  15, function  0:
    RAID bus controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 5).
      IRQ 10.
      Master Capable.  Latency=120.  Min Gnt=8.Max Lat=8.
      I/O at 0xc800 [0xc807].
      I/O at 0xcc00 [0xcc03].
      I/O at 0xd000 [0xd007].
      I/O at 0xd400 [0xd403].
      I/O at 0xd800 [0xd8ff].
  Bus  0, device  16, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xdc00 [0xdcff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xe000 [0xe00f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon 8500 DV (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xed100000 [0xed11ffff].
      Non-prefetchable 32 bit memory at 0xed120000 [0xed12ffff].
  Bus  1, device   0, function  1:
    PCI bridge: PCI device 1002:4243 (ATI Technologies Inc) (rev 0).
      Master Capable.  Latency=32.  Min Gnt=2.
  Bus  2, device   0, function  0:
    FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 4).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xed000000 [0xed000fff].


# hdparm /dev/hdd
/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  0 (off)
 BLKRAGET failed: Invalid argument
 HDIO_GETGEO failed: Invalid argument
 busstate     =  1 (on)

# cat /proc/ide/hdd/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           66              0               70              rw
ide-scsi                0               0               1               rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               1               0               1               rw
using_dma               0               0               1               rw

# cat /proc/ide/hdd/model
MATSHITADVD-RAM LF-D310



