Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSHLGxl>; Mon, 12 Aug 2002 02:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSHLGxk>; Mon, 12 Aug 2002 02:53:40 -0400
Received: from dsl-64-130-67-157.telocity.com ([64.130.67.157]:10627 "EHLO
	shorty.nokleberg.com") by vger.kernel.org with ESMTP
	id <S315449AbSHLGxg>; Mon, 12 Aug 2002 02:53:36 -0400
Date: Sun, 11 Aug 2002 23:57:21 -0700
From: Chris Nokleberg <chris@sixlegs.com>
To: linux-kernel@vger.kernel.org
Subject: [chris@sixlegs.com: PROBLEM: Unable to read superblock in 2.4.19]
Message-ID: <20020812065721.GH4411@shorty>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Face: "Y3=wB%rbO-.>w\AACMy!\VHWOC%Vt5cUv9>/6MF"uiS"(G`*Y@?j#~V_J1D<=:#'Zm{@A~nD`sBK=zwf.}NJLtj88h4j*dq3iVSrgE[@2vXEH]>($R)c<GO/HLukN#a2&K}#wsql'DL-l<~s[G>6t{2u#MsZB&hU~5ab7>F0Wu%Q`ZSd:[}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent this to bugs@linux-ide.org a few days ago but I'm not sure if
that goes anywhere.

Chris

--VbJkn9YxBvnuCH5J
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sat, 10 Aug 2002 13:05:16 -0700
From: Chris Nokleberg <chris@sixlegs.com>
To: bugs@linux-ide.org
Subject: PROBLEM: Unable to read superblock in 2.4.19
Message-ID: <20020810200516.GA214@shorty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Face: "Y3=wB%rbO-.>w\AACMy!\VHWOC%Vt5cUv9>/6MF"uiS"(G`*Y@?j#~V_J1D<=:#'Zm{@A~nD`sBK=zwf.}NJLtj88h4j*dq3iVSrgE[@2vXEH]>($R)c<GO/HLukN#a2&K}#wsql'DL-l<~s[G>6t{2u#MsZB&hU~5ab7>F0Wu%Q`ZSd:[}

I get a kernel panic when using 2.4.19. It works fine with 2.4.18. I
configured 19 using "make oldconfig" and accepted the defaults for all
of the new parameters.

The console output looks almost exactly like this (hand-typed, is
there a better way?):

hda3: bad access: block=2, count=2
end_request: I/O error, dev 03:03 (hda), sector 2
EXT3-fs: unable to read superblock
hda3: bad access: block=2, count=2
end_request: I/O error, dev 03:03 (hda), sector 2
EXT3-fs: unable to read superblock
hda3: bad access: block=64, count=2
end_request: I/O error, dev 03:03 (hda), sector 64
EXT3-fs: unable to read superblock
isofs_read_super: bread failed, dev=03:03, iso_blknum=16, block=32
Kernel panic: VFS: Unable to mount root fs on 03:03

I do have a RAID1 array but it is for /home, not /.

Thanks,
Chris

p.s. on which mailing list is ide development discussed?

------------------------------

/proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1700+
stepping        : 2
cpu MHz         : 1466.460
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse \
syscall mmxext 3dnowext 3dnow
bogomips        : 2922.90

------------------------------

/proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0778-077a : parport0
0cf8-0cff : PCI conf1
c800-c81f : VIA Technologies, Inc. UHCI USB
  c800-c81f : usb-uhci
cc00-cc1f : VIA Technologies, Inc. UHCI USB (#2)
  cc00-cc1f : usb-uhci
d000-d01f : VIA Technologies, Inc. UHCI USB (#3)
  d000-d01f : usb-uhci
d400-d4ff : VIA Technologies, Inc. AC97 Audio Controller
d800-d8ff : Lite-On Communications Inc LNE100TX
  d800-d8ff : tulip
dc00-dc3f : Promise Technology, Inc. 20265
  dc00-dc07 : ide2
  dc08-dc0f : ide3
  dc10-dc3f : PDC20265
e000-e003 : Promise Technology, Inc. 20265
  e002-e002 : ide3
e400-e407 : Promise Technology, Inc. 20265
  e400-e407 : ide3
e800-e803 : Promise Technology, Inc. 20265
  e802-e802 : ide2
ec00-ec07 : Promise Technology, Inc. 20265
  ec00-ec07 : ide2
fc00-fc0f : VIA Technologies, Inc. Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

------------------------------

Some info on the drive from /proc

disk
ST340016A
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                4865            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           0               0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              0               0               69              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      127             1               127             rw
multcount               8               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

------------------------------

ver_linux:

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.27
Linux C Library        2.5.so*
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         parport_pc lp parport

------------------------------

dmesg output for a successful boot (2.4.18):

Linux version 2.4.18 (root@shorty) (gcc version 2.95.3 20010315 (release)) #2 Sat Aug 10 11:38:45 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Kernel command line: BOOT_IMAGE=2.4.18 ro root=303 pci=biosirq
Initializing CPU#0
Detected 1466.460 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2922.90 BogoMIPS
Memory: 1029148k/1048512k available (1559k kernel code, 18976k reserved, 517k data, 224k init, 131008k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router default [1106/3074] at 00:11.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1, 8 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: chipset revision 2
ide: Found promise 20265 in RAID mode.
PDC20265: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdc: CD-ROM 40X/AKU, ATAPI CD/DVD-ROM drive
hdd: IC35L040AVER07-0, ATA DISK drive
hde: ST360021A, ATA DISK drive
hdg: ST360021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xec00-0xec07,0xe802 on irq 10
ide3 at 0xe400-0xe407,0xe002 on irq 10
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
hdd: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63
hdg: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdd: [PTBL] [5005/255/63] hdd1 hdd2 hdd3
 hde: hde1
 hdg: hdg1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xd800, 00:C0:F0:2D:90:B3, IRQ 12.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 1
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 11:40:04 Aug 10 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF f7e7d780, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7e7d780
usb.c: call_policy add, num 1 -- no FS yet
usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 12
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2 enable change, status 100
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF f7e7d980, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: cc00
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7e7d980
usb.c: call_policy add, num 1 -- no FS yet
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 12
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2 enable change, status 100
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF f7e7db80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: c800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7e7db80
usb.c: call_policy add, num 1 -- no FS yet
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2240.000 MB/sec
   32regs    :  1982.000 MB/sec
   pIII_sse  :  1875.200 MB/sec
   pII_mmx   :  3433.200 MB/sec
   p5_mmx    :  4393.600 MB/sec
raid5: using function: pIII_sse (1875.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
md: Autodetecting RAID arrays.
hub.c: port 1 enable change, status 100
hub.c: port 2 enable change, status 100
 [events: 0000003c]
 [events: 0000003c]
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: hdg1's event counter: 0000003c
md: hde1's event counter: 0000003c
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdg1 operational as mirror 1
raid1: device hde1 operational as mirror 0
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdg1 [events: 0000003d]<6>(write) hdg1's sb offset: 58615552
md: hde1 [events: 0000003d]<6>(write) hde1's sb offset: 58615552
md: ... autorun DONE.
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 506008k swap-space (priority 1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Disk change detected on device ide1(22,0)
eth0: Setting full-duplex based on MII#1 link partner capability of 05e1.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
lp0: using parport0 (interrupt-driven).
lp0: ECP mode

--VbJkn9YxBvnuCH5J--
