Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262533AbTCMSs7>; Thu, 13 Mar 2003 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTCMSs7>; Thu, 13 Mar 2003 13:48:59 -0500
Received: from embedded-zone.com ([208.200.165.105]:3346 "EHLO
	embedded-zone.com") by vger.kernel.org with ESMTP
	id <S262533AbTCMSsg>; Thu, 13 Mar 2003 13:48:36 -0500
Subject: PROBLEM: Linux BootUp hang on CPCR-COP933/DAQ-2010 System
From: Michael Fay <mfay@embedded-zone.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ebXGjnzBbGtfjyyfOCXi"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Mar 2003 14:00:28 -0500
Message-Id: <1047582028.1089.53.camel@technobox.embedded-zone.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ebXGjnzBbGtfjyyfOCXi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Any input into a work around would be greatly appreciated :)

=================================

Problem Summary:
- Linux 2.4.4, 2.4.18 & 2.4.18-rtl3.2-pre1 kernels hang when DAQ-2010
installed in PC system.

Problem Detail: 
- With Linux 2.4.4, 2.4.18 and 2.4.18-rtl3.2pre1 kernels (from
kernel.org & fsmlabs) installed on the PC platform CPCR-COP933, Linux
boots up fine. When the Adlink Tech DAQ-2010 PCI card is installed into
the system boot up hangs.
- The listed Linux kernels were the only kernels tried so the problem
could exist with other kernels as well.
- The problem was found to be independant of kernels with the FSM Real
time extensions or of different kernel compile options.
 ie. same problem for all tried Linux modules.
- The system did boot-up when the RedHat v8.0 linux version was used.

Key words:
- BootUp, kernel,installation, DAQ cards, PCI

Kernel Versions:
- Linux version 2.4.4, 2.4.18, 2.4.18-rtl3.2-pre1

Error Message:
- With the DAQ card installed the last lines displayed before the
systems hangs are: 
           : 
         PIIX4: IDE controller on PCI bus 00 dev f9 
         PIIX4: chipset revision 2 
           ide0: BM-DMA at 0xf000-0xf007, BIOS Settings: hda:DMA,hdb:pio
           ide1: BM-DMA at 0xf008-0xf00f, BIOS Settings: hda:pio,hdb:DMA
         ------ screen hangs here 
                - but we dont really know how far the processor got ----

    If the card hadn't been installed the next lines would be: 
         hda: WDC WD600BB-00CAA1, ATA DISK drive 
         hdd: Memorex 40 MAXX 1248J, ATAPI CD/DVD-ROM drive 
         ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14 
         ide1 at 0x170-0x177, 0x376 on irq 15 
          : etc 

a full dmesg output for 2.4.18-rtl3.2pre1 is attached for when the card
ISN"T installed.

Environment (2.4.18-rtl3.2-pre1)
 - ALL INFO for when card out - not the bootup fault condition
Software:
        Linux technobox.embedded-zone.com 2.4.18-rtl3.2-pre1#3 
        Mon Feb 10 11:19:16 EST 2003 i686 i686 i386 GNU/Linux

        Gnu C  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) 
        Copyright (C) 2002 Free Software Foundation, Inc. This is free
        software; see the source for copying conditions. There is NO
        warranty; not even for MERCHANTABILITY or FITNESS FOR A
        PARTICULAR PURPOSE.
        Gnu make               3.79.1
        util-linux             2.11r
        mount                  2.11r
        modutils               2.4.18
        e2fsprogs              1.27
        pcmcia-cs              3.1.31
        PPP                    2.4.1
        isdn4k-utils           3.1pre4
        Linux C Library        2.2.93
        Dynamic linker (ldd)   2.2.93
        Procps                 2.0.7
        Net-tools              1.60
        Kbd                    1.06
        Sh-utils               2.0.12
        Modules Loaded         i810_audio agpgart rtl_sched rtl_fifo
                               rtl_posixio rtl_time rtl mbuff eepro100
                               mousedev keybdev hid input

Processor information:
       processor       : 0
       vendor_id       : GenuineIntel
       cpu family      : 6
       model           : 8
       model name      : Pentium III (Coppermine)
       stepping        : 10
       cpu MHz         : 930.330
       cache size      : 256 KB
       fdiv_bug        : no
       hlt_bug         : no
       f00f_bug        : no
       coma_bug        : no
       fpu             : yes
       fpu_exception   : yes
       cpuid level     : 2
       wp              : yes
       flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge
                         mca cmov pat pse36 mmx fxsr sse
       bogomips        : 1830.91

Module information
       i810_audio             23528   0 (autoclean)
       agpgart                33228   4 (autoclean)
       rtl_sched              29312   0 (unused)
       rtl_fifo               10848   0 (unused)
       rtl_posixio             7828   0 [rtl_fifo]
       rtl_time                6768   0 [rtl_sched rtl_posixio]
       rtl                    20112   0 [rtl_sched rtl_fifo rtl_posixio
                                         rtl_time]
       mbuff                   6828   0 (unused)
       eepro100               19416   1
       mousedev                4888   1
       keybdev                 2400   0 (unused)
       hid                    14664   0 (unused)
       input                   5472   0 [mousedev keybdev hid]

Loaded driver and hardware information
       0000-001f : dma1
       0020-003f : pic1 
       0040-005f : timer
       0060-006f : keyboard
       0080-008f : dma page reg
       00a0-00bf : pic2
       00c0-00df : dma2
       00f0-00ff : fpu
       01f0-01f7 : ide0
       02f8-02ff : serial(auto)
       03c0-03df : vga+
       03f6-03f6 : ide0
       03f8-03ff : serial(auto)
       0cf8-0cff : PCI conf1
       5000-500f : Intel Corp. 82801AA SMBus
       c000-cfff : PCI Bus #01
       c000-c03f : Intel Corp. 82557 [Ethernet Pro 100]
       c000-c03f : eepro100
       c400-c43f : Intel Corp. 82557 [Ethernet Pro 100] (#2)
       c400-c43f : eepro100
       d800-d8ff : Intel Corp. 82801AA AC'97 Audio
       d800-d8ff : Intel ICH 82801AA
       dc00-dc3f : Intel Corp. 82801AA AC'97 Audio
       dc00-dc3f : Intel ICH 82801AA
       f000-f00f : Intel Corp. 82801AA IDE
       f000-f007 : ide0

       00000000-0009fbff : System RAM
       0009fc00-0009ffff : reserved
       000a0000-000bffff : Video RAM area
       000c0000-000c7fff : Video ROM
       000f0000-000fffff : System ROM
       00100000-0fefffff : System RAM
       00100000-0024b10e : Kernel code
       0024b10f-002b1e93 : Kernel data 
       e0000000-e3ffffff : Intel Corp. 82810E CGC [Chipset Graphics
                           Controller]
       e4000000-e5ffffff : PCI Bus #01
       e5000000-e50fffff : Intel Corp. 82557 [Ethernet Pro 100]
       e5100000-e51fffff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
       e5200000-e5200fff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
       e5200000-e5200fff : eepro100
       e5201000-e5201fff : Intel Corp. 82557 [Ethernet Pro 100]
        5201000-e5201fff : eepro100
       e6000000-e607ffff : Intel Corp. 82810E CGC [Chipset Graphics
                           Controller]
       ffb00000-ffffffff : reserved

Interrupts:
           CPU0
       0:    5010829  RTLinux virtual irq  timer
       1:      18517  RTLinux virtual irq  keyboard
       2:          0  RTLinux virtual irq  cascade
      11:      36370  RTLinux virtual irq  eth0
      12:     114167  RTLinux virtual irq  PS/2 Mouse
      14:      24860  RTLinux virtual irq  ide0
      15:     108223  RTLinux virtual irq  Intel ICH 82801AA
     221:          0  RTLinux virtual irq  RTLinux Scheduler
     222:          0  RTLinux virtual irq  RTLinux FIFO
     223:          0  RTLinux virtual irq  RTLinux printf
     NMI:          0
     ERR:          0

PCI Devices:
    Bus  0, device   0, function  0:
         Host bridge: Intel Corp. 82810E GMCH [Graphics Memory
         Controller Hub] (rev 3).
    Bus  0, device   1, function  0:
         VGA compatible controller: Intel Corp. 82810E CGC 
         [Chipset Graphics Controller] (rev 3).
         IRQ 10.
         Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
         Non-prefetchable 32 bit memory at 0xe6000000 [0xe607ffff].
    Bus  0, device  30, function  0:
         PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
         Master Capable.  No bursts.  Min Gnt=6.
    Bus  0, device  31, function  0:
         ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 2).
    Bus  0, device  31, function  1:
         IDE interface: Intel Corp. 82801AA IDE (rev 2).
         I/O at 0xf000 [0xf00f].
    Bus  0, device  31, function  3:
         SMBus: Intel Corp. 82801AA SMBus (rev 2).
         IRQ 15.
         I/O at 0x5000 [0x500f].
   Bus  0, device  31, function  5:
         Multimedia audio controller: Intel Corp. 82801AA AC'97 
         Audio (rev 2).
         IRQ 15.
         I/O at 0xd800 [0xd8ff].
         I/O at 0xdc00 [0xdc3f].
   Bus  1, device  10, function  0:
         Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100]rev 8.
         IRQ 11.
         Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
         Non-prefetchable 32 bit memory at 0xe5201000 [0xe5201fff].
         I/O at 0xc000 [0xc03f].
         Non-prefetchable 32 bit memory at 0xe5000000 [0xe50fffff].
  Bus  1, device  11, function  0:
         Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] 
         (#2) (rev 8).
         IRQ 15.
         Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
         Non-prefetchable 32 bit memory at 0xe5200000 [0xe5200fff].
         I/O at 0xc400 [0xc43f].
         Non-prefetchable 32 bit memory at 0xe5100000 [0xe51fffff].
SCSI Devices: None




--=-ebXGjnzBbGtfjyyfOCXi
Content-Disposition: attachment; filename=rtlinux.cardout.dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=rtlinux.cardout.dmesg; charset=UTF-8

Linux version 2.4.18-rtl3.2-pre1 (root@localhost.localdomain) (gcc version =
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Mon Feb 10 11:19:16 ES=
T 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff00000 (usable)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
On node 0 totalpages: 65280
zone(0): 4096 pages.
zone(1): 61184 pages.
zone(2): 0 pages.
Kernel command line: ro root=3D/dev/hda2 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 930.470 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1830.91 BogoMIPS
Memory: 254468k/261120k available (1324k kernel code, 6264k reserved, 411k =
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA
hda: WDC WD600BB-00CAA1, ATA DISK drive
hdd: Memorex 40MAXX 1248AJ, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=3D7297/255/63, UDMA(=
33)
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
es1371: version v0.30 time 21:30:35 Feb  6 2003
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 9 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
Adding Swap: 522104k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 01:0a.0
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:08:9B:0D:39:21, IRQ 10.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PCI: Found IRQ 11 for device 01:0b.0
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
eth1: Intel Corp. 82557 [Ethernet Pro 100] (#2), 00:08:9B:0D:39:22, IRQ 11.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: 0 multicast blocks dropped.
mbuff: kernel shared memory driver v0.7.2 for Linux 2.4.18-rtl3.2-pre1
mbuff: (C) Tomasz Motylewski et al., GPL
mbuff: registered as MISC device minor 254
RTLinux Extensions Loaded (http://www.fsmlabs.com/)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected an Intel i810 E Chipset.
agpgart: AGP aperture is 64M @ 0xe0000000
memory : cfef6e20
memory : 00000000
memory : cfef6e60
Intel 810 + AC97 Audio, version 0.21, 21:34:48 Feb  6 2003
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 01:0b.0
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0xdc00 and 0xd800, IRQ 11
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
i810_audio: AC'97 codec 0 supports AMAP, total channels =3D 2
i810_audio: setting clocking to 48813
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)

--=-ebXGjnzBbGtfjyyfOCXi--

