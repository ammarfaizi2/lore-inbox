Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAEIpm>; Fri, 5 Jan 2001 03:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEIpd>; Fri, 5 Jan 2001 03:45:33 -0500
Received: from president.eu.org ([194.45.71.67]:63495 "EHLO president.eu.org")
	by vger.kernel.org with ESMTP id <S129183AbRAEIpW>;
	Fri, 5 Jan 2001 03:45:22 -0500
Date: Fri, 5 Jan 2001 09:45:04 +0000
From: Hans Freitag <macrotron@president.eu.org>
To: linux-kernel@vger.kernel.org
Subject: System Crash Kernel 2.4.0-test12 and 2.4.0-pre with XFree 4.0.2
Message-ID: <20010105094504.C398@BOFH.president.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Ident: 204D1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


[1.] One line summary of the problem:    
   my System hangs up if I have a high load and if I use XFree.

[2.] Full description of the problem/report:

I'm using XFree 4.0.2 on a Vodoo3 2000 Graphics Board.
If I'm booting 2.4.0-test10 it works fine.
If I'm booting 2.4.0-test12 or pre my System Crashes if 
I use multimedia applications like gkrellm, mtv, xmms
and do some downloads.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.0 test12 pre crash XFree Vodoo 

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-prerelease (root@BOFH) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Thu Jan 4 20:41:18 /etc/localtime 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
          problem (if possible)

wget -c -r ftp.kernel.org &
wget -c -r blafasel.lan &
mtv test.mpg &
gkrellm 

( just wait and work :-) )

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 350.803
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 699.59


[7.3.] Module information (from /proc/modules):
cs4232                  3024   1
ad1848                 17216   0 [cs4232]
uart401                 6448   0 [cs4232]
sound                  57616   1 [cs4232 ad1848 uart401]
soundcore               3952   4 [sound]
bttv                   56848   0 (unused)
msp3400                13328   0 (unused)
tuner                   3280   1
i2c-algo-bit            7232   1 [bttv]
i2c-dev                 3904   0 (unused)
i2c-core               12656   0 [bttv msp3400 tuner i2c-algo-bit i2c-dev]
videodev                4576   2 [bttv]



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:

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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0340-035f : eth1
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0530-0533 : Crystal audio controller
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, Inc. Voodoo 3
  e000-e00f : VIA Technologies, Inc. Bus Master IDE
    e000-e007 : ide0
      e008-e00f : ide1
      e800-e8ff : Macronix, Inc. [MXIC] MX987x5
        e800-e8ff : eth0
	

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-002fe60f : Kernel code
    002fe610-0031c983 : Kernel data
    07ff0000-07ff2fff : ACPI Non-volatile Storage
    07ff3000-07ffffff : ACPI Tables
    e0000000-e3ffffff : PCI Bus #01
      e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
      e4000000-e5ffffff : PCI Bus #01
        e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
	e6000000-e6ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
	e8000000-e80000ff : Macronix, Inc. [MXIC] MX987x5
	  e8000000-e80000ff : eth0
	  e8001000-e8001fff : Brooktree Corporation Bt848 TV with DMA push
	    e8001000-e8001fff : bttv
	    ffff0000-ffffffff : reserved
	    


[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x32      Rev: 1.10
    Type:   CD-ROM                           ANSI SCSI revision: 02
    

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

dmesg:

Linux version 2.4.0-prerelease (root@BOFH) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Thu Jan 4 20:41:18 /etc/localtim
e 2001
BIOS-provided physical RAM map:
BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=linux ro root=302 hdc=ide-scsi ether=0,0x340,eth1 ether=0,0xe800,eth0 idebus=66
ide_setup: hdc=ide-scsi
ide_setup: idebus=66
Initializing CPU#0
Detected 350.803 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 699.59 BogoMIPS
Memory: 125760k/131008k available (2041k kernel code, 4860k reserved, 120k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: Device 00:3b not found by BIOS
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Card 'CS4236'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
34 structures occupying 849 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 06/16/98
System Vendor: VIA Technologies, Inc..
Product Name: VT82C597.
Version  .
Serial Number  .
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=00 devrev=21 oldid=0c
Winbond chip type 83877TF
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD136AA, ATA DISK drive
hdb: SAMSUNG SV4084D, ATA DISK drive
hdc: R/RW 4x4x32, ATAPI CDROM drive
hdd: HITACHI CDR-7930, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=26354/16/63, UDMA(33)
hdb: 79724736 sectors (40819 MB) w/444KiB Cache, CHS=79092/16/63, UDMA(33)
hdd: ATAPI 8X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
/dev/ide/host0/bus0/target0/lun0: p1 p2 p3
/dev/ide/host0/bus0/target1/lun0: p1
floppy0: no floppy controllers found
LVM version 0.9  by Heinz Mauelshagen  (13/11/2000)
lvm -- Driver successfully initialized
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x340: 00 00 1b 3c 7a 55
eth1: NE2000 found at 0x340, using IRQ 9.
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
Linux Tulip driver version 0.9.12 (December 17, 2000)
PCI: Found IRQ 10 for device 00:09.0
eth0: Macronix 98715 PMAC rev 37 at 0xe800, 00:80:AD:8C:D8:AC, IRQ 10.	
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Registered PPPoX v0.5
Registered PPPoE v0.6.4
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 16M @ 0xe6000000
[drm] AGP 0.99 on VIA MVP3 @ 0xe6000000 16MB
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE-CD    Model: R/RW 4x4x32       Rev: 1.10
    Type:   CD-ROM                             ANSI SCSI revision: 02
    Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
    sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (1023 buckets, 8184 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 236k freed
cdrom: open failed.
VFS: Disk change detected on device ide1(22,64)
cdrom: open failed.
VFS: Disk change detected on device ide1(22,64)
devfs: devfs_register(): device already registered: "group"
reiserfs: checking transaction log (device 3a:00) ...
reiserfs: replayed 2 transactions in 1 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23
reiserfs: checking transaction log (device 3a:03) ...
reiserfs: replayed 42 transactions in 3 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23
reiserfs: checking transaction log (device 3a:04) ...
reiserfs: replayed 3 transactions in 2 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23
reiserfs: checking transaction log (device 3a:01) ...
reiserfs: replayed 1 transactions in 3 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23
Adding Swap: 204792k swap-space (priority -1)
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-core.o: driver i2c TV tuner driver registered.
i2c-core.o: driver i2c msp3400 driver registered.
bttv: driver version 0.7.50 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
IRQ routing conflict in pirq table! Try 'pci=autoirq'
bttv0: Bt848 (rev 18) at 00:0a.0, irq: 12, latency: 64, memory: 0xe8001000
bttv0: model: BT848A(Terratec/Vobis TV-Boost) [insmod option]
i2c-dev.o: Registered 'bt848 #0' as minor 0
tuner: chip found @ 0x60
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
<Crystal audio controller (CS4236)> at 0x530 irq 7 dma 1,3
journal-1777: buffer 16 bad state !PREPARED !LOCKED !DIRTY !JDIRTY_WAIT



cat /etc/X11/xdm/xdm-errors:

XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 18 December 2000
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.16-3smp i686 [ELF] 
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Jan  5 08:06:42 2001
(==) Using config file: "/etc/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "layout0"
(**) |-->Screen "screen0" (0)
(**) |   |-->Monitor "Flatron-795FT"
(**) |   |-->Device "My Video Card"
(**) |-->Input Device "Keyboard"
(**) XKB: keymap: "xfree86(de)" (overrides other XKB settings)
(**) |-->Input Device "Mouse"
(WW) The directory "/usr/X11R6/lib/X11/fonts/URW/" does not exist.
	Entry deleted from font path.
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/:unscaled,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 1

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:10:0) BrookTree 848 rev 18, Mem @ 0xe8001000/12
(--) PCI:*(1:0:0) 3Dfx Interactive Voodoo3 rev 1, Mem @ 0xe0000000/25, 0xe4000000/25, I/O @ 0xd000/8
(WW) LoadModule: given non-canonical module name "xf86Jstk.so"
(II) Loading /usr/X11R6/lib/modules/xf86Jstk.so
(EE) LoadModule: Module xf86Jstk.so does not have a xf86JstkModuleData data object.
(II) Unloading /usr/X11R6/lib/modules/xf86Jstk.so
(EE) Failed to load module "xf86Jstk.so" (invalid module, 0)
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/drivers/tdfx_drv.o
(II) Module tdfx: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) TDFX: Driver for 3dfx Banshee/Voodoo3 chipsets: 3dfx Banshee,
	3dfx Voodoo3, 3dfx Voodoo5
(--) Assigning device section with no busID to primary device
(--) Chipset 3dfx Voodoo3 found
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) TDFX(0): Softbooting the board (through the int10 interface).
(II) TDFX(0): Primary V_BIOS segment is: 0xc000
(II) TDFX(0): Softbooting the board succeeded.
(**) TDFX(0): Depth 16, (--) framebuffer bpp 16
(==) TDFX(0): RGB weight 565
(==) TDFX(0): Default visual is TrueColor
(--) TDFX(0): Chipset: "3dfx Voodoo3"
(--) TDFX(0): Linear framebuffer at 0xE4000000
(--) TDFX(0): MMIO registers at addr 0xE0000000
(--) TDFX(0): PIO registers at addr 0xD000
(--) TDFX(0): VideoRAM: 16384 kByte Mapping 32768 kByte
(==) TDFX(0): Using gamma correction (1.0, 1.0, 1.0)
(II) TDFX(0): Flatron-795FT: Using hsync range of 30.00-96.00 kHz
(II) TDFX(0): Flatron-795FT: Using vrefresh range of 50.00-160.00 Hz
(II) TDFX(0): Clock range:  12.00 to 300.00 MHz
(WW) TDFX(0): Mode "1024x768" deleted (bad mode clock/interlace/doublescan)
(WW) TDFX(0): Mode "1152x864" deleted (bad mode clock/interlace/doublescan)
(WW) TDFX(0): Mode "1280x1024" deleted (bad mode clock/interlace/doublescan)
(WW) TDFX(0): Mode "1600x1200" deleted (hsync out of range)
(WW) TDFX(0): Mode "1280x1024" deleted (hsync out of range)
(WW) TDFX(0): Default mode "1792x1344" deleted (hsync out of range)
(WW) TDFX(0): Default mode "1856x1392" deleted (hsync out of range)
(WW) TDFX(0): Default mode "1920x1440" deleted (hsync out of range)
(--) TDFX(0): Virtual size is 1280x1024 (pitch 1280)
(**) TDFX(0): Mode "1280x1024": 157.5 MHz, 91.1 kHz, 85.0 Hz
(**) TDFX(0): Mode "1152x864": 137.7 MHz, 89.6 kHz, 99.4 Hz
(**) TDFX(0): Mode "1024x768": 115.5 MHz, 80.2 kHz, 100.0 Hz
(**) TDFX(0): Mode "800x600": 69.7 MHz, 64.0 kHz, 100.0 Hz
(**) TDFX(0): Mode "640x480": 45.8 MHz, 53.0 kHz, 100.0 Hz
(==) TDFX(0): DPI set to (75, 75)
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.0.2, module version = 1.0.0
(II) TDFX(0): initializing int10
(II) TDFX(0): Primary V_BIOS segment is: 0xc000
(II) TDFX(0): VESA BIOS detected
(II) TDFX(0): VESA VBE DDC supported
(II) TDFX(0): Manufacturer: GSM  Model: 42dd  Serial#: 16843009
(II) TDFX(0): Year: 2000  Week: 0
(II) TDFX(0): EDID Version: 1.1
(II) TDFX(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) TDFX(0): Signal levels configurable
(II) TDFX(0): Sync:  Separate  Composite  SyncOnGreen
(II) TDFX(0): Max H-Image Size [cm]: horiz.: 33  vert.: 25
(II) TDFX(0): Gamma: 2.90
(II) TDFX(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) TDFX(0): redX: 0.635 redY: 0.326   greenX: 0.275 greenY: 0.607
(II) TDFX(0): blueX: 0.142 blueY: 0.072   whiteX: 0.282 whiteY: 0.298
(II) TDFX(0): Supported VESA Video Modes:
(II) TDFX(0): 720x400@70Hz
(II) TDFX(0): 720x400@88Hz
(II) TDFX(0): 640x480@60Hz
(II) TDFX(0): 640x480@67Hz
(II) TDFX(0): 640x480@72Hz
(II) TDFX(0): 640x480@75Hz
(II) TDFX(0): 800x600@56Hz
(II) TDFX(0): 800x600@60Hz
(II) TDFX(0): 800x600@72Hz
(II) TDFX(0): 800x600@75Hz
(II) TDFX(0): 832x624@75Hz
(II) TDFX(0): 1024x768@87Hz (interlaced)
(II) TDFX(0): 1024x768@60Hz
(II) TDFX(0): 1024x768@70Hz
(II) TDFX(0): 1024x768@75Hz
(II) TDFX(0): 1280x1024@75Hz
(II) TDFX(0): 1152x870@75Hz
(II) TDFX(0): Manufacturer's mask: 0
(II) TDFX(0): Supported Future Video Modes:
(II) TDFX(0): #0: hsize: 640  vsize 480  refresh: 60  vid: 16433
(II) TDFX(0): #1: hsize: 720  vsize 540  refresh: 70  vid: 19003
(II) TDFX(0): #2: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) TDFX(0): #3: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) TDFX(0): #4: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) TDFX(0): #5: hsize: 1280  vsize 1024  refresh: 75  vid: 36737
(II) TDFX(0): #6: hsize: 1280  vsize 1024  refresh: 85  vid: 39297
(II) TDFX(0): #7: hsize: 1600  vsize 1200  refresh: 75  vid: 20393
(II) TDFX(0): Supported additional Video Mode:
(II) TDFX(0): clock: 135.0 MHz   Image Size:  310 x 230 mm
(II) TDFX(0): h_active: 1280  h_sync: 1296  h_sync_end 1440 h_blank_end 1688 h_border: 0
(II) TDFX(0): v_active: 1024  v_sync: 1025  v_sync_end 1028 v_blanking: 1066 v_border: 0
(II) TDFX(0): Supported additional Video Mode:
(II) TDFX(0): clock: 202.5 MHz   Image Size:  310 x 230 mm
(II) TDFX(0): h_active: 1600  h_sync: 1664  h_sync_end 1856 h_blank_end 2160 h_border: 0
(II) TDFX(0): v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking: 1250 v_border: 0
(II) TDFX(0): Ranges: V min: 50  V max: 160 Hz, H min: 30  H max: 96 kHz, PixClock max 200 kHz
(II) TDFX(0): Monitor name: Flatron795FT
(II) TDFX(0): Textures Memory 7.93 MB
(0): [drm] created "tdfx" driver at busid "PCI:1:0:0"
(0): [drm] added 4096 byte SAREA at 0xc1b16000
(0): [drm] mapped SAREA 0xc1b16000 to 0x40014000
(0): [drm] framebuffer handle = 0xe4000000
(0): [drm] added 1 reserved context for kernel
(II) TDFX(0): [drm] Registers = 0xe0000000
(II) TDFX(0): visual configs initialized
(II) TDFX(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Offscreen Pixmaps
	Driver provided NonTEGlyphRenderer replacement
	Setting up tile and stipple cache:
		10 128x128 slots
(==) TDFX(0): Backing store disabled
(==) TDFX(0): Silken mouse enabled
(0): X context handle = 0x00000001
(0): [drm] installed DRM signal handler
(0): [DRI] installation complete
(II) TDFX(0): direct rendering enabled
(II) Keyboard "Keyboard" handled by legacy driver
(**) Mouse: Protocol: "IntelliMouse"
(**) Mouse: Core Pointer
(==) Mouse: Buttons: 3
(**) Mouse: ZAxisMapping: buttons 4 and 5
(**) Mouse: BaudRate: 1200
(II) XINPUT: Adding extended input device "Mouse" (type: MOUSE)
Could not init font path element /usr/X11R6/lib/X11/fonts/Type1/, removing from list!
Could not init font path element /usr/X11R6/lib/X11/fonts/Speedo/, removing from list!
Warning: Color name "black " is not defined
GetModeLine - scrn: 0 clock: 157500
GetModeLine - hdsp: 1280 hbeg: 1344 hend: 1504 httl: 1728
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1072 flags: 5



[X.] Other notes, patches, fixes, workarounds:

bye
-- 
W.O.R.L.D.: Worker Optimized for Repair and Logical Destruction
******** PGP/GPG keys available at wwwkeys.eu.pgp.net *********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
