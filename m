Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTJZIvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 03:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbTJZIvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 03:51:08 -0500
Received: from [134.29.1.12] ([134.29.1.12]:20612 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262937AbTJZIso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 03:48:44 -0500
Message-ID: <3F9B8A6B.6030102@hundstad.net>
Date: Sun, 26 Oct 2003 02:48:43 -0600
From: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [long] linux-2.6.0-test9, XFree86 4.2.1.1, ATI ATI Radeon VE QY,
 screen hangs on 3d apps
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using Debian unstable.  It comes with XFree86 Vesrion 4.2.1.1.  This 
works fine with linux-2.4.22.  I've been using this configuration with 
accelerated 3d apps.  With linux-2.6.0-test9 X works fine until a 3d 
application such as glxgears starts.  The screen no longer updates 
except that you can move the cursor.  The logs do not indicate failure.  
I can't get the screen back without a reboot.  I can connect via. the 
network to do analysis if someone wants to give me a clue what to look for.

So once again:

XFree86 Vesrion 4.2.1.1
linux-2.6.0-test9
ATI Radeon VE QY rev 0

attached glxinfo
attached dmesg
attached XFree86.log
.config

dmesg:
Linux version 2.6.0-test9 (j3gum@jeffrey) (gcc version 3.3.2 (Debian)) 
#1 Sat Oct 25 22:41:11 CDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=260-test9 ro root=303 
rootflags=usrquota,grpquota ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1402.273 MHz processor.
Console: colour VGA+ 80x25
Memory: 254752k/262144k available (2671k kernel code, 6640k reserved, 
713k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbf7 c1cbfbff 00000000 00000020
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1401.0516 MHz.
..... host bus clock speed is 266.0955 MHz.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf50
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf80, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: probed SDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon VE QY SDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
VFS: Disk quotas dquot_6.5.1
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063       hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c       vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x1bf
ppll_div_3 = 0x301bf
ron = 976, roff = 22092
vclk_freq = 2514, per = 789
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CR-48XCTE, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
FAT: Unrecognized mount option "usrquota" or missing value
FAT: Unrecognized mount option "usrquota" or missing value
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 2000084k swap on /dev/hda2.  Priority:-1 extents:1
SCSI subsystem initialized
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
XFS mounting filesystem hda4
Ending clean XFS mount for filesystem: hda4
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 9, io base 0000e000
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 9, io base 0000e400
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: irq 9, io base 0000e800
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Linux video capture interface: v1.00
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd400. Vers LK1.1.19
eth0: Dropping NETIF_F_SG since no checksum feature.


glxinfo:
name of display: :0.0
display: :0  screen: 0
direct rendering: Yes
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:
    GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
client glx vendor string: SGI
client glx version string: 1.2
client glx extensions:
    GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
GLX extensions:
    GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Radeon 20010402 AGP 4x x86/MMX/3DNow!
OpenGL version string: 1.2 Mesa 3.4.2
OpenGL extensions:
    GL_ARB_multitexture, GL_ARB_transpose_matrix, GL_EXT_abgr,
    GL_EXT_blend_func_separate, GL_EXT_clip_volume_hint,
    GL_EXT_compiled_vertex_array, GL_EXT_histogram, GL_EXT_packed_pixels,
    GL_EXT_polygon_offset, GL_EXT_rescale_normal, GL_EXT_stencil_wrap,
    GL_EXT_texture3D, GL_EXT_texture_env_add, GL_EXT_texture_env_combine,
    GL_EXT_texture_env_dot3, GL_EXT_texture_object, 
GL_EXT_texture_lod_bias,
    GL_EXT_vertex_array, GL_MESA_window_pos, GL_MESA_resize_buffers,
    GL_NV_texgen_reflection, GL_PGI_misc_hints, GL_SGIS_pixel_texture,
    GL_SGIS_texture_edge_clamp
glu version: 1.3
glu extensions:
    GLU_EXT_nurbs_tessellator, GLU_EXT_object_space_tess

   visual  x  bf lv rg d st colorbuffer ax dp st accumbuffer  ms  cav
 id dep cl sp sz l  ci b ro  r  g  b  a bf th cl  r  g  b  a ns b eat
----------------------------------------------------------------------
0x23 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  0  0  0  0  0  0 0 None
0x24 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  8  0  0  0  0  0 0 Slow
0x25 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  0 16 16 16 16  0 0 Slow
0x26 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  8 16 16 16 16  0 0 Slow
0x27 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  0  0  0  0  0  0 0 None
0x28 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  8  0  0  0  0  0 0 Slow
0x29 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  0 16 16 16 16  0 0 Slow
0x2a 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  8 16 16 16 16  0 0 Slow



XFree86.0.log:

This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.2.1.1 (Debian 4.2.1-12.1 20031003005825 
james@nocrew.org) / X Window System
(protocol Version 11, revision 0, vendor release 6600)
Release Date: 18 October 2002
    If the server is older than 6-12 months, or if your card is
    newer than the above date, look for a newer version before
    reporting problems.  (See http://www.XFree86.Org/)
Build Operating System: Linux 2.4.21-rc1-ac1-cryptoloop i686 [ELF]
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Sat Oct 25 23:14:27 2003
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Generic Video Card"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(WW) `fonts.dir' not found (or not valid) in 
"/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID".
    Entry deleted from font path.
    (Run 'mkfontdir' on "/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID").
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
    Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
    Entry deleted from font path.
(**) FontPath set to 
"/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi,unix/:7110,/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/misc"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 7

(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
    XFree86 ANSI C Emulation: 0.1
    XFree86 Video Driver: 0.5
    XFree86 XInput driver : 0.3
    XFree86 Server Extension : 0.1
    XFree86 Font Renderer : 0.3
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    Module class: XFree86 Font Renderer
    ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 0.1.0
    ABI class: XFree86 Video Driver, version 0.5
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80008c0c, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1106,3099 card 1106,3099 rev 00 class 06,00,00 
hdr 00
(II) PCI: 00:01:0: chip 1106,b099 card 0000,0000 rev 00 class 06,04,00 
hdr 01
(II) PCI: 00:0a:0: chip 1106,3044 card 1106,3044 rev 46 class 0c,00,10 
hdr 00
(II) PCI: 00:0b:0: chip 10b7,9050 card 0000,0000 rev 00 class 02,00,00 
hdr 00
(II) PCI: 00:0c:0: chip 109e,036e card 0070,13eb rev 11 class 04,00,00 
hdr 80
(II) PCI: 00:0c:1: chip 109e,0878 card 0070,13eb rev 11 class 04,80,00 
hdr 80
(II) PCI: 00:0e:0: chip 1274,1371 card 1274,1371 rev 08 class 04,01,00 
hdr 00
(II) PCI: 00:11:0: chip 1106,3074 card 1106,3074 rev 00 class 06,01,00 
hdr 80
(II) PCI: 00:11:1: chip 1106,0571 card 1106,0571 rev 06 class 01,01,8a 
hdr 00
(II) PCI: 00:11:2: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 
hdr 00
(II) PCI: 00:11:3: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 
hdr 00
(II) PCI: 00:11:4: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 
hdr 00
(II) PCI: 01:00:0: chip 1002,5159 card 174b,7112 rev 00 class 03,00,00 
hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 0.1.0
    ABI class: XFree86 Video Driver, version 0.5
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) PCI-to-ISA bridge:
(II) PCI-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
    [0] -1 0    0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
    [0] -1 0    0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
    [0] -1 0    0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x0c (VGA_EN is set)
(II) Bus 1 I/O range:
    [0] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B]
    [1] -1 0    0x0000c400 - 0x0000c4ff (0x100) IX[B]
    [2] -1 0    0x0000c800 - 0x0000c8ff (0x100) IX[B]
    [3] -1 0    0x0000cc00 - 0x0000ccff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
    [0] -1 0    0xec000000 - 0xedffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
    [0] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
(II) Bus -1: bridge is at (0:17:0), (0,-1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI: (0:12:0) BrookTree unknown chipset (0x036e) rev 17, Mem @ 
0xef001000/12
(--) PCI:*(1:0:0) ATI Radeon VE QY rev 0, Mem @ 0xe0000000/27, 
0xed000000/16, I/O @ 0xc000/8
(II) Addressable bus resource ranges are
    [0] -1 0    0x00000000 - 0xffffffff (0x0) MX[B]
    [1] -1 0    0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
    [0] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [1] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [2] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [3] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [4] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [5] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [6] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
    [0] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [1] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [2] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [3] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [4] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [5] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [6] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [7] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [8] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [9] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [10] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [11] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [12] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [13] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
    [0] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [1] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [2] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [3] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [4] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [5] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [6] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [7] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [8] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [9] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [10] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [11] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [12] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [13] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
    [0] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [1] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [2] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [3] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [4] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [5] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [6] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
    [0] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [1] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [2] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [3] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [4] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [5] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [6] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [7] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [8] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [9] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [10] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [11] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [12] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
    [13] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [14] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [15] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [16] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [17] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [18] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [19] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [20] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:debug_xform.o":  
No symbols found
(II) Module GLcore: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    Module class: XFree86 Server Extension
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    Module class: XFree86 Server Extension
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.1.10
    Module class: XFree86 Font Renderer
    ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.13.0
    Module class: XFree86 Server Extension
    ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
Skipping "/usr/X11R6/lib/modules/fonts/libspeedo.a:spencode.o":  No 
symbols found
(II) Module speedo: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.1
    Module class: XFree86 Font Renderer
    ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.1
    Module class: XFree86 Font Renderer
    ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "v4l"
(II) Loading /usr/X11R6/lib/modules/drivers/linux/v4l_drv.o
(II) Module v4l: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 0.0.1
    ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 6.4.16
    Module class: XFree86 Video Driver
    ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    Module class: XFree86 XInput Driver
    ABI class: XFree86 XInput driver, version 0.3
(II) v4l driver for Video4Linux
(II) ATI: ATI driver (version 6.4.16) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
    ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
    ATI Rage 128 RL (AGP), ATI Rage 128 SM (AGP),
    ATI Rage 128 Pro PD (PCI), ATI Rage 128 Pro PF (AGP),
    ATI Rage 128 Pro PP (PCI), ATI Rage 128 Pro PR (PCI),
    ATI Rage 128 Pro ULTRA TF (AGP), ATI Rage 128 Pro ULTRA TL (AGP),
    ATI Rage 128 Pro ULTRA TR (AGP), ATI Rage 128 Mobility LE (PCI),
    ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
    ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
    ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
    ATI Radeon VE QY (AGP), ATI Radeon VE QZ (AGP),
    ATI Radeon Mobility LW (AGP), ATI Radeon Mobility LX (AGP),
    ATI Radeon Mobility LY (AGP), ATI Radeon Mobility LZ (AGP),
    ATI Radeon 8500 QL (AGP), ATI Radeon 8500 QM (AGP),
    ATI Radeon 8500 QN (AGP), ATI Radeon 8500 QO (AGP),
    ATI Radeon 8500 Ql (AGP), ATI Radeon 8500 BB (AGP),
    ATI Radeon 7500 QW (AGP), ATI Radeon 9000 If (AGP)
(II) Primary Device is: PCI 01:00:0
(II) ATI:  Candidate "Device" section "Generic Video Card".
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon VE QY (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
    [0] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [1] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [2] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [3] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [4] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [5] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [6] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [7] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [8] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [9] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [10] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [11] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [12] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
    [13] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [14] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [15] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [16] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [17] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [18] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [19] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [20] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 4.0.1
    Module class: XFree86 Video Driver
    ABI class: XFree86 Video Driver, version 0.5
(II) resource ranges after probing:
    [0] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [1] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [2] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [3] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [4] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [5] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [6] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [7] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [8] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [9] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [10] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [11] 0 0    0x000a0000 - 0x000affff (0x10000) MS[B]
    [12] 0 0    0x000b0000 - 0x000b7fff (0x8000) MS[B]
    [13] 0 0    0x000b8000 - 0x000bffff (0x8000) MS[B]
    [14] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [15] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
    [16] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [17] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [18] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [19] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [20] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [21] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [22] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [23] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
    [24] 0 0    0x000003b0 - 0x000003bb (0xc) IS[B]
    [25] 0 0    0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 0.1.0
    ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 
0x0000
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "AGPMode" "4"
(**) RADEON(0): Option "UseFBDev" "false"
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon VE QY (AGP)" (ChipID = 0x5159)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): MMIO registers at 0xed000000
(--) RADEON(0): VideoRAM: 65536 kByte (64-bit SDR SDRAM)
(II) RADEON(0): Primary Display == Type 1
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.2.0
    ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): I2C device "DDC:ddc2" registered.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Reloading /usr/X11R6/lib/modules/libvbe.a
(II) RADEON(0): VESA BIOS detected
(II) RADEON(0): VESA VBE Version 2.0
(II) RADEON(0): VESA VBE Total Mem: 65536 kB
(II) RADEON(0): VESA VBE OEM: ATI RADEON III
(II) RADEON(0): VESA VBE OEM Software Rev: 1.0
(II) RADEON(0): VESA VBE OEM Vendor: ATI Technologies Inc.
(II) RADEON(0): VESA VBE OEM Product: R100
(II) RADEON(0): VESA VBE OEM Product Rev: 01.00
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) RADEON(0): VESA VBE DDC supported
(II) RADEON(0): VESA VBE DDC Level none
(II) RADEON(0): VESA VBE DDC transfer in appr. 2 sec.
(II) RADEON(0): VESA VBE DDC read failed
(II) RADEON(0): PLL parameters: rf=2700 rd=60 min=12000 max=35000; 
xclk=15500
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Generic Monitor: Using hsync range of 30.00-63.00 kHz
(II) RADEON(0): Generic Monitor: Using vrefresh range of 49.00-121.00 Hz
(II) RADEON(0): Clock range:  12.00 to 350.00 MHz
(II) RADEON(0): Not using default mode "1024x768" (hsync out of range)
(II) RADEON(0): Not using default mode "512x384" (hsync out of range)
(II) RADEON(0): Not using default mode "1152x864" (hsync out of range)
(II) RADEON(0): Not using default mode "576x432" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x960" (hsync out of range)
(II) RADEON(0): Not using default mode "640x480" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (hsync out of range)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (hsync out of range)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (hsync out of range)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (hsync out of range)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (hsync out of range)
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (hsync out of range)
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "800x512" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (hsync out of range)
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (hsync out of range)
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (hsync out of range)
(II) RADEON(0): Not using default mode "2048x1536" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1024x768" (hsync out of range)
(--) RADEON(0): Virtual size is 1024x768 (pitch 1024)
(**) RADEON(0): Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) RADEON(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 
769 772 800 +hsync +vsync
(**) RADEON(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) RADEON(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 
604 631 +hsync +vsync
(**) RADEON(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(II) RADEON(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 
509 -hsync -vsync
(**) RADEON(0): Display dimensions: (279, 209) mm
(**) RADEON(0): DPI set to (93, 93)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 0.1.0
    ABI class: XFree86 Video Driver, version 0.5
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
    compiled for 4.2.1.1, module version = 1.0.0
    ABI class: XFree86 Video Driver, version 0.5
(**) RADEON(0): Using AGP 4x mode
(II) RADEON(0): Depth moves disabled by default
(!!) RADEON(0): For information on using the multimedia capabilities
    of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
    [0] 0 0    0xed000000 - 0xed00ffff (0x10000) MX[B]
    [1] 0 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
    [2] -1 0    0xffe00000 - 0xffffffff (0x200000) MX[B](B)
    [3] -1 0    0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
    [4] -1 0    0x000f0000 - 0x000fffff (0x10000) MX[B]
    [5] -1 0    0x000c0000 - 0x000effff (0x30000) MX[B]
    [6] -1 0    0x00000000 - 0x0009ffff (0xa0000) MX[B]
    [7] -1 0    0xef002000 - 0xef002fff (0x1000) MX[B]
    [8] -1 0    0xef000000 - 0xef0007ff (0x800) MX[B]
    [9] -1 0    0xe8000000 - 0xebffffff (0x4000000) MX[B]
    [10] -1 0    0xed000000 - 0xed00ffff (0x10000) MX[B](B)
    [11] -1 0    0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
    [12] -1 0    0xef001000 - 0xef001fff (0x1000) MX[B](B)
    [13] 0 0    0x000a0000 - 0x000affff (0x10000) MS[B]
    [14] 0 0    0x000b0000 - 0x000b7fff (0x8000) MS[B]
    [15] 0 0    0x000b8000 - 0x000bffff (0x8000) MS[B]
    [16] 0 0    0x0000c000 - 0x0000c0ff (0x100) IX[B]
    [17] -1 0    0x0000ffff - 0x0000ffff (0x1) IX[B]
    [18] -1 0    0x00000000 - 0x000000ff (0x100) IX[B]
    [19] -1 0    0x0000e800 - 0x0000e81f (0x20) IX[B]
    [20] -1 0    0x0000e400 - 0x0000e41f (0x20) IX[B]
    [21] -1 0    0x0000e000 - 0x0000e01f (0x20) IX[B]
    [22] -1 0    0x0000dc00 - 0x0000dc0f (0x10) IX[B]
    [23] -1 0    0x0000d800 - 0x0000d83f (0x40) IX[B]
    [24] -1 0    0x0000d400 - 0x0000d43f (0x40) IX[B]
    [25] -1 0    0x0000d000 - 0x0000d07f (0x80) IX[B]
    [26] -1 0    0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
    [27] 0 0    0x000003b0 - 0x000003bb (0xc) IS[B]
    [28] 0 0    0x000003c0 - 0x000003df (0x20) IS[B]
(==) RADEON(0): Write-combining range (0xe0000000,0x4000000)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xd4912000
(II) RADEON(0): [drm] mapped SAREA 0xd4912000 to 0x44226000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000217 [AGP 0x1106/0x3099; Card 
0x1002/0x5159]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe8000000
(II) RADEON(0): [agp] Ring mapped at 0x44228000
(II) RADEON(0): [agp] ring read ptr handle = 0xe8101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0x44329000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe8102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0x4432a000
(II) RADEON(0): [agp] AGP texture map handle = 0xe8302000
(II) RADEON(0): [agp] AGP Texture map mapped at 0x4452a000
(II) RADEON(0): [drm] register handle = 0xed000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB AGP aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for AGP textures
(II) RADEON(0): Memory manager initialized to (0,0) (1024,3071)
(II) RADEON(0): Reserved area from (0,768) to (1024,770)
(II) RADEON(0): Largest offscreen area available: 1024 x 2301
(II) RADEON(0): Reserved back buffer at offset 0xc00000
(II) RADEON(0): Reserved depth buffer at offset 0xf00000
(II) RADEON(0): Reserved 47104 kb for textures at offset 0x1200000
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
    Screen to screen bit blits
    Solid filled rectangles
    Solid Lines
    Dashed Lines
    Offscreen Pixmaps
    Setting up tile and stipple cache:
        32 128x128 slots
        10 256x256 slots
        4 512x512 slots
(II) RADEON(0): Acceleration enabled
(II) RADEON(0): Using hardware cursor (scanline 3080)
(II) RADEON(0): Largest offscreen area available: 1024 x 2299
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): Direct rendering enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "true"
(**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 5
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)

.config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_STRADIS=m
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
CONFIG_USB_IBMCAM=m
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y


