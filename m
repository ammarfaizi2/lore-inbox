Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVEIMAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVEIMAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEIMAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:00:47 -0400
Received: from adsl-66-124-75-211.dsl.sntc01.pacbell.net ([66.124.75.211]:31954
	"EHLO yenveedu.com") by vger.kernel.org with ESMTP id S261301AbVEIL61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:58:27 -0400
Subject: i810 dri X server crash on resume from suspend(software suspend2)
From: Wilson Almeida <lists@technolunatic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-TfrwIMMkhXWrpTGE0aPn"
Date: Mon, 09 May 2005 17:24:26 +0530
Message-Id: <1115639666.10859.16.camel@stan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TfrwIMMkhXWrpTGE0aPn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to get suspend/resume to work on my sony vaio (PCG FX-140)
laptop.  Everything works fine if I run the X server without
acceleration enabled in xorg.conf.  But if I run it with acceleration
turned on, then I get either X server crash on resume or sometimes even
hard freeze(sysrq does not work).  The graphics chipset is Intel 82815
and so it uses i810 driver.

I'm running 2.6.11 with cko5 patches including software suspend2
(2.1.7.2) patches.  This is true with both 6.8.2 and the latest cvs pull
of Xorg server.

I see the following output in logfile after the crash :

Error in I810WaitLpRing(), now is 24848, start is 22847
pgetbl_ctl: 0xf4d0001 pgetbl_err: 0x0
ipeir: 1 iphdr: c6000000
LP ring tail: 40 head: 0 len: f001 start 300000
eir: 0 esr: 1 emr: 3d
instdone: ff78 instpm: 0
memmode: 4 instps: 850
hwstam: bac7 ier: 0 imr: bac7 iir: 0
space: 65464 wanted 65528

Fatal server error:
lockup


Further attempts the start the X server (with or without acceleration)
result in same output. Even system restart(power cycling) does not help.
The only way to get X server to run is to power down the laptop and
switching it back up.

I'm attaching pruned X server log and lspci output.

Any lead would be greatly appreciated.

regards,

-Wilson

--=-TfrwIMMkhXWrpTGE0aPn
Content-Disposition: inline; filename=X-Crash-Log.txt
Content-Type: text/plain; name=X-Crash-Log.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

This is a pre-release version of the The X.Org Foundation X12.
It is not supported in any way.
Bugs may be filed in the bugzilla at http://bugs.freedesktop.org/.
Select the "xorg" product for bugs you find in this release.
Before reporting bugs in pre-release versions please check the
latest version in the The X.Org Foundation "monolithic tree" CVS
repository hosted at http://www.freedesktop.org/Software/xorg/
X Window System Version 6.8.99.5
Release Date: 01 May 2005 + cvs
X Protocol Version 11, Revision 0, Release 6.8.99.5
Build Operating System: Linux 2.6.11-cko5 i686 [ELF] 
Current Operating System: Linux stan 2.6.11-cko5 #1 Tue May 3 00:06:39 IST 2005 i686
Build Date: 07 May 2005
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.9.log", Time: Sat May  7 16:30:41 2005
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "X.org Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Intel i810"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(WW) `fonts.dir' not found (or not valid) in "/usr/share/fonts/Speedo/".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/usr/share/fonts/Speedo/").
(**) FontPath set to "/usr/share/fonts/local/,/usr/share/fonts/misc/,/usr/share/fonts/75dpi/:unscaled,/usr/share/fonts/100dpi/:unscaled,/usr/share/fonts/Type1/,/usr/share/fonts/TTF/,/usr/share/fonts/CID/,/usr/share/fonts/75dpi/,/usr/share/fonts/100dpi/,/opt/fonts/TTF2/"
(**) RgbPath set to "/usr/lib/X11/rgb"
(**) ModulePath set to "/usr/X11R6/lib/modules"
(II) No APM support in BIOS or kernel
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(--) using VT number 9

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,1130 card 104d,80df rev 11 class 06,00,00 hdr 00
(II) PCI: 00:02:0: chip 8086,1132 card 104d,80df rev 11 class 03,00,00 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 03 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,244c card 0000,0000 rev 03 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,244a card 104d,80df rev 03 class 01,01,80 hdr 00
(II) PCI: 00:1f:2: chip 8086,2442 card 104d,80df rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1f:3: chip 8086,2443 card 104d,80df rev 03 class 0c,05,00 hdr 00
(II) PCI: 00:1f:4: chip 8086,2444 card 104d,80df rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1f:5: chip 8086,2445 card 104d,80df rev 03 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,2446 card 104d,80df rev 03 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 104c,8021 card 104d,80df rev 02 class 0c,00,10 hdr 00
(II) PCI: 01:02:0: chip 1180,0476 card 4000,0000 rev 80 class 06,07,00 hdr 82
(II) PCI: 01:02:1: chip 1180,0476 card 4800,0000 rev 80 class 06,07,00 hdr 82
(II) PCI: 01:08:0: chip 8086,2449 card 8086,3013 rev 03 class 02,00,00 hdr 00
(II) PCI: 02:00:0: chip 10b7,5257 card 10b7,5c57 rev 10 class 02,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,6), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:30:0), (0,1,1), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[1] -1	0	0x00003400 - 0x000034ff (0x100) IX[B]
	[2] -1	0	0x00003800 - 0x000038ff (0x100) IX[B]
	[3] -1	0	0x00003c00 - 0x00003cff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xf4100000 - 0xf41fffff (0x100000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 2: bridge is at (1:2:0), (1,2,5), BCTRL: 0x0500 (VGA_EN is cleared)
(II) PCI-to-CardBus bridge:
(II) Bus 6: bridge is at (1:2:1), (1,6,9), BCTRL: 0x0580 (VGA_EN is cleared)
(--) PCI:*(0:2:0) Intel Corporation 82815 CGC [Chipset Graphics Controller] rev 17, Mem @ 0xf8000000/26, 0xf4000000/19
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[1] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[2] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[3] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[4] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[5] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[6] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[7] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[8] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[9] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[10] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[11] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[12] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[13] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[14] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[15] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[16] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[1] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[2] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[3] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[4] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[5] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[6] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[7] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[8] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[9] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[10] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[11] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[12] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[13] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[14] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[15] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[16] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x107fffff (0x10700000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x107fffff (0x10700000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[6] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[7] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[8] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[9] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[10] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[11] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[15] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[16] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[17] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[18] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[19] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[20] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[21] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[22] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[23] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
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
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "xtrap"
(II) Loading /usr/X11R6/lib/modules/extensions/libxtrap.a
(II) Module xtrap: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DEC-XTRAP
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.8.99.5, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "i810"
(II) Loading /usr/X11R6/lib/modules/drivers/i810_drv.o
(II) Module i810: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.3.0
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/X11R6/lib/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) I810: Driver for Intel Integrated Graphics Chipsets: i810, i810-dc100,
	i810e, i815, i830M, 845G, 852GM/855GM, 865G, 915G, 915GM
(II) Primary Device is: PCI 00:02:0
(--) Assigning device section with no busID to primary device
(--) Chipset i815 found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x107fffff (0x10700000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[6] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[7] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[8] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[9] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[10] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[11] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[15] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[16] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[17] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[18] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[19] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[20] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[21] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[22] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[23] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x107fffff (0x10700000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[6] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[7] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[8] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[9] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[10] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[11] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[12] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[13] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[14] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[18] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[19] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[20] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[21] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[22] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[23] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[24] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[25] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[26] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
	[27] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[28] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(**) I810(0): Depth 16, (--) framebuffer bpp 16
(==) I810(0): RGB weight 565
(==) I810(0): Default visual is TrueColor
(**) I810(0): Option "accel" "true"
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) I810(0): initializing int10
(II) I810(0): Primary V_BIOS segment is: 0xc000
(II) I810(0): VESA BIOS detected
(II) I810(0): VESA VBE Version 3.0
(II) I810(0): VESA VBE Total Mem: 1024 kB
(II) I810(0): VESA VBE OEM: Intel815M(TM) Graphics Chip Accelerated VGA BIOS
(II) I810(0): VESA VBE OEM Software Rev: 1.0
(II) I810(0): VESA VBE OEM Vendor: Intel Corporation
(II) I810(0): VESA VBE OEM Product: i815M Graphics Controller
(II) I810(0): VESA VBE OEM Product Rev: Hardware Version 0.0
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) I810(0): VESA VBE DDC supported
(II) I810(0): VESA VBE DDC Level none
(II) I810(0): VESA VBE DDC transfer in appr. 0 sec.
(II) I810(0): VESA VBE DDC read failed
(--) I810(0): Chipset: "i815"
(--) I810(0): Linear framebuffer at 0xF8000000
(--) I810(0): IO registers at addr 0xF4000000
(II) I810(0): I810CheckAvailableMemory: 206812k available
(**) I810(0): Will alloc AGP framebuffer: 16384 kByte
(==) I810(0): Using gamma correction (1.0, 1.0, 1.0)
(II) I810(0): Monitor0: Using hsync range of 31.50-48.50 kHz
(II) I810(0): Monitor0: Using vrefresh range of 40.00-70.00 Hz
(II) I810(0): Clock range:   9.50 to 163.00 MHz
(--) I810(0): Virtual size is 1024x768 (pitch 1024)
(**) I810(0): *Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) I810(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) I810(0): *Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) I810(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) I810(0): *Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(II) I810(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(**) I810(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) I810(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(==) I810(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="X.Org Foundation"
	compiled for 6.8.99.5, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(**) I810(0): page flipping disabled
(II) I810(0): XvMC is Disabled: use XvMCSurfaces config option to enable.
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xf4000000 - 0xf407fff0 (0x7fff1) MS[B]
	[1] 0	0	0xf8000000 - 0xfc000000 (0x4000001) MS[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x107fffff (0x10700000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0x10800080 - 0x108000f0 (0x71) MX[B]
	[8] -1	0	0x10800000 - 0x10800070 (0x71) MX[B]
	[9] -1	0	0xf4100000 - 0xf4100ff0 (0xff1) MX[B]
	[10] -1	0	0xf4104000 - 0xf4107ff0 (0x3ff1) MX[B]
	[11] -1	0	0xf4101000 - 0xf41017f0 (0x7f1) MX[B]
	[12] -1	0	0xf4000000 - 0xf407fff0 (0x7fff1) MX[B](B)
	[13] -1	0	0xf8000000 - 0xfc000000 (0x4000001) MX[B](B)
	[14] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[15] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[16] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x00004000 - 0x00004080 (0x81) IX[B]
	[20] -1	0	0x00003000 - 0x00003040 (0x41) IX[B]
	[21] -1	0	0x00001880 - 0x00001900 (0x81) IX[B]
	[22] -1	0	0x00002000 - 0x00002100 (0x101) IX[B]
	[23] -1	0	0x00001840 - 0x00001880 (0x41) IX[B]
	[24] -1	0	0x00001c00 - 0x00001d00 (0x101) IX[B]
	[25] -1	0	0x00002400 - 0x00002420 (0x21) IX[B]
	[26] -1	0	0x00001810 - 0x00001820 (0x11) IX[B]
	[27] -1	0	0x00001820 - 0x00001840 (0x21) IX[B]
	[28] -1	0	0x00001800 - 0x00001810 (0x11) IX[B]
	[29] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[30] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenByBusid: Searching for BusID pci:0000:00:02.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenByBusid: drmOpenMinor returns 10
drmOpenByBusid: drmGetBusid reports pci:0000:00:02.0
(II) I810(0): [drm] DRM interface version 1.2
(II) I810(0): [drm] created "i810" driver at busid "pci:0000:00:02.0"
(II) I810(0): [drm] drmAddMap failed
(EE) I810(0): [dri] DRIScreenInit failed.  Disabling DRI.
(==) I810(0): Write-combining range (0xf8000000,0x4000000)
(II) I810(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) I810(0): Setting dot clock to 65.0 MHz [ 0x3f 0xa 0x30 ] [ 65 12 3 ]
(II) I810(0): chose watermark 0x2210e000: (tab.freq 65.0)
(II) I810(0): xf86BindGARTMemory: bind key 7 at 0x00000000 (pgoffset 0)
(WW) I810(0): xf86AllocateGARTMemory: allocation of 1024 pages failed
	(Cannot allocate memory)
(II) I810(0): No physical memory available for 4194304 bytes of DCACHE
(II) I810(0): xf86BindGARTMemory: bind key 8 at 0x01000000 (pgoffset 4096)
(WW) I810(0): xf86BindGARTMemory: binding of gart memory with key 8
	at offset 0x1000000 failed (Device or resource busy)
(II) I810(0): Allocation of 4096 bytes for HW cursor failed
(II) I810(0): xf86BindGARTMemory: bind key 9 at 0x01000000 (pgoffset 4096)
(WW) I810(0): xf86BindGARTMemory: binding of gart memory with key 9
	at offset 0x1000000 failed (Device or resource busy)
(II) I810(0): Allocation of 16384 bytes for ARGB HW cursor failed
(II) I810(0): Adding 768 scanlines for pixmap caching
(II) I810(0): Allocated Scratch Memory
(II) I810(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Horizontal and Vertical Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		24 128x128 slots
		6 256x256 slots
(==) I810(0): Backing store disabled
(==) I810(0): Silken mouse enabled
(**) Option "dpms"
(**) I810(0): DPMS enabled
(==) I810(0): Direct rendering disabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Option "Protocol" "auto"
(**) Mouse0: Device: "/dev/input/mice"
(**) Mouse0: Protocol: "auto"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "no"
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(**) Mouse0: SmartScroll: 1 
(**) Option "Resolution" "255"
(**) Mouse0: Resolution: 255
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Keyboard0: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Keyboard0: XkbModel: "pc105"
(**) Option "XkbLayout" "us"
(**) Keyboard0: XkbLayout: "us"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
(--) Mouse0: PnP-detected protocol: "ExplorerPS/2"
(II) Mouse0: ps2EnableDataReporting: succeeded
Could not init font path element /usr/share/fonts/local/, removing from list!
Could not init font path element /usr/share/fonts/CID/, removing from list!
Error in I810WaitLpRing(), now is 24848, start is 22847
pgetbl_ctl: 0xf4d0001 pgetbl_err: 0x0
ipeir: 1 iphdr: c6000000
LP ring tail: 40 head: 0 len: f001 start 300000
eir: 0 esr: 1 emr: 3d
instdone: ff78 instpm: 0
memmode: 4 instps: 850
hwstam: bac7 ier: 0 imr: bac7 iir: 0
space: 65464 wanted 65528

Fatal server error:
lockup





--=-TfrwIMMkhXWrpTGE0aPn
Content-Disposition: inline; filename=System-Report.txt
Content-Type: text/plain; name=System-Report.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

System running on Gentoo using 2.6.11 kernel.

uname -a output :

Linux stan 2.6.11-cko5 #1 Tue May 3 00:06:39 IST 2005 i686 Pentium III
(Coppermine) GenuineIntel GNU/Linux


lspci -vv output :

0000:00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 11)
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [88] #09 [f205]

0000:00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller] (rev 11) (prog-if 00 [VGA])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (LPC) (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03) (prog-if 80 [Master])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 1800 [size=16]

0000:00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1820 [size=32]

0000:00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 03)
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 1810 [size=16]

0000:00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at 2400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97 Audio (rev 03)
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 1c00
	Region 1: I/O ports at 1840 [size=64]

0000:00:1f.6 Modem: Intel Corporation 82801BA/BAM AC'97 Modem (rev 03) (prog-if 00 [Generic])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 2000
	Region 1: I/O ports at 1880 [size=128]

0000:01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4101000 (32-bit, non-prefetchable)
	Region 1: Memory at f4104000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation Vaio PCG-FX403
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:08.0 Ethernet controller: Intel Corporation 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)
	Subsystem: Intel Corporation EtherExpress PRO/100 VE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4100000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:00.0 Ethernet controller: 3Com Corporation 3cCFE575CT CardBus [Cyclone] (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 4000 [size=260M]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-TfrwIMMkhXWrpTGE0aPn--

