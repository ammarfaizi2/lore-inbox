Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCHMH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCHMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCHMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:07:26 -0500
Received: from web30907.mail.mud.yahoo.com ([68.142.200.160]:30143 "HELO
	web30907.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262069AbVCHL7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:59:49 -0500
Message-ID: <20050308115944.48183.qmail@web30907.mail.mud.yahoo.com>
Date: Tue, 8 Mar 2005 03:59:44 -0800 (PST)
From: Lobiuc Andrei <alobiuc@yahoo.com>
Subject: Re: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dave Airlie <airlied@gmail.com> wrote:
> On Sun, 6 Mar 2005 09:49:32 -0800 (PST), Lobiuc
> Andrei
> <alobiuc@yahoo.com> wrote:
> > 1.Radeon card displays incorrectly under the
> 2.6.11
> > version unless compiled with SMP support.
> > 2.After compiling and installing the 2.6.11 kernel
> > version, my ASUS Radeon 9200SE 128 MB graphic card
> > does not display correctly in plain VGA mode. The
> same
> > card has no problem with the 2.6.10 kernel.
> > Regarding radeonfb, dmesg reports:
> > "radeonfb_pci_register BEGIN
> > ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16
> (level,
> > low) -> IRQ 169
> > radeonfb (0000:01:00.0): Found 131072k of DDR 64
> bits
> > wide videoram
> > radeonfb (0000:01:00.0): mapped 16384k videoram
> > radeonfb: Found Intel x86 BIOS ROM Image
> > radeonfb: Retreived PLL infos from BIOS
> > radeonfb: Reference=27.00 MHz (RefDiv=12)
> > Memory=200.00 Mhz, System=166.00 MHz
> > radeonfb: PLL min 20000 max 40000
> > 1 chips in connector info
> >  - chip 1 has 1 connectors
> >   * connector 0 of type 2 (CRT) : 2300
> > Starting monitor auto detection...
> > radeonfb: I2C (port 1) ... not found
> > radeonfb: I2C (port 2) ... not found
> > radeonfb: I2C (port 3) ... found CRT display
> > radeonfb: I2C (port 4) ... not found
> > radeonfb: I2C (port 2) ... not found
> > radeonfb: I2C (port 4) ... not found
> > radeonfb: I2C (port 3) ... found CRT display
> > radeonfb: Monitor 1 type CRT found
> > radeonfb: EDID probed
> > radeonfb: Monitor 2 type no found
> > hStart = 737, hEnd = 808, hTotal = 896
> > vStart = 401, vEnd = 404, vTotal = 417
> > h_total_disp = 0x59006f    hsync_strt_wid =
> 0x8802eb
> > v_total_disp = 0x18f01a0           vsync_strt_wid
> =
> > 0x830190
> > pixclock = 38210
> > freq = 2617
> > freq = 2617, PLL min = 20000, PLL max = 40000
> > ref_div = 12, ref_clk = 2700, output_freq = 20936
> > ref_div = 12, ref_clk = 2700, output_freq = 20936
> > post div = 0x3
> > fb_div = 0x5d
> > ppll_div_3 = 0x3005d
> > Console: switching to colour frame buffer device
> 90x25
> > radeonfb (0000:01:00.0): ATI Radeon Yd
> > radeonfb_pci_register END
> > kobject_register failed for radeonfb (-17)
> >  [<c01cf0c7>] kobject_register+0x57/0x60
> >  [<c0262707>] bus_add_driver+0x57/0xd0
> >  [<c0262d5f>] driver_register+0x2f/0x40
> >  [<c01db547>] pci_create_newid_file+0x27/0x30
> >  [<c01dba42>] pci_register_driver+0x62/0x80
> >  [<c05b3b40>] radeonfb_old_init+0x40/0x50
> >  [<c059c7fb>] do_initcalls+0x2b/0xc0
> >  [<c01002c0>] init+0x0/0x110
> >  [<c01002c0>] init+0x0/0x110
> >  [<c01002ef>] init+0x2f/0x110
> >  [<c010086c>] kernel_thread_helper+0x0/0x14
> >  [<c0100871>] kernel_thread_helper+0x5/0x14
> > isapnp: Scanning for PnP cards...
> > isapnp: No Plug & Play device found
> > Linux agpgart interface v0.100 (c) Dave Jones
> > [drm] Initialized drm 1.0.0 20040925
> > ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16
> (level,
> > low) -> IRQ 169
> > [drm] Initialized radeon 1.14.0 20050125 on minor
> 0:
> > ATI Technologies Inc RV280[Radeon 9200 SE]"
> > 
> 
> It looks like you have no agpgart chipset driver
> loaded or if DRM is
> in the kernel, the agpgart chipset driver should be
> to...
> 
> Dave.
> 

Meanwhile I did another compile with AGP support
enabled, dmesg says now:
"radeonfb_pci_register BEGIN
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level,
low) -> IRQ 11
radeonfb (0000:01:00.0): Found 131072k of DDR 64 bits
wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12)
Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 737, hEnd = 808, hTotal = 896
vStart = 401, vEnd = 404, vTotal = 417
h_total_disp = 0x59006f    hsync_strt_wid = 0x8802eb
v_total_disp = 0x18f01a0           vsync_strt_wid =
0x830190
pixclock = 38210
freq = 2617
freq = 2617, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 20936
ref_div = 12, ref_clk = 2700, output_freq = 20936
post div = 0x3
fb_div = 0x5d
ppll_div_3 = 0x3005d
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon Yd
radeonfb_pci_register END
kobject_register failed for radeonfb (-17)
 [<c020b047>] kobject_register+0x57/0x60
 [<c029c607>] bus_add_driver+0x57/0xd0
 [<c029cc5f>] driver_register+0x2f/0x40
 [<c02145c7>] pci_create_newid_file+0x27/0x30
 [<c0214ac2>] pci_register_driver+0x62/0x80
 [<c051de00>] radeonfb_old_init+0x40/0x50
 [<c050e79b>] do_initcalls+0x2b/0xc0
 [<c01002c0>] init+0x0/0x110
 [<c01002c0>] init+0x0/0x110
 [<c01002ea>] init+0x2a/0x110
 [<c010086c>] kernel_thread_helper+0x0/0x14
 [<c0100871>] kernel_thread_helper+0x5/0x14
vesafb: abort, cannot reserve video memory at
0xd8000000
vesafb: framebuffer at 0xd8000000, mapped to
0xe1900000, using 937k, total 16384k
vesafb: mode is 800x600x8, linelength=800, pages=31
vesafb: protected mode interface info at c000:556c
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
fb1: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (52 C)
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory:
439M
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level,
low) -> IRQ 11
[drm] Initialized radeon 1.14.0 20050125 on minor 0:
ATI Technologies Inc RV280[Radeon 9200 SE]"

and

"agpgart: Found an AGP 3.5 compliant device at
0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x
mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x
mode
[drm] Loading R200 Microcode"

but there's no improvement in displaying the text.
Here are parts of the .config file used:
<.config>
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11
# Sun Mar  6 12:04:27 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
..........................
#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=m
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_SCx200_ACB=m
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM90=m

#
# Other I2C Chip support
#
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
........................................
#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON_OLD=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y
</.config>

The big question is why is it working under 2.6.10?
Even if I configure 2.6.11 with 'make oldconfig' using
the 2.6.10 .config file brings no improvements.

Are there any patches I haven't heard of?

Thank you very much for your reply.
Regards, Andrei Lobiuc.



	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
