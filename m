Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUAALYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 06:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbUAALYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 06:24:50 -0500
Received: from guri.is.scarlet.be ([193.74.71.22]:22744 "EHLO
	guri.is.scarlet.be") by vger.kernel.org with ESMTP id S261193AbUAALYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 06:24:36 -0500
Message-ID: <20040101122313.qjx7h3k8g4s4484s@albert.homedns.org>
X-Priority: 3 (Normal)
Date: Thu,  1 Jan 2004 12:23:13 +0100
From: Kristof Pelckmans <kristof.pelckmans@antwerpen.be>
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org
Subject: 2.6.0 framebuffer Matrox
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to get the matroxfb working on the second head of the G450, but I
get the impression that the second head is a duplication of the first :
- when I do con2fb /dev/fb1 /dev/tty1, my cursor disappears on the second head
instead of getting focus
- when I start X using the framebuffer device, I get a black screen
- when using fbset (I know that I'm not supposed to, but...) only fbset -
fb /dev/fb0 myScheme seems to have effect, fbset -fb /dev/fb1 myOtherScheme
does nothing

The second head worked flawlessly in 2.4.20-r8. I also tried 2.4.22-r2, but
does not work either. I do not know if it has anything to do with it, but I am
still using devfs. I got the impression that /dev/fb0 and /dev/fb1 are
correctly symlinked...

Is there anyone who is using the second head of the Matrox G450 on 2.4.6 ? This
is really stopping me from migrating...

Best regards,

Kristof

- Some info -
lspci -v :
03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)
(prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e9000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

grub.conf (2.6.0) :
kernel=(hd0,0)/boot/bzImage root=/dev/hda3
video=matroxfb:nopan,depth:16,xres:952,yres:519,pixclock:26936,left:98,right:248
,upper:10,lower:12,hs
len:22,vslen:22

.config (2.4.20-r8) :
#2.4.20-r8
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_LOGO_TUX is not set
# CONFIG_FB_LOGO_LARRY is not set
# CONFIG_FB_LOGO_GENTOO is not set
CONFIG_FB_LOGO_G=y
# CONFIG_FB_LOGO_PENGUIN is not set
# CONFIG_FB_LOGO_POWEREDBY is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=y
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_MATROX_MAVEN is not set
CONFIG_FB_MATROX_G450=y
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_SPLASHSCREEN is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

.config (2.6.0) :
#2.4.60
#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_LOGO_TUX is not set
# CONFIG_FB_LOGO_LARRY is not set
# CONFIG_FB_LOGO_GENTOO is not set
CONFIG_FB_LOGO_G=y
# CONFIG_FB_LOGO_PENGUIN is not set
# CONFIG_FB_LOGO_POWEREDBY is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=y
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_MATROX_MAVEN is not set
CONFIG_FB_MATROX_G450=y
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_SPLASHSCREEN is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

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

XF86Config :
Section "Device"
        Identifier "Matrox Millenium G450 fb head 2"
        Driver "fbdev"
        VendorName "Matrox Millennium G450"
        BoardName "Matrox Millennium G450"
        Option "fbdev" "/dev/fb1"
EndSection

Section "Screen"
    Identifier  "Monitor fb screen head 2"
    Device      "Matrox Millenium G450 fb head 2"
    Monitor     "Dell P1110"

    Subsection "Display"
        Depth       24
        Modes       "optimal"
        ViewPort    0 0
    EndSubsection
EndSection

Section "ServerLayout"
        Identifier "MonitorHead2"
        Screen "Monitor fb screen head 2"
        InputDevice "Mouse1" "CorePointer"
        InputDevice "Keyboard1" "CoreKeyboard"
EndSection

XFree86.0.log :
XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.20-gentoo-r6 i686 [ELF]
Build Date: 14 September 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Dec 31 15:28:31 2003
(==) Using config file: "/etc/X11/XF86Config"
(++) ServerLayout "MonitorHead2"
(**) |-->Screen "Monitor fb screen head 2" (0)
(**) |   |-->Monitor "Dell P1110"
(**) |   |-->Device "Matrox Millenium G450 fb head 2"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "be"
(**) XKB: layout: "be"
(==) Keyboard: CustomKeycode disabled
(WW) `fonts.dir' not found (or not valid)
in "/usr/X11R6/lib/X11/fonts/freefont/".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/usr/X11R6/lib/X11/fonts/freefont/").
(**) FontPath set
to "/usr/X11R6/lib/X11/fonts/misc/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:uns
caled,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/misc/,/u
sr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X1
1/fonts/local/,/usr/X11R6/lib/X11/fonts/truetype/,/usr/X11R6/lib/X11/fonts/100dp
i/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/local/share/fonts/ttfonts/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(**) Option "DisableModInDev"
(**) Option "BlankTime" "0"
(**) Option "NoPM" "true"
(**) Option "Xinerama" "false"
(++) using VT number 7

(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.6
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 10de,01e0 card 1043,80ac rev c1 class 06,00,00 hdr 80
(II) PCI: 00:00:1: chip 10de,01eb card 10de,0c17 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:2: chip 10de,01ee card 10de,0c17 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:3: chip 10de,01ed card 10de,0c17 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:4: chip 10de,01ec card 10de,0c17 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:5: chip 10de,01ef card 10de,0c17 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:01:0: chip 10de,0060 card 1043,80ad rev a4 class 06,01,00 hdr 80
(II) PCI: 00:01:1: chip 10de,0064 card 1043,0c11 rev a2 class 0c,05,00 hdr 80
(II) PCI: 00:02:0: chip 10de,0067 card 1043,0c11 rev a4 class 0c,03,10 hdr 80
(II) PCI: 00:02:1: chip 10de,0067 card 1043,0c11 rev a4 class 0c,03,10 hdr 80
(II) PCI: 00:02:2: chip 10de,0068 card 1043,0c11 rev a4 class 0c,03,20 hdr 80
(II) PCI: 00:05:0: chip 10de,006b card 1043,0c11 rev a2 class 04,01,00 hdr 00
(II) PCI: 00:06:0: chip 10de,006a card 1043,8095 rev a1 class 04,01,00 hdr 00
(II) PCI: 00:08:0: chip 10de,006c card 0000,0000 rev a3 class 06,04,00 hdr 01
(II) PCI: 00:09:0: chip 10de,0065 card 1043,0c11 rev a2 class 01,01,8a hdr 00
(II) PCI: 00:0c:0: chip 10de,006d card 0000,0000 rev a3 class 06,04,00 hdr 01
(II) PCI: 00:1e:0: chip 10de,01e8 card 0000,0000 rev c1 class 06,04,00 hdr 01
(II) PCI: 01:08:0: chip 109e,036e card 0070,13eb rev 11 class 04,00,00 hdr 80
(II) PCI: 01:08:1: chip 109e,0878 card 0070,13eb rev 11 class 04,80,00 hdr 80
(II) PCI: 01:0a:0: chip 1412,1712 card 1412,d638 rev 02 class 04,01,00 hdr 00
(II) PCI: 02:01:0: chip 10b7,9201 card 1043,80ab rev 40 class 02,00,00 hdr 00
(II) PCI: 03:00:0: chip 102b,0525 card 102b,0641 rev 82 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,3), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:1:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:8:0), (0,1,1), BCTRL: 0x0202 (VGA_EN is cleared)
(II) Bus 1 I/O range:
	[0] -1	0	0x0000c000 - 0x0000cfff (0x1000) IX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xeb000000 - 0xebffffff (0x1000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:12:0), (0,2,2), BCTRL: 0x0002 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x0000d000 - 0x0000dfff (0x1000) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xe6000000 - 0xe7ffffff (0x2000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 3: bridge is at (0:30:0), (0,3,3), BCTRL: 0x000a (VGA_EN is set)
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0	0xe8000000 - 0xeaffffff (0x3000000) MX[B]
(II) Bus 3 prefetchable memory range:
	[0] -1	0	0xe4000000 - 0xe5ffffff (0x2000000) MX[B]
(--) PCI: (1:8:0) Brooktree Corporation Bt878 Video Capture rev 17, Mem @
0xeb000000/12
(--) PCI:*(3:0:0) Matrox Graphics, Inc. MGA G400 AGP rev 130, Mem @
0xe4000000/25, 0xe8000000/14, 0xe9000000/23
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
(II) PCI Memory resource overlap reduced 0xe0000000 from 0xe3ffffff to
0xdfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xe7000000 - 0xe700007f (0x80) MX[B]
	[1] -1	0	0xeb001000 - 0xeb001fff (0x1000) MX[B]
	[2] -1	0	0xec083000 - 0xec083fff (0x1000) MX[B]
	[3] -1	0	0xec000000 - 0xec07ffff (0x80000) MX[B]
	[4] -1	0	0xec081000 - 0xec0810ff (0x100) MX[B]
	[5] -1	0	0xec080000 - 0xec080fff (0x1000) MX[B]
	[6] -1	0	0xec082000 - 0xec082fff (0x1000) MX[B]
	[7] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[8] -1	0	0xe9000000 - 0xe97fffff (0x800000) MX[B](B)
	[9] -1	0	0xe8000000 - 0xe8003fff (0x4000) MX[B](B)
	[10] -1	0	0xe4000000 - 0xe5ffffff (0x2000000) MX[B](B)
	[11] -1	0	0xeb000000 - 0xeb000fff (0x1000) MX[B](B)
	[12] -1	0	0x0000d000 - 0x0000d07f (0x80) IX[B]
	[13] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[14] -1	0	0x0000c800 - 0x0000c80f (0x10) IX[B]
	[15] -1	0	0x0000c400 - 0x0000c40f (0x10) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c01f (0x20) IX[B]
	[17] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[18] -1	0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[19] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[20] -1	0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xe7000000 - 0xe700007f (0x80) MX[B]
	[1] -1	0	0xeb001000 - 0xeb001fff (0x1000) MX[B]
	[2] -1	0	0xec083000 - 0xec083fff (0x1000) MX[B]
	[3] -1	0	0xec000000 - 0xec07ffff (0x80000) MX[B]
	[4] -1	0	0xec081000 - 0xec0810ff (0x100) MX[B]
	[5] -1	0	0xec080000 - 0xec080fff (0x1000) MX[B]
	[6] -1	0	0xec082000 - 0xec082fff (0x1000) MX[B]
	[7] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[8] -1	0	0xe9000000 - 0xe97fffff (0x800000) MX[B](B)
	[9] -1	0	0xe8000000 - 0xe8003fff (0x4000) MX[B](B)
	[10] -1	0	0xe4000000 - 0xe5ffffff (0x2000000) MX[B](B)
	[11] -1	0	0xeb000000 - 0xeb000fff (0x1000) MX[B](B)
	[12] -1	0	0x0000d000 - 0x0000d07f (0x80) IX[B]
	[13] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[14] -1	0	0x0000c800 - 0x0000c80f (0x10) IX[B]
	[15] -1	0	0x0000c400 - 0x0000c40f (0x10) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c01f (0x20) IX[B]
	[17] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[18] -1	0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[19] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[20] -1	0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xe7000000 - 0xe700007f (0x80) MX[B]
	[6] -1	0	0xeb001000 - 0xeb001fff (0x1000) MX[B]
	[7] -1	0	0xec083000 - 0xec083fff (0x1000) MX[B]
	[8] -1	0	0xec000000 - 0xec07ffff (0x80000) MX[B]
	[9] -1	0	0xec081000 - 0xec0810ff (0x100) MX[B]
	[10] -1	0	0xec080000 - 0xec080fff (0x1000) MX[B]
	[11] -1	0	0xec082000 - 0xec082fff (0x1000) MX[B]
	[12] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[13] -1	0	0xe9000000 - 0xe97fffff (0x800000) MX[B](B)
	[14] -1	0	0xe8000000 - 0xe8003fff (0x4000) MX[B](B)
	[15] -1	0	0xe4000000 - 0xe5ffffff (0x2000000) MX[B](B)
	[16] -1	0	0xeb000000 - 0xeb000fff (0x1000) MX[B](B)
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x0000d000 - 0x0000d07f (0x80) IX[B]
	[20] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[21] -1	0	0x0000c800 - 0x0000c80f (0x10) IX[B]
	[22] -1	0	0x0000c400 - 0x0000c40f (0x10) IX[B]
	[23] -1	0	0x0000c000 - 0x0000c01f (0x20) IX[B]
	[24] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[25] -1	0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[26] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[27] -1	0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
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
	compiled for 4.3.0, module version = 2.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.1
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "fbdev"
(II) Loading /usr/X11R6/lib/modules/drivers/fbdev_drv.o
(II) Module fbdev: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) FBDEV: driver for framebuffer: fbdev, afb
(II) Primary Device is: PCI 03:00:0
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 0.0.2
	ABI class: XFree86 Video Driver, version 0.6
(II) FBDEV(0): using /dev/fb1
(II) Running in FRAMEBUFFER Mode
(==) FBDEV(0): Depth 24, (==) framebuffer bpp 32
(==) FBDEV(0): RGB weight 888
(==) FBDEV(0): Default visual is TrueColor
(==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDEV(0): Hardware: MATROX DH (vidmem: 8192k)
(**) FBDEV(0): Option "fbdev" "/dev/fb1"
(II) FBDEV(0): Checking Modes against framebuffer device...
(II) FBDEV(0): 	mode "optimal" ok
(II) FBDEV(0): Checking Modes against monitor...
(--) FBDEV(0): Virtual size is 1280x1024 (pitch 1280)
(**) FBDEV(0):  Mode "optimal": 157.5 MHz (scaled from 0.0 MHz), 91.1 kHz, 85.0
Hz
(II) FBDEV(0): Modeline "optimal"  157.50  1280 1344 1504 1728  1024 1025 1028
1072 +hsync +vsync
(==) FBDEV(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(**) FBDEV(0): Using "Shadow Framebuffer"
(II) Loading sub module "shadow"
(II) LoadModule: "shadow"
(II) Loading /usr/X11R6/lib/modules/libshadow.a
(II) Module shadow: vendor="The XFree86 Project"
	compiled for 4.3.0, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(--) Depth 24 pixmap format is 32 bpp
(==) FBDEV(0): Backing store disabled
(**) Option "dpms"
(**) FBDEV(0): DPMS enabled
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
(EE) FBDEV(0): FBIOPAN_DISPLAY: Invalid argument
(**) Option "Protocol" "IMPS/2"
(**) Mouse1: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "no"
(**) Option "ZAxisMapping" "4 5"
(**) Mouse1: ZAxisMapping: buttons 4 and 5
(**) Mouse1: Buttons: 5
(II) Keyboard "Keyboard1" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
(II) Mouse1: ps2EnableDataReporting: succeeded

