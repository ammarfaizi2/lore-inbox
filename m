Return-Path: <linux-kernel-owner+w=401wt.eu-S1751627AbXANTOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXANTOW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbXANTOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:14:22 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:44509 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbXANTOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:14:20 -0500
X-Greylist: delayed 3620 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 14:14:20 EST
Date: Sun, 14 Jan 2007 13:13:53 -0500
From: Bill Davidsen <davidsen1@verizon.net>
Subject: [2.6.20-rc5]KVM - Win98SE won't install
To: Kernel M/L <linux-kernel@vger.kernel.org>
Reply-to: Bill Davidsen <davidsen@tmr.com>
Message-id: <45AA72E1.4040306@verizon.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------060009020702010603060007
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061029
 SeaMonkey/1.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060009020702010603060007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hardware list attached, and config. When scanning disk at the start of 
the install, exits with "signal 13 (0)" and no log entry. Just as the 
kvm dies there's a switch from the blue install screen to a white on 
black screen, and a message displays for a fraction of a sec, unreadably 
fast.

I dount it's hardware, memtest was recently run 12hr, and installs of 
DragonFlyBSD and FreeBSD work.

I have two patches applied, diff also attached.

Running qemu user mode works, running xen-install does exactly the sdame 
thing. Obviously I would rather run kvm.

Any other info needed, or things to try, let me know. I did run with -d, 
nothing written in qemu.log.

-- 
Bill Davidsen
   He was a full-time professional cat, not some moonlighting
ferret or weasel. He knew about these things.

--------------060009020702010603060007
Content-Type: text/plain;
 name="dmesg-2.6.20-rc5-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.20-rc5-2"

Linux version 2.6.20-rc5 (davidsen@posidon.tmr.com) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) #3 SMP Sun Jan 14 11:33:19 EST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000007f6a0000 end: 000000007f7a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000007f7a0000 size: 000000000000e000 end: 000000007f7ae000 type: 3
copy_e820_map() start: 000000007f7ae000 size: 0000000000032000 end: 000000007f7e0000 type: 4
copy_e820_map() start: 000000007f7e0000 size: 0000000000020000 end: 000000007f800000 type: 2
copy_e820_map() start: 00000000ffb80000 size: 0000000000480000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f7a0000 (usable)
 BIOS-e820: 000000007f7a0000 - 000000007f7ae000 (ACPI data)
 BIOS-e820: 000000007f7ae000 - 000000007f7e0000 (ACPI NVS)
 BIOS-e820: 000000007f7e0000 - 000000007f800000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1143MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 522144) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   522144
early_node_map[1] active PFN ranges
    0:        0 ->   522144
On node 0 totalpages: 522144
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2287 pages used for memmap
  HighMem zone: 290481 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa5d0
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000627 MSFT 0x00000097) @ 0x7f7a0100
ACPI: FADT (v003 A M I  OEMFACP  0x10000627 MSFT 0x00000097) @ 0x7f7a0290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000627 MSFT 0x00000097) @ 0x7f7a0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x10000627 MSFT 0x00000097) @ 0x7f7ae040
ACPI: MCFG (v001 A M I  OEMMCFG  0x10000627 MSFT 0x00000097) @ 0x7f7a4f00
ACPI: DSDT (v001  A0281 A0281074 0x00000074 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7f800000:80380000)
Detected 2394.060 MHz processor.
Built 1 zonelists.  Total pages: 518065
Kernel command line: ro root=/dev/VG01/Root32 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2061272k/2088576k available (4101k kernel code, 26112k reserved, 1851k data, 324k init, 1171072k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe17000 - 0xfffff000   (1952 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc06d9000 - 0xc072a000   ( 324 kB)
      .data : 0xc0501575 - 0xc06d032c   (1851 kB)
      .text : 0xc0100000 - 0xc0501575   (4101 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4789.80 BogoMIPS (lpj=2394904)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 18k freed
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 691 Objects with 54 Devices 195 Methods 25 Regions
ACPI Namespace successfully loaded at root c078a570
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4787.21 BogoMIPS (lpj=2393605)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Total of 2 processors activated (9577.01 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=80
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 11 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:....................................................................................................................
Initialized 24/25 Regions 23/23 Fields 36/36 Buffers 33/34 Packages (700 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:.
Executed 1 _INI methods requiring 0 _STA executions (examined 60 objects)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: e000-efff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: d000-dfff
  MEM window: cff00000-cfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: b000-cfff
  MEM window: cfe00000-cfefffff
  PREFETCH window: 80000000-800fffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1939k freed
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
audit: initializing netlink socket (disabled)
audit(1168792625.910:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
Parsing all Control Methods:
Table [SSDT](id 00C5) - 10 Objects with 0 Devices 4 Methods 0 Regions
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
ACPI: Processor [CPU1] (supports 8 throttling states)
Parsing all Control Methods:
Table [SSDT](id 00C7) - 10 Objects with 0 Devices 4 Methods 0 Regions
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i915 1.6.0 20060119 on minor 0
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
intelfb: intelfb_init
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
intelfb: intelfb_setup
intelfb: no options
intelfb: intelfb_pci_register
intelfb: fb aperture: 0xd0000000/0x10000000, MMIO region: 0xcfd00000/0x80000
intelfb: 00:02.0: Intel(R) 945G, aperture size 256MB, stolen memory 7932kB
intelfb: fb: 0xd0000000(+ 0x0)/0x7bf000 (0xf8a00000)
intelfb: MMIO: 0xcfd00000/0x80000 (0xfc200000)
intelfb: ring buffer: 0xd3001000/0x10000 (0xfba01000)
intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
intelfb: options: mode = ""
intelfb: intelfb_set_fbinfo
intelfb: intelfb_init_var
intelfb: intelfb_check_var: accel_flags is 0
intelfb: Mode is interlaced.
intelfb: intelfb_check_var: accel_flags is 0
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 0
intelfb: intelfb_check_var: accel_flags is 0
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: Initial video mode is 1024x768-32@70.
intelfb: Initial video mode is from 1.
intelfb: update_dinfo
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: I2C bus CRTDDC_A registered.
intelfb: I2C bus SDVOCTRL_E registered.
intelfb: intelfbhw_print_hw_state
hw state dump start
	VGA0_DIVISOR:		0x00031108
	VGA1_DIVISOR:		0x00031406
	VGAPD: 			0x00020002
	VGA0: (m1, m2, n, p1, p2) = (17, 8, 3, 2, 0)
	VGA0: clock is 100800
	VGA1: (m1, m2, n, p1, p2) = (20, 6, 3, 2, 0)
	VGA1: clock is 113280
	DPLL_A:			0x84800003
	DPLL_B:			0x84800003
	FPA0:			0x00031108
	FPA1:			0x00031108
	FPB0:			0x00031108
	FPB1:			0x00031108
	PLLA0: (m1, m2, n, p1, p2) = (17, 8, 3, 8, 0)
	PLLA0: clock is 25200
	PLLA1: (m1, m2, n, p1, p2) = (17, 8, 3, 8, 0)
	PLLA1: clock is 25200
	HTOTAL_A:		0x031f027f
	HBLANK_A:		0x03170287
	HSYNC_A:		0x02ef028f
	VTOTAL_A:		0x020c01df
	VBLANK_A:		0x020401e7
	VSYNC_A:		0x01eb01e9
	SRC_SIZE_A:		0x027f01df
	BCLRPAT_A:		0x00000000
	HTOTAL_B:		0x031f027f
	HBLANK_B:		0x03170287
	HSYNC_B:		0x02ef028f
	VTOTAL_B:		0x020c01df
	VBLANK_B:		0x020401e7
	VSYNC_B:		0x01eb01e9
	SRC_SIZE_B:		0x027f01df
	BCLRPAT_B:		0x00000000
	ADPA:			0x80008000
	DVOA:			0x00000000
	DVOB:			0x00480000
	DVOC:			0x00480000
	DVOA_SRCDIM:		0x00000000
	DVOB_SRCDIM:		0x00000000
	DVOC_SRCDIM:		0x00000000
	LVDS:			0x00000000
	PIPEACONF:		0x80000000
	PIPEBCONF:		0x80000000
	DISPARB:		0x00001d9c
	CURSOR_A_CONTROL:	0x00000000
	CURSOR_B_CONTROL:	0x00000000
	CURSOR_A_BASEADDR:	0x00000000
	CURSOR_B_BASEADDR:	0x00000000
	CURSOR_A_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_B_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_SIZE:		0x00000000
	DSPACNTR:		0x48000000
	DSPBCNTR:		0x01000000
	DSPABASE:		0x00000000
	DSPBBASE:		0x00000000
	DSPASTRIDE:		0x00000280
	DSPBSTRIDE:		0x00000000
	VGACNTRL:		0x0000008e
	ADD_ID:			0x00000000
	SWF00			0x00000000
	SWF01			0x00000000
	SWF02			0x00000000
	SWF03			0x00000000
	SWF04			0x00000000
	SWF05			0x00000000
	SWF06			0x00000000
	SWF10			0x00000001
	SWF11			0x00000000
	SWF12			0x00000000
	SWF13			0x03030000
	SWF14			0xc0000000
	SWF15			0x00000041
	SWF16			0x00000000
	SWF30			0x00000000
	SWF31			0x00000000
	SWF32			0x00000000
	FENCE0			0x00000000
	FENCE1			0x00000000
	FENCE2			0x00000000
	FENCE3			0x00000000
	FENCE4			0x00000000
	FENCE5			0x00000000
	FENCE6			0x00000000
	FENCE7			0x00000000
	INSTPM			0x00000000
	MEM_MODE		0x00000000
	FW_BLC_0		0x03060106
	FW_BLC_1		0x00000306
	HWSTAM			0xffff
	IER			0x0000
	IIR			0x0000
	IMR			0xffff
hw state dump end
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:17:31:5c:57:c0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: DVDRW DRW-3S163, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
3ware Storage Controller device driver for Linux v1.26.02.001.
ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xA800 ctl 0xA402 bmdma 0x9400 irq 17
ata2: SATA max UDMA/133 cmd 0xA000 ctl 0x9802 bmdma 0x9408 irq 17
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
scsi1 : ata_piix
ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
sd 0:0:1:0: Attached scsi disk sdb
sd 0:0:1:0: Attached scsi generic sg1 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 >
sd 1:0:0:0: Attached scsi disk sdc
sd 1:0:0:0: Attached scsi generic sg2 type 0
Fusion MPT base driver 3.04.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.02
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00008000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 17, io base 0x00008400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00008800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 20, io base 0x00009000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
i2c /dev entries driver
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    894 MB/s
raid6: int32x2    945 MB/s
raid6: int32x4    820 MB/s
raid6: int32x8    824 MB/s
raid6: mmxx1     3027 MB/s
raid6: mmxx2     3472 MB/s
raid6: sse1x1    1816 MB/s
raid6: sse1x2    2617 MB/s
raid6: sse2x1    3519 MB/s
raid6: sse2x2    4078 MB/s
raid6: using algorithm sse2x2 (4078 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  8640.000 MB/sec
raid5: using function: pIII_sse (8640.000 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
logips2pp: Detected unknown logitech mouse model 11
Intel 810 + AC97 Audio, version 1.01, 23:46:48 Jan 12 2007
Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Tue Jan 09 09:56:17 2007 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
ALSA device list:
  #0: HDA Intel at 0xcfdfc000 irq 20
TCP cubic registered
TCP highspeed registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 324k freed
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda7
md: sda7 has invalid sb, not importing!
input: PS/2 Logitech Mouse as /class/input/input3
md: invalid raid superblock magic on sdb7
md: sdb7 has invalid sb, not importing!
md: invalid raid superblock magic on sdc7
md: sdc7 has invalid sb, not importing!
md: autorun ...
md: considering sdc6 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdc6
md: sdc3 has different UUID to sdc6
md: sdc2 has different UUID to sdc6
md: sdc1 has different UUID to sdc6
md:  adding sdb6 ...
md: sdb5 has different UUID to sdc6
md: sdb3 has different UUID to sdc6
md: sdb2 has different UUID to sdc6
md: sdb1 has different UUID to sdc6
md:  adding sda6 ...
md: sda5 has different UUID to sdc6
md: sda3 has different UUID to sdc6
md: sda2 has different UUID to sdc6
md: sda1 has different UUID to sdc6
md: created md4
md: bind<sda6>
md: bind<sdb6>
md: bind<sdc6>
md: running: <sdc6><sdb6><sda6>
raid1: raid set md4 active with 3 out of 3 mirrors
md: considering sdc5 ...
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md: sdc1 has different UUID to sdc5
md:  adding sdb5 ...
md: sdb3 has different UUID to sdc5
md: sdb2 has different UUID to sdc5
md: sdb1 has different UUID to sdc5
md:  adding sda5 ...
md: sda3 has different UUID to sdc5
md: sda2 has different UUID to sdc5
md: sda1 has different UUID to sdc5
md: created md3
md: bind<sda5>
md: bind<sdb5>
md: bind<sdc5>
md: running: <sdc5><sdb5><sda5>
raid5: device sdc5 operational as raid disk 2
raid5: device sdb5 operational as raid disk 1
raid5: device sda5 operational as raid disk 0
raid5: allocated 3157kB for md3
raid5: raid level 5 set md3 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3
 disk 0, o:1, dev:sda5
 disk 1, o:1, dev:sdb5
 disk 2, o:1, dev:sdc5
md: considering sdc3 ...
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md: sdc1 has different UUID to sdc3
md:  adding sdb3 ...
md: sdb2 has different UUID to sdc3
md: sdb1 has different UUID to sdc3
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: sda1 has different UUID to sdc3
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: running: <sdc3><sdb3><sda3>
raid5: device sdc3 operational as raid disk 2
raid5: device sdb3 operational as raid disk 1
raid5: device sda3 operational as raid disk 0
raid5: allocated 3157kB for md2
raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3
 disk 0, o:1, dev:sda3
 disk 1, o:1, dev:sdb3
 disk 2, o:1, dev:sdc3
md: considering sdc2 ...
md:  adding sdc2 ...
md: sdc1 has different UUID to sdc2
md:  adding sdb2 ...
md: sdb1 has different UUID to sdc2
md:  adding sda2 ...
md: sda1 has different UUID to sdc2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: bind<sdc2>
md: running: <sdc2><sdb2><sda2>
raid5: device sdc2 operational as raid disk 2
raid5: device sdb2 operational as raid disk 1
raid5: device sda2 operational as raid disk 0
raid5: allocated 3157kB for md1
raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3
 disk 0, o:1, dev:sda2
 disk 1, o:1, dev:sdb2
 disk 2, o:1, dev:sdc2
md: considering sdc1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: running: <sdc1><sdb1><sda1>
raid1: raid set md0 active with 3 out of 3 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1168792630.987:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1585 types, 172 bools, 1 sens, 1024 cats
security:  59 classes, 49500 rules
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1168792631.143:3): policy loaded auid=4294967295
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev md0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
Adding 2039800k swap on /dev/md1.  Priority:-1 extents:1 across:2039800k
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth0: no IPv6 routers present
kvm: msrs: 2
kvm: msrs: 2

--------------060009020702010603060007
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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

--------------060009020702010603060007
Content-Type: text/plain;
 name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
stepping	: 6
cpu MHz		: 1596.000
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 4789.81
clflush size	: 64

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
stepping	: 6
cpu MHz		: 1596.000
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 4787.23
clflush size	: 64


--------------060009020702010603060007--
