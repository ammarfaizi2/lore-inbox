Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUC1RHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUC1RHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:07:10 -0500
Received: from pop.gmx.net ([213.165.64.20]:13786 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262022AbUC1RGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:06:23 -0500
X-Authenticated: #1189245
Message-ID: <40670608.3090206@gmx.net>
Date: Sun, 28 Mar 2004 19:06:16 +0200
From: Carsten Menke <bootsy52@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6] No PS/2 keyboard/mouse under XFree86
Content-Type: multipart/mixed;
 boundary="------------020705010009020208060603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705010009020208060603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've searched google and the linux-kernel archives to death and no 
solution seems to meet my problem.
Also I read Documentation/README, Changes, filesystems/devfs. Please 
find attached the kernel config and dmesg.

So I hope someone on the list could explain me what's going on. The 
problem is that with every 2.6.x release so far
(tested from 2.6.0 - 2.6.5-rc2) I don't get my PS/2 Keyboard and Mouse 
(Mouse and Keybard are connected with the PS/2 adapter)
to work under X. I have a KVM attached if that may be of interest.
The keyboard is a Microsoft Natural Keyboard Pro, the mouse is Microsoft 
Optical Wheel Mouse.

Symptom: Keyboard works in console mode as soon as I start X I see the 
mouse pointer  (I don't use GPM) but the mouse doesn't move.
Sometimes I got the keyboard to work, but I found out that switching to 
console via <ALT>+<STRG>+F1 and back also freezes the keyboard,
if it is not already freezed by the startup of X, which is most of the 
time the case.
However the system does not seem, to be completly locked up, as the 
clock is moving on.

XFree86 is at version 4.4.0 and the section describing the mouse in 
XF86Config-4 is as follows:


Section "InputDevice"
         Identifier "Mouse"
         Option "Protocol" "IMPS/2"
         Option "Device" "/dev/misc/psaux"
         Driver "mouse"
         Option "ZAxisMapping" "4 5"
EndSection

as you may guess I use devfs and devfsd. I also tried /dev/input/mouse0 
and /dev/input/mice all with the same result.
I used gcc-3.3.3 to compile the kernel. Please let me know if you need 
more info describing the problem. I've attached dmesg and the
.config

Thanx for all your help

Carsten

--------------020705010009020208060603
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Mar 27 23:10:05 main kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar 27 23:10:05 main kernel: Inspecting /boot/System.map-2.6.5-rc2
Mar 27 23:10:06 main kernel: Loaded 26835 symbols from /boot/System.map-2.6.5-rc2.
Mar 27 23:10:06 main kernel: Symbols match kernel version 2.6.5.
Mar 27 23:10:06 main kernel: No module symbols loaded - kernel modules not enabled. 
Mar 27 23:10:06 main kernel: Linux version 2.6.5-rc2 (root@Bootsy) (gcc version 3.3.3) #2 Sat Mar 27 23:07:22 CET 2004
Mar 27 23:10:06 main kernel: BIOS-provided physical RAM map:
Mar 27 23:10:06 main kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 27 23:10:06 main kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 27 23:10:06 main kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar 27 23:10:06 main kernel:  BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
Mar 27 23:10:06 main kernel:  BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
Mar 27 23:10:06 main kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Mar 27 23:10:06 main kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Mar 27 23:10:06 main kernel: 511MB LOWMEM available.
Mar 27 23:10:06 main kernel: On node 0 totalpages: 131068
Mar 27 23:10:06 main kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar 27 23:10:06 main kernel:   Normal zone: 126972 pages, LIFO batch:16
Mar 27 23:10:06 main kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar 27 23:10:06 main kernel: DMI 2.3 present.
Mar 27 23:10:06 main kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f62d0
Mar 27 23:10:06 main kernel: ACPI: RSDT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc000
Mar 27 23:10:06 main kernel: ACPI: FADT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc080
Mar 27 23:10:06 main kernel: ACPI: BOOT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc040
Mar 27 23:10:06 main kernel: ACPI: DSDT (v001   ASUS MED_2001 0x00001000 MSFT 0x0100000b) @ 0x00000000
Mar 27 23:10:06 main kernel: Built 1 zonelists
Mar 27 23:10:06 main kernel: Kernel command line: BOOT_IMAGE=2.6.5-rc2 ro root=308 hdc=ide-scsi max_scsi_luns=1
Mar 27 23:10:06 main kernel: ide_setup: hdc=ide-scsi
Mar 27 23:10:06 main kernel: Local APIC disabled by BIOS -- reenabling.
Mar 27 23:10:06 main kernel: Found and enabled local APIC!
Mar 27 23:10:06 main kernel: Initializing CPU#0
Mar 27 23:10:06 main kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Mar 27 23:10:06 main kernel: Detected 902.644 MHz processor.
Mar 27 23:10:06 main kernel: Using tsc for high-res timesource
Mar 27 23:10:06 main kernel: Console: colour dummy device 80x25
Mar 27 23:10:06 main kernel: Memory: 515260k/524272k available (2051k kernel code, 8264k reserved, 705k data, 144k init, 0k highmem)
Mar 27 23:10:06 main kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mar 27 23:10:06 main kernel: Calibrating delay loop... 1769.47 BogoMIPS
Mar 27 23:10:06 main kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 27 23:10:06 main kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mar 27 23:10:06 main kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mar 27 23:10:06 main kernel: CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
Mar 27 23:10:06 main kernel: CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
Mar 27 23:10:06 main kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 27 23:10:06 main kernel: CPU: L2 cache: 256K
Mar 27 23:10:06 main kernel: CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Mar 27 23:10:06 main kernel: Intel machine check architecture supported.
Mar 27 23:10:06 main kernel: Intel machine check reporting enabled on CPU#0.
Mar 27 23:10:06 main kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Mar 27 23:10:06 main kernel: Enabling fast FPU save and restore... done.
Mar 27 23:10:06 main kernel: Enabling unmasked SIMD FPU exception support... done.
Mar 27 23:10:06 main kernel: Checking 'hlt' instruction... OK.
Mar 27 23:10:06 main kernel: POSIX conformance testing by UNIFIX
Mar 27 23:10:06 main kernel: enabled ExtINT on CPU#0
Mar 27 23:10:06 main kernel: ESR value before enabling vector: 00000000
Mar 27 23:10:06 main kernel: ESR value after enabling vector: 00000000
Mar 27 23:10:06 main kernel: Using local APIC timer interrupts.
Mar 27 23:10:06 main kernel: calibrating APIC timer ...
Mar 27 23:10:06 main kernel: ..... CPU clock speed is 901.0954 MHz.
Mar 27 23:10:06 main kernel: ..... host bus clock speed is 100.0216 MHz.
Mar 27 23:10:06 main kernel: NET: Registered protocol family 16
Mar 27 23:10:06 main kernel: PCI: Using configuration type 1
Mar 27 23:10:06 main kernel: mtrr: v2.0 (20020519)
Mar 27 23:10:06 main kernel: ACPI: Subsystem revision 20040311
Mar 27 23:10:06 main kernel: ACPI: IRQ9 SCI: Level Trigger.
Mar 27 23:10:06 main kernel: ACPI: Interpreter enabled
Mar 27 23:10:06 main kernel: ACPI: Using PIC for interrupt routing
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Mar 27 23:10:06 main kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Mar 27 23:10:06 main kernel: PCI: Probing PCI hardware (bus 00)
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Mar 27 23:10:06 main kernel: drivers/usb/core/usb.c: registered new driver usbfs
Mar 27 23:10:06 main kernel: drivers/usb/core/usb.c: registered new driver hub
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Mar 27 23:10:06 main kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
Mar 27 23:10:06 main kernel: PCI: Using ACPI for IRQ routing
Mar 27 23:10:06 main kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Mar 27 23:10:06 main kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xe080a000, size 16384k
Mar 27 23:10:06 main kernel: vesafb: mode is 800x600x16, linelength=1600, pages=3
Mar 27 23:10:06 main kernel: vesafb: protected mode interface info at c000:0f34
Mar 27 23:10:06 main kernel: vesafb: scrolling: redraw
Mar 27 23:10:06 main kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Mar 27 23:10:06 main kernel: fb0: VESA VGA frame buffer device
Mar 27 23:10:06 main kernel: Simple Boot Flag at 0x3a set to 0x1
Mar 27 23:10:06 main kernel: VFS: Disk quotas dquot_6.5.1
Mar 27 23:10:06 main kernel: devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Mar 27 23:10:06 main kernel: devfs: boot_options: 0x1
Mar 27 23:10:06 main kernel: SGI XFS with ACLs, no debug enabled
Mar 27 23:10:06 main kernel: Initializing Cryptographic API
Mar 27 23:10:06 main kernel: Console: switching to colour frame buffer device 100x37
Mar 27 23:10:06 main kernel: Non-volatile memory driver v1.2
Mar 27 23:10:06 main kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 27 23:10:06 main kernel: agpgart: Detected VIA Apollo Pro 133 chipset
Mar 27 23:10:06 main kernel: agpgart: Maximum main memory to use for agp memory: 439M
Mar 27 23:10:06 main kernel: agpgart: AGP aperture is 32M @ 0xfc000000
Mar 27 23:10:06 main kernel: Using anticipatory io scheduler
Mar 27 23:10:06 main kernel: Floppy drive(s): fd0 is 1.44M
Mar 27 23:10:06 main kernel: FDC 0 is a post-1991 82077
Mar 27 23:10:06 main kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar 27 23:10:06 main kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar 27 23:10:06 main kernel: VP_IDE: IDE controller at PCI slot 0000:00:04.1
Mar 27 23:10:06 main kernel: VP_IDE: chipset revision 16
Mar 27 23:10:06 main kernel: VP_IDE: not 100%% native mode: will probe irqs later
Mar 27 23:10:06 main kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
Mar 27 23:10:06 main kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
Mar 27 23:10:06 main kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Mar 27 23:10:06 main kernel: hda: Maxtor 6Y080P0, ATA DISK drive
Mar 27 23:10:06 main kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 27 23:10:06 main kernel: hdc: 20X10, ATAPI CD/DVD-ROM drive
Mar 27 23:10:06 main kernel: hdd: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
Mar 27 23:10:06 main kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 27 23:10:06 main kernel: hda: max request size: 128KiB
Mar 27 23:10:06 main kernel: hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(66)
Mar 27 23:10:06 main kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 p13 > p3 p4
Mar 27 23:10:06 main kernel: hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Mar 27 23:10:06 main kernel: Uniform CD-ROM driver Revision: 3.20
Mar 27 23:10:06 main kernel: ide-floppy driver 0.99.newide
Mar 27 23:10:06 main kernel: mice: PS/2 mouse device common for all mice
Mar 27 23:10:06 main kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 27 23:10:06 main kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Mar 27 23:10:06 main kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 27 23:10:06 main kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Mar 27 23:10:06 main kernel: NET: Registered protocol family 2
Mar 27 23:10:06 main kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Mar 27 23:10:06 main kernel: TCP: Hash tables configured (established 32768 bind 65536)
Mar 27 23:10:06 main kernel: NET: Registered protocol family 1
Mar 27 23:10:06 main kernel: NET: Registered protocol family 17
Mar 27 23:10:06 main kernel: ACPI: (supports S0 S1 S4 S5)
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda8
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda8
Mar 27 23:10:06 main kernel: VFS: Mounted root (xfs filesystem) readonly.
Mar 27 23:10:06 main kernel: Mounted devfs on /dev
Mar 27 23:10:06 main kernel: Freeing unused kernel memory: 144k freed
Mar 27 23:10:06 main kernel: Adding 1052220k swap on /dev/ide/host0/bus0/target0/lun0/part7.  Priority:-1 extents:1
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda9
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda9
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda10
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda10
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda11
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda11
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda12
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda12
Mar 27 23:10:06 main kernel: XFS mounting filesystem hda13
Mar 27 23:10:06 main kernel: Ending clean XFS mount for filesystem: hda13
Mar 27 23:10:06 main kernel: drivers/usb/core/inode.c: usbfs: unrecognised mount option "gid=107" or missing value
Mar 27 23:10:06 main kernel: 
Mar 27 23:10:06 main kernel: drivers/usb/core/inode.c: usbfs: mount parameter error:
Mar 27 23:10:17 main kernel: No module found in object
Mar 27 23:10:31 main kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Mar 27 23:10:31 main kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Mar 27 23:10:31 main kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Mar 27 23:10:31 main kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Mar 27 23:10:51 main kernel: atkbd.c: Unknown key released (translated set 2, code 0x81 on isa0060/serio0).
Mar 27 23:10:51 main kernel: atkbd.c: Use 'setkeycodes e001 <keycode>' to make it known.
Mar 27 23:10:59 main kernel: atkbd.c: Unknown key pressed (translated set 2, code 0xbb on isa0060/serio0).
Mar 27 23:10:59 main kernel: atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
Mar 27 23:10:59 main kernel: atkbd.c: Unknown key released (translated set 2, code 0xbb on isa0060/serio0).
Mar 27 23:10:59 main kernel: atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
Mar 27 23:11:51 main kernel: atkbd.c: Unknown key released (translated set 2, code 0x81 on isa0060/serio0).
Mar 27 23:11:51 main kernel: atkbd.c: Use 'setkeycodes e001 <keycode>' to make it known.
Mar 27 23:12:50 main kernel: atkbd.c: Unknown key released (translated set 2, code 0x81 on isa0060/serio0).
Mar 27 23:12:50 main kernel: atkbd.c: Use 'setkeycodes e001 <keycode>' to make it known.

--------------020705010009020208060603
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

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
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
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
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

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
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
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
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

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
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_NETFILTER is not set

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
CONFIG_TUN=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139_RXBUF_IDX=2
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

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
# CONFIG_PLIP is not set
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
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

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
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=m
CONFIG_GEN_RTC=m
# CONFIG_GEN_RTC_X is not set
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
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
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
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
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
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_STORAGE is not set

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
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

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
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
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
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
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
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------020705010009020208060603--
