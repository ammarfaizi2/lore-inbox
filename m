Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271239AbTG2Eft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 00:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271244AbTG2Eft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 00:35:49 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:22916 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271239AbTG2Efe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 00:35:34 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org, torvalds@home.osdl.org
Subject: Linus' 2.6.0-test1 (PPC) -- Radeon Mobility M7 LW (AGP) display messed up (DRI update problem?)
Date: Mon, 28 Jul 2003 21:35:27 -0700
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200307282135.27750.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

It looks like maybe something went wrong in your DRI merge.
>From 2.6.0-test1, I have had major problems with my Radeon
display when XFree86 (cvs HEAD) starts up.  I am running
on a PowerBook G4 (Titanium III/800) with DRI enabled.
Earlier 2.5 kernels rendered XFree86 okay.  The weird thing
since test1 is that once XFree86 starts up, switching to a 
VT and back does not clear up the problem.  The VT displays
are hosed as well (the problem is that only about the top
one line of text (in a VT window) looks okay.  Below that,
the whole screen is an out-of-sync blur.

When I run fbset in a VT window, it shows the same info
that shows up when running under 2.5 kernels (with no display
corruption).

I will test again with DRI disabled and see if the problem goes away.
If it does, I will check again with your DRI updates from 2.6.0-test1
backed out.  I'll let you know what happens.

XFree86 Version 4.3.99.9
Release Date: 26 July 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.21-ben2 ppc [ELF] 
Build Date: 27 July 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Mon Jul 28 15:20:42 2003
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Layout0"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "LCD"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Keyboard0"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "macintosh"
(**) XKB: model: "macintosh"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(**) Option "XkbOptions" "ctrl:nocaps"
(**) XKB: options: "ctrl:nocaps"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(WW) Option "XkbCompat" requires an string value
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(WW) Option "XkbOptions" requires an string value
(==) Keyboard: CustomKeycode disabled
(WW) The directory "/var/X11R6/lib/defoma/abiword-common.d/dirs/ISO-8859-1/" 
does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/X11R6/lib/X11/fonts/truetype/" does not exist.
	Entry deleted from font path.
(**) FontPath set to 
"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/ttf-bitstream-vera-1.10/,/usr/X11R6/lib/X11/fonts/TTF/,/usr/share/AbiSuite/fonts/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/mdk/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(**) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 7

(II) Open APM successful
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.7
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:0b:0: chip 106b,002d card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 00:10:0: chip 1002,4c57 card 1002,4c57 rev 00 class 03,00,00 hdr 00
(II) PCI: 01:0b:0: chip 106b,002e card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 01:17:0: chip 106b,0022 card 0000,0000 rev 03 class ff,00,00 hdr 00
(II) PCI: 01:18:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:19:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:1a:0: chip 104c,ac50 card 1000,0000 rev 02 class 06,07,00 hdr 02
(II) PCI: 06:0b:0: chip 106b,002f card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 06:0e:0: chip 11c1,5811 card 11c1,5811 rev 00 class 0c,00,10 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:11:0), (0,0,6), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Host-to-PCI bridge:
(II) Bus 1: bridge is at (1:11:0), (1,1,6), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 2: bridge is at (1:26:0), (1,2,5), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00001000 - 0x00008fff (0x8000) IX[B]
	[1] -1	0	0x00009000 - 0x000090ff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xf3000000 - 0xf31fffff (0x200000) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0	0x90000000 - 0x9fffffff (0x10000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus 6: bridge is at (6:11:0), (6,6,6), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 6 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 6 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 6 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(--) PCI:*(0:16:0) ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 
7500] rev 0, Mem @ 0xb8000000/27, 0xb0000000/16, I/O @ 0x0400/8, BIOS @ 
0xb0020000/17
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[1] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[2] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[3] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[4] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[5] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[6] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[7] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[1] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[2] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[3] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[4] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[5] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[6] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[7] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[3] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[4] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[5] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[7] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[8] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[9] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[11] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
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
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 2.0.4
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.99.8, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.99.8, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 6.5.3
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) ATI: ATI driver (version 6.5.3) for chipset: ati
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP), ATI Radeon VE/7000 QZ (AGP),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QI (AGP),
	ATI Radeon 8500 QJ (AGP), ATI Radeon 8500 QK (AGP),
	ATI Radeon 8500 QL (AGP), ATI Radeon 9100 QM (AGP),
	ATI Radeon 8500 QN (AGP), ATI Radeon 8500 QO (AGP),
	ATI Radeon 8500 Qh (AGP), ATI Radeon 8500 Qi (AGP),
	ATI Radeon 8500 Qj (AGP), ATI Radeon 8500 Qk (AGP),
	ATI Radeon 8500 Ql (AGP), ATI Radeon 8500 BB (AGP),
	ATI Radeon 7500 QW (AGP), ATI Radeon 7500 QX (AGP),
	ATI Radeon 9000 Id (AGP), ATI Radeon 9000 Ie (AGP),
	ATI Radeon 9000 If (AGP), ATI Radeon 9000 Ig (AGP),
	ATI Radeon Mobility M9 Ld (AGP), ATI Radeon Mobility M9 Le (AGP),
	ATI Radeon Mobility M9 Lf (AGP), ATI Radeon Mobility M9 Lg (AGP),
	ATI Radeon 9000 IGP (A5) 5834,
	ATI Radeon Mobility 9000 IGP (U3) 5835, ATI Radeon 9200 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200 5963 (AGP), ATI Radeon M9+ 5968 (AGP),
	ATI Radeon M9+ 5969 (AGP), ATI Radeon M9+ 596A (AGP),
	ATI Radeon M9+ 596B (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9500 AF (AGP),
	ATI FireGL Z1/X1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600PRO AR (AGP), ATI Radeon Mobility M10 NP (AGP),
	ATI FireGL (R350) AK (AGP), ATI Radeon 9800 NH (AGP),
	ATI FireGL (R350) NL (AGP)
(II) Primary Device is: PCI 00:10:0
(II) ATI:  Candidate "Device" section "Card0".
(--) Chipset ATI Radeon Mobility M7 LW (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[3] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[4] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[5] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[7] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[8] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[9] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[11] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) resource ranges after probing:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[3] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[4] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[5] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[7] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[8] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[9] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[10] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[11] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[14] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
	[15] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[16] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xb0000000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03b0, hwp->PIOOffset is 
0x0000
(II) RADEON(0): PCI bus 0 card 16 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "AGPMode" "4"
(**) RADEON(0): Option "AGPSize" "16"
(**) RADEON(0): Option "EnablePageFlip"
(**) RADEON(0): Option "UseFBDev"
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 0.0.2
	ABI class: XFree86 Video Driver, version 0.7
(**) RADEON(0): Using framebuffer device
(--) RADEON(0): Chipset: "ATI Radeon Mobility M7 LW (AGP)" (ChipID = 0x4c57)
(--) RADEON(0): Linear framebuffer at 0xb8000000
(--) RADEON(0): BIOS at 0xb0020000
(--) RADEON(0): VideoRAM: 32768 kByte (64-bit DDR SDRAM)
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(WW) RADEON(0): Video BIOS not detected in PCI space!
(WW) RADEON(0): Attempting to read Video BIOS from legacy ISA space!
(WW) RADEON(0): Video BIOS not found!
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 2
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 0
(II) RADEON(0): Displays Detected: Monitor1--Type 2, Monitor2--Type 0

(II) RADEON(0): Monitor1 EDID data ---------------------------
(II) RADEON(0): Manufacturer: APP  Model: 9c20  Serial#: 16843009
(II) RADEON(0): Year: 2002  Week: 5
(II) RADEON(0): EDID Version: 1.3
(II) RADEON(0): Digital Display Input
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 32  vert.: 22
(II) RADEON(0): Gamma: 2.20
(II) RADEON(0): No DPMS capabilities specified; RGB/Color Display
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): redX: 0.600 redY: 0.350   greenX: 0.310 greenY: 0.550
(II) RADEON(0): blueX: 0.150 blueY: 0.115   whiteX: 0.320 whiteY: 0.330
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 79.8 MHz   Image Size:  321 x 214 mm
(II) RADEON(0): h_active: 1280  h_sync: 1296  h_sync_end 1408 h_blank_end 1536 
h_border: 0
(II) RADEON(0): v_active: 854  v_sync: 855  v_sync_end 858 v_blanking: 866 
v_border: 0
(II) RADEON(0):  LTN152W3
(II) RADEON(0):  LTN152W3
(II) RADEON(0): Monitor name: Color LCD
(II) RADEON(0): End of Monitor1 EDID data --------------------
(II) RADEON(0): 
(II) RADEON(0): Primary Display == Type 2
(**) RADEON(0): Using gamma correction (1.2, 1.2, 1.2)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Panel size found from DDC: 1280x854
(II) RADEON(0): Valid Mode from Detailed timing table: 1280x854
(II) RADEON(0): Total of 1 mode(s) found.
(II) RADEON(0): Total number of valid DDC mode(s) found: 1
(II) RADEON(0): Valid mode using on-chip RMX: 1280x854
(II) RADEON(0): Valid mode using on-chip RMX: 1152x768
(II) RADEON(0): Valid mode using on-chip RMX: 1026x684
(II) RADEON(0): Valid mode using on-chip RMX: 900x600
(II) RADEON(0): Valid mode using on-chip RMX: 801x534
(II) RADEON(0): Valid mode using on-chip RMX: 720x480
(II) RADEON(0): Valid mode using on-chip RMX: 642x428
(II) RADEON(0): Total number of valid FP mode(s) found: 7
(--) RADEON(0): Virtual size is 1280x854 (pitch 1280)
(**) RADEON(0): *Mode "1280x854": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "1280x854"   79.81  1280 1296 1408 1536  854 855 858 
866
(**) RADEON(0): *Mode "1152x768": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "1152x768"   79.81  1152 1296 1408 1536  768 855 858 
866
(**) RADEON(0): *Mode "1026x684": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "1026x684"   79.81  1026 1296 1408 1536  684 855 858 
866
(**) RADEON(0): *Mode "900x600": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "900x600"   79.81  900 1296 1408 1536  600 855 858 
866
(**) RADEON(0): *Mode "801x534": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "801x534"   79.81  801 1296 1408 1536  534 855 858 
866
(**) RADEON(0): *Mode "720x480": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "720x480"   79.81  720 1296 1408 1536  480 855 858 
866
(**) RADEON(0): *Mode "642x428": 79.8 MHz (scaled from 0.0 MHz), 52.0 kHz, 
60.0 Hz
(II) RADEON(0): Modeline "642x428"   79.81  642 1296 1408 1536  428 855 858 
866
(**) RADEON(0):  Default mode "640x350": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x350"   79.81  640 1296 1408 1536  350 855 858 
866
(**) RADEON(0):  Default mode "640x400": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x400"   79.81  640 1296 1408 1536  400 855 858 
866
(**) RADEON(0):  Default mode "720x400": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "720x400"   79.81  720 1296 1408 1536  400 855 858 
866
(**) RADEON(0):  Default mode "640x480": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   79.81  640 1296 1408 1536  480 855 858 
866
(**) RADEON(0):  Default mode "800x600": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "800x600"   79.81  800 1296 1408 1536  600 855 858 
866
(**) RADEON(0):  Default mode "1024x768": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   79.81  1024 1296 1408 1536  768 855 858 
866
(**) RADEON(0):  Default mode "832x624": 79.8 MHz (scaled from 0.0 MHz), 52.0 
kHz, 60.0 Hz
(II) RADEON(0): Modeline "832x624"   79.81  832 1296 1408 1536  624 855 858 
866
(++) RADEON(0): DPI set to (100, 100)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(**) RADEON(0): Using AGP 4x mode
(II) RADEON(0): AGP Fast Write disabled by default
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="The XFree86 Project"
	compiled for 4.3.99.9, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping enabled
(!!) RADEON(0): For information on using the multimedia capabilities
 of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xb0000000 - 0xb000ffff (0x10000) MX[B]
	[1] 0	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B]
	[2] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[3] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[4] -1	0	0xf5000000 - 0xf5000fff (0x1000) MX[B]
	[5] -1	0	0xa0001000 - 0xa0001fff (0x1000) MX[B]
	[6] -1	0	0xa0002000 - 0xa0002fff (0x1000) MX[B]
	[7] -1	0	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[8] -1	0	0xb0020000 - 0xb003ffff (0x20000) MX[B](B)
	[9] -1	0	0xb0000000 - 0xb000ffff (0x10000) MX[B](B)
	[10] -1	0	0xb8000000 - 0xbfffffff (0x8000000) MX[B](B)
	[11] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[12] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[13] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[14] 0	0	0x00000400 - 0x000004ff (0x100) IX[B]
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[17] -1	0	0x00000400 - 0x000004ff (0x100) IX[B](B)
	[18] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[19] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:16:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe3006000
(II) RADEON(0): [drm] mapped SAREA 0xe3006000 to 0x320e7000
(II) RADEON(0): [drm] framebuffer handle = 0xb8000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x07000207 [AGP 0x106b/0x002d; Card 0x1002/0x4c57]
(II) RADEON(0): [agp] 16384 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0x00000000
(II) RADEON(0): [agp] Ring mapped at 0x320e9000
(II) RADEON(0): [agp] ring read ptr handle = 0x00101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0x321ea000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0x00102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0x321eb000
(II) RADEON(0): [agp] AGP texture map handle = 0x00302000
(II) RADEON(0): [agp] AGP Texture map mapped at 0x323eb000
(II) RADEON(0): [drm] register handle = 0xb0000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 16 MB AGP aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 13 MB for AGP textures
(II) RADEON(0): Memory manager initialized to (0,0) (1280,6553)
(II) RADEON(0): Reserved area from (0,854) to (1280,856)
(II) RADEON(0): Largest offscreen area available: 1280 x 5697
(II) RADEON(0): Will use back buffer at offset 0x85c000
(II) RADEON(0): Will use depth buffer at offset 0xc88000
(II) RADEON(0): Will use 15616 kb for textures at offset 0x10c0000
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 856)
(II) RADEON(0): Largest offscreen area available: 1280 x 5693
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(WW) RADEON(0): Option "DRIReinit" is not used
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 48
(II) RADEON(0): [drm] Initialized kernel agp heap manager, 13369344
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
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
(II) Initializing built-in extension RANDR
(EE) RADEON(0): FBIOPAN_DISPLAY: Invalid argument
(II) Keyboard "Keyboard0" handled by legacy driver
(**) Option "Protocol" "IMPS/2"
(**) Mouse1: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(**) Option "Device" "/dev/usbmouse"
(**) Option "Emulate3Buttons"
(**) Option "Emulate3Timeout" "50"
(**) Mouse1: Emulate3Buttons, Emulate3Timeout: 50
(==) Mouse1: Buttons: 3
(II) Keyboard "Keyboard1" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
(II) Mouse1: ps2EnableDataReporting: succeeded
SetClientVersion: 0 8
