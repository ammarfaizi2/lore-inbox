Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSGHLHP>; Mon, 8 Jul 2002 07:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGHLHO>; Mon, 8 Jul 2002 07:07:14 -0400
Received: from mail.hot.ee ([194.126.101.94]:29702 "EHLO relay1.hot.ee")
	by vger.kernel.org with ESMTP id <S316845AbSGHLHI>;
	Mon, 8 Jul 2002 07:07:08 -0400
Message-ID: <3D2980EF.3020306@hot.ee>
Date: Mon, 08 Jul 2002 14:09:19 +0200
From: digital_boy <chlor@hot.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: ru, et, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.25 - problem with r128
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PIII Rage128 Xpert128
Slackware8.1
X4.2.0
gcc-3.1
---------------------
agpgart - as a module
r128    - as a module
---------------------
when compiling
r128.o
r128_v.o
r128_cce.o
r128_state.o

I see many warnings like this:

128_state.c:1502: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1512: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1512: warning: deprecated use of label at end of compound
statement
r128_state.c: In function `r128_cce_indirect':
r128_state.c:1533: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1536: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1546: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1550: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1559: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1563: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1569: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1573: warning: concatenation of string literals with
__FUNCTION__ is deprecated
r128_state.c:1573: warning: deprecated use of label at end of compound
statement
    ld -m elf_i386  -r -o r128.o r128_drv.o r128_cce.o r128_state.o
    make[3]: Leaving directory `/usr/src/linux-2.5.25/drivers/char/drm'
    make[2]: Leaving directory `/usr/src/linux-2.5.25/drivers/char'
-------------------------------------------------------------------

After the boot all seems normal, but when i start XWin, system stops 
responding.
Here some logs:

XFree86.0.log
-------
-skipped

(II) ATI:  Candidate "Device" section "DefCard".
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Rage 128 RF (AGP) found
(II) Loading sub module "r128"
(II) LoadModule: "r128"
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.5
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0xee000000 - 0xee0000ff (0x100) MX[B]
	[6] -1	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[7] -1	0xed000000 - 0xed003fff (0x4000) MX[B](B)
	[8] -1	0xe8000000 - 0xebffffff (0x4000000) MX[B](B)
	[9] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[11] -1	0x00007000 - 0x000070ff (0x100) IX[B]
	[12] -1	0x00006c00 - 0x00006c1f (0x20) IX[B]
	[13] -1	0x00006800 - 0x0000683f (0x40) IX[B]
	[14] -1	0x00006400 - 0x0000641f (0x20) IX[B]
	[15] -1	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[16] -1	0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
(II) resource ranges after probing:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0xee000000 - 0xee0000ff (0x100) MX[B]
	[6] -1	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[7] -1	0xed000000 - 0xed003fff (0x4000) MX[B](B)
	[8] -1	0xe8000000 - 0xebffffff (0x4000000) MX[B](B)
	[9] 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[10] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[11] 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[12] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0x00007000 - 0x000070ff (0x100) IX[B]
	[15] -1	0x00006c00 - 0x00006c1f (0x20) IX[B]
	[16] -1	0x00006800 - 0x0000683f (0x40) IX[B]
	[17] -1	0x00006400 - 0x0000641f (0x20) IX[B]
	[18] -1	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[19] -1	0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
	[20] 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[21] 0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.5
(II) R128(0): PCI bus 1 card 0 func 0
(**) R128(0): Depth 24, (--) framebuffer bpp 32
(II) R128(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) R128(0): Default visual is TrueColor
(**) R128(0): Option "AGPMode" "1"
(==) R128(0): RGB weight 888
(II) R128(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.5
(II) R128(0): initializing int10
(II) R128(0): Primary V_BIOS segment is: 0xc000
(--) R128(0): Chipset: "ATI Rage 128 RF (AGP)" (ChipID = 0x5246)
(--) R128(0): Linear framebuffer at 0xe8000000
(--) R128(0): MMIO registers at 0xed000000
(II) R128(0): Video RAM override, using 16384 kB instead of 16384 kB
(**) R128(0): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(WW) R128(0): Can't determine panel dimensions, and none specified. 		 
         Disabling programming of FP registers.
(II) R128(0): PLL parameters: rf=2950 rd=65 min=12500 max=25000; xclk=9000
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.5
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.5

-end
------ This is end of the log here it stops responding...

messages:

-skipped

Jul  8 13:47:39 localhost kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Jul  8 13:47:39 localhost kernel: agpgart: Maximum main memory to use 
for agp memory: 96M
Jul  8 13:47:39 localhost kernel: agpgart: Detected Intel 440BX chipset
Jul  8 13:47:39 localhost kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Jul  8 13:47:40 localhost kernel: [drm] AGP 0.99 on Intel 440BX @ 
0xe0000000 128MB
Jul  8 13:47:40 localhost kernel: [drm] Initialized r128 2.2.0 20010917 
on minor 0

-skipped
----------------------------------------------------------------------
I'm posting first time, sorry if something is wrong. :)
And sorry for my english. :)






