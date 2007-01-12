Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbXALSDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXALSDS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 13:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbXALSDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 13:03:18 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:43883 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbXALSDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 13:03:16 -0500
Date: Fri, 12 Jan 2007 13:03:07 -0500
From: Bill Davidsen <davidsen1@verizon.net>
Subject: Mostly bad news with 2.6.20-rc4-git1
To: linux-kernel@vger.kernel.org
Reply-to: davidsen@tmr.com
Message-id: <45A7CD5B.5010808@verizon.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------040000040202070108040204
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061029
 SeaMonkey/1.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040000040202070108040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I did a build with a lightly modified defconfig, and installed. On first
boot test the system looped complaining about the nbd and listing many
errors I couldn't capture regarding nbd5-nbd0. Hardware description is 
in the lshw file.

I took out nbd for the moment, and reinstalled. That gave warnings about
fd0 sector 0 errors, but eventually booted. That kernel seems to run
reasonably well, dmesg also attached, with the config file from /proc.

I downloaded kvm-10 and built that. It did not correctly handle
"../linux-2.6.20-rc4" as the kernel tree, it seemed to strip the leading
".." from the name. I reconfigured and installed using a full tree path.
On trying to install a test of Win98SE, qemu got to the surface scan
(last item of the install) and ended with:
     exception 13 (0)
     Aborted

I used no-acpi and tried with and without win2k-hack option. Since the
kernel has recent KVM patches I didn't build the module (used
--with-patched-kernel). I later tried building the kvm module, but that 
doesn't load with this kernel.

System is historically stable, and I ran memtest for 12hr about a week
ago, so I have no reason to suspect a memory problem. Memory and CPU are
not overclocked, CPU and case temps are good, I doubt this is hardware, 
VMware with WinXP was tested by someone else on this system.

Attached: config, cpuinfo, dmesg, hardware scan, and a copy of the error.

Two problems:
  - kvm will not run anything in VM, probably some config or FC6 issue. I
    did try with selinux in advisory mode, but I don't want to run with
    it off.
  - system with nbd configured will not boot (and doesn't write log file)
    I could belive that's lightly tested.

-- 
Bill Davidsen
   He was a full-time professional cat, not some moonlighting
ferret or weasel. He knew about these things.

--------------040000040202070108040204
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
Bz6+jy9dsAAA
--------------040000040202070108040204
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
bogomips	: 4787.22
clflush size	: 64


--------------040000040202070108040204
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.20-rc4-git1 (davidsen@posidon.tmr.com) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) #1 SMP Fri Jan 12 11:52:28 EST 2007
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
Detected 2394.110 MHz processor.
Built 1 zonelists.  Total pages: 518065
Kernel command line: ro root=/dev/VG01/Root32 rhgb
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2061264k/2088576k available (4112k kernel code, 26120k reserved, 1852k data, 324k init, 1171072k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe17000 - 0xfffff000   (1952 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc06db000 - 0xc072c000   ( 324 kB)
      .data : 0xc05040f5 - 0xc06d332c   (1852 kB)
      .text : 0xc0100000 - 0xc05040f5   (4112 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4789.81 BogoMIPS (lpj=2394906)
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
ACPI Namespace successfully loaded at root c078c590
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4787.22 BogoMIPS (lpj=2393612)
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
Total of 2 processors activated (9577.03 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=110
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
intel_rng: FWH not detected
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
audit(1168621038.096:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
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
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
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
raid6: int32x1    898 MB/s
raid6: int32x2    945 MB/s
raid6: int32x4    757 MB/s
raid6: int32x8    824 MB/s
raid6: mmxx1     3027 MB/s
raid6: mmxx2     3472 MB/s
raid6: sse1x1    1816 MB/s
raid6: sse1x2    2617 MB/s
raid6: sse2x1    3523 MB/s
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
Intel 810 + AC97 Audio, version 1.01, 11:47:05 Jan 12 2007
Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Wed Dec 20 08:11:48 2006 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
ALSA device list:
  #0: HDA Intel at 0xcfdfc000 irq 20
TCP cubic registered
TCP highspeed registered
NET: Registered protocol family 1
NET: Registered protocol family 17
acpi_processor-0740 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
acpi_processor-0740 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
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
audit(1168621043.111:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1583 types, 172 bools, 1 sens, 1024 cats
security:  59 classes, 49551 rules
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
audit(1168621043.425:3): policy loaded auid=4294967295
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
audit(1168621567.083:4): enforcing=0 old_enforcing=1 auid=4294967295
audit(1168621567.084:5): user pid=4083 uid=0 auid=4294967295 subj=root:system_r:unconfined_t:s0-s0:c0.c1023 msg='avc:  received setenforce notice (enforcing=0)
: exe="/bin/dbus-daemon" (sauid=0, hostname=?, addr=?, terminal=?)'
kvm: msrs: 2
audit(1168621749.964:6): enforcing=1 old_enforcing=0 auid=4294967295
audit(1168621749.969:7): user pid=4083 uid=0 auid=4294967295 subj=root:system_r:unconfined_t:s0-s0:c0.c1023 msg='avc:  received setenforce notice (enforcing=1)
: exe="/bin/dbus-daemon" (sauid=0, hostname=?, addr=?, terminal=?)'

--------------040000040202070108040204
Content-Type: text/plain;
 name="errmsg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errmsg"

posidon:root> Q -soundhw sb16 -m 384 -no-acpi -win2k-hack \
> -hda ~davidsen/Virtual_Machines/Images.kvm/Win98SE-1.kvm \
> -cdrom ~davidsen/Virtual_Machines/CDs/Win98SE.iso \
> -boot d
exception 13 (0)
Aborted
posidon:root> 

--------------040000040202070108040204
Content-Type: text/plain;
 name="lshw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lshw"

posidon.tmr.com
    description: Desktop Computer
    product: System Product Name
    vendor: System manufacturer
    version: System Version
    serial: System Serial Number
    width: 32 bits
    capabilities: smbios-2.4 dmi-2.4
    configuration: boot=normal chassis=desktop uuid=D4B6237F-74FE-D511-9994-646FB03921C6
  *-core
       description: Motherboard
       product: P5LD2-VM
       vendor: ASUSTeK Computer INC.
       physical id: 0
       version: Rev 1.xx
       serial: MB-1234567890
       slot: To Be Filled By O.E.M.
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 1102 (10/27/2006)
          size: 64KB
          capacity: 448KB
          capabilities: isa pci pnp apm upgrade shadowing escd cdboot bootselect socketedrom edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: 6.15.6
          serial: 0000-06F6-0000-0000-0000-0000
          slot: LGA 775
          size: 1596MHz
          capacity: 3800MHz
          width: 64 bits
          clock: 266MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx x86-64 constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm cpufreq
          configuration: id=0
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1-Cache
             size: 32KB
             capacity: 32KB
             capabilities: pipeline-burst internal varies data
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2-Cache
             size: 4MB
             capacity: 4MB
             capabilities: pipeline-burst internal varies instruction
        *-cache:2 DISABLED
             description: L3 cache
             physical id: 7
             slot: L3-Cache
             capabilities: internal
        *-logicalcpu:0
             description: Logical CPU
             physical id: 0.1
             width: 64 bits
             capabilities: logical
        *-logicalcpu:1
             description: Logical CPU
             physical id: 0.2
             width: 64 bits
             capabilities: logical
     *-memory
          description: System Memory
          physical id: 35
          slot: System board or motherboard
          size: 2GB
        *-bank:0
             description: DIMM SDRAM Synchronous
             product: PartNum0
             vendor: Manufacturer0
             physical id: 0
             serial: SerNum0
             slot: DIMM0
             size: 1GB
             width: 64 bits
        *-bank:1
             description: DIMM [empty]
             product: PartNum1
             vendor: Manufacturer1
             physical id: 1
             serial: SerNum1
             slot: DIMM1
        *-bank:2
             description: DIMM SDRAM Synchronous
             product: PartNum2
             vendor: Manufacturer2
             physical id: 2
             serial: SerNum2
             slot: DIMM2
             size: 1GB
             width: 64 bits
        *-bank:3
             description: DIMM [empty]
             product: PartNum3
             vendor: Manufacturer3
             physical id: 3
             serial: SerNum3
             slot: DIMM3
     *-pci
          description: Host bridge
          product: 82945G/GZ/P/PL Memory Controller Hub
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@00:00.0
          version: 02
          width: 32 bits
          clock: 33MHz
        *-display
             description: VGA compatible controller
             product: 82945G/GZ Integrated Graphics Controller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@00:02.0
             logical name: /dev/fb1
             version: 02
             size: 256MB
             width: 32 bits
             clock: 33MHz
             capabilities: vga bus_master cap_list fb accelerated
             configuration: depth=32 driver=intelfb frequency=70.07Hz latency=0 mode=1024x768 visual=truecolor xres=1024 yres=768
             resources: iomemory:cfd00000-cfd7ffff ioport:7800-7807 iomemory:d0000000-dfffffff iomemory:cfd80000-cfdbffff irq:16
        *-multimedia
             description: Audio device
             product: 82801G (ICH7 Family) High Definition Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@00:1b.0
             version: 01
             width: 64 bits
             clock: 33MHz
             capabilities: bus_master cap_list
             configuration: driver=HDA Intel latency=0
             resources: iomemory:cfdfc000-cfdfffff irq:20
        *-pci:0
             description: PCI bridge
             product: 82801G (ICH7 Family) PCI Express Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@00:1c.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
        *-pci:1
             description: PCI bridge
             product: 82801G (ICH7 Family) PCI Express Port 2
             vendor: Intel Corporation
             physical id: 1c.1
             bus info: pci@00:1c.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
           *-network
                description: Ethernet interface
                product: 82573L Gigabit Ethernet Controller
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@02:00.0
                logical name: eth0
                version: 00
                serial: 00:17:31:5c:57:c0
                size: 100MB/s
                capacity: 1GB/s
                width: 32 bits
                clock: 33MHz
                capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=e1000 driverversion=7.3.15-k2 duplex=full firmware=0.5-7 ip=192.168.1.47 latency=0 link=yes multicast=yes port=twisted pair speed=100MB/s
                resources: iomemory:cffe0000-cfffffff ioport:d800-d81f irq:223
        *-usb:0
             description: USB Controller
             product: 82801G (ICH7 Family) USB UHCI #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@00:1d.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd latency=0
             resources: ioport:8000-801f irq:19
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.20-rc4-git1 uhci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:1
             description: USB Controller
             product: 82801G (ICH7 Family) USB UHCI #2
             vendor: Intel Corporation
             physical id: 1d.1
             bus info: pci@00:1d.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd latency=0
             resources: ioport:8400-841f irq:17
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.20-rc4-git1 uhci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:2
             description: USB Controller
             product: 82801G (ICH7 Family) USB UHCI #3
             vendor: Intel Corporation
             physical id: 1d.2
             bus info: pci@00:1d.2
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd latency=0
             resources: ioport:8800-881f irq:18
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.20-rc4-git1 uhci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:3
             description: USB Controller
             product: 82801G (ICH7 Family) USB UHCI #4
             vendor: Intel Corporation
             physical id: 1d.3
             bus info: pci@00:1d.3
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd latency=0
             resources: ioport:9000-901f irq:20
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.20-rc4-git1 uhci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-pci:2
             description: PCI bridge
             product: 82801 PCI Bridge
             vendor: Intel Corporation
             physical id: 1e
             bus info: pci@00:1e.0
             version: e1
             width: 32 bits
             clock: 33MHz
             capabilities: pci subtractive_decode bus_master cap_list
           *-storage UNCLAIMED
                description: Mass storage controller
                product: ITE 8211F Single Channel UDMA 133 (ASUS 8211 (ITE IT8212 ATA RAID Controller))
                vendor: Integrated Technology Express, Inc.
                physical id: 4
                bus info: pci@01:04.0
                version: 11
                width: 32 bits
                clock: 66MHz
                capabilities: storage bus_master cap_list
                configuration: latency=0 maxlatency=8 mingnt=8
                resources: ioport:c800-c807 ioport:c400-c403 ioport:c000-c007 ioport:b800-b803 ioport:b400-b40f irq:5
        *-isa
             description: ISA bridge
             product: 82801GB/GR (ICH7 Family) LPC Interface Bridge
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@00:1f.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: latency=0
        *-ide:0
             description: IDE interface
             product: 82801G (ICH7 Family) IDE Controller
             vendor: Intel Corporation
             physical id: 1f.1
             bus info: pci@00:1f.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: ide bus_master
             configuration: driver=PIIX_IDE latency=0
             resources: ioport:1f0-1f7 ioport:3f4-3f3 ioport:170-177 ioport:374-373 ioport:ffa0-ffaf irq:18
           *-ide
                description: IDE Channel 0
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 33MHz
              *-cdrom
                   description: DVD writer
                   product: DVDRW DRW-3S163
                   physical id: 0
                   bus info: ide@0.0
                   logical name: /dev/hda
                   version: BSG2
                   capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio cd-r cd-rw dvd dvd-r
                   configuration: mode=udma2
                 *-disc
                      physical id: 0
                      logical name: /dev/hda
        *-ide:1
             description: IDE interface
             product: 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controller IDE
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@00:1f.2
             logical name: scsi0
             logical name: scsi1
             version: 01
             width: 32 bits
             clock: 66MHz
             capabilities: ide bus_master cap_list emulated
             configuration: driver=ata_piix latency=0
             resources: ioport:a800-a807 ioport:a400-a403 ioport:a000-a007 ioport:9800-9803 ioport:9400-940f irq:17
           *-disk:0
                description: SCSI Disk
                product: ST3320620AS
                vendor: ATA
                physical id: 0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: 3.AA
                serial: 3QF06XHP
                size: 298GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume:0
                   description: Linux raid autodetect partition
                   physical id: 1
                   bus info: scsi@0:0.0.0,1
                   logical name: /dev/sda1
                   capacity: 101MB
                   capabilities: primary bootable multi
              *-volume:1
                   description: Linux raid autodetect partition
                   physical id: 2
                   bus info: scsi@0:0.0.0,2
                   logical name: /dev/sda2
                   capacity: 996MB
                   capabilities: primary multi
              *-volume:2
                   description: Linux raid autodetect partition
                   physical id: 3
                   bus info: scsi@0:0.0.0,3
                   logical name: /dev/sda3
                   serial: xSRU1Z-M2up-ALnl-tOqY-zSlf-x2F9-ZKj2mR
                   size: 390GB
                   capabilities: primary multi lvm2
              *-volume:3
                   description: Extended partition
                   physical id: 4
                   bus info: scsi@0:0.0.0,4
                   logical name: /dev/sda4
                   size: 101GB
                   capacity: 101GB
                   capabilities: primary extended partitioned partitioned:extended
                 *-logicalvolume:0
                      description: Linux raid autodetect partition
                      physical id: 5
                      logical name: /dev/sda5
                      serial: UTXwbr-aVT9-O3ez-1nQV-R2YL-wn21-DGPBwt
                      size: 58GB
                      capabilities: multi lvm2
                 *-logicalvolume:1
                      description: Linux raid autodetect partition
                      physical id: 6
                      logical name: /dev/sda6
                      capacity: 101MB
                      capabilities: multi
                 *-logicalvolume:2
                      description: Linux raid autodetect partition
                      physical id: 7
                      logical name: /dev/sda7
                      capacity: 3820MB
                      capabilities: multi
           *-disk:1
                description: SCSI Disk
                product: ST3320620AS
                vendor: ATA
                physical id: 0.1.0
                bus info: scsi@0:0.1.0
                logical name: /dev/sdb
                version: 3.AA
                serial: 3QF070WA
                size: 298GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume:0
                   description: Linux raid autodetect partition
                   physical id: 1
                   bus info: scsi@0:0.1.0,1
                   logical name: /dev/sdb1
                   capacity: 101MB
                   capabilities: primary bootable multi
              *-volume:1
                   description: Linux raid autodetect partition
                   physical id: 2
                   bus info: scsi@0:0.1.0,2
                   logical name: /dev/sdb2
                   capacity: 996MB
                   capabilities: primary multi
              *-volume:2
                   description: Linux raid autodetect partition
                   physical id: 3
                   bus info: scsi@0:0.1.0,3
                   logical name: /dev/sdb3
                   capacity: 195GB
                   capabilities: primary multi
              *-volume:3
                   description: Extended partition
                   physical id: 4
                   bus info: scsi@0:0.1.0,4
                   logical name: /dev/sdb4
                   size: 101GB
                   capacity: 101GB
                   capabilities: primary extended partitioned partitioned:extended
                 *-logicalvolume:0
                      description: Linux raid autodetect partition
                      physical id: 5
                      logical name: /dev/sdb5
                      capacity: 29GB
                      capabilities: multi
                 *-logicalvolume:1
                      description: Linux raid autodetect partition
                      physical id: 6
                      logical name: /dev/sdb6
                      capacity: 101MB
                      capabilities: multi
                 *-logicalvolume:2
                      description: Linux raid autodetect partition
                      physical id: 7
                      logical name: /dev/sdb7
                      capacity: 3820MB
                      capabilities: multi
           *-disk:2
                description: SCSI Disk
                product: ST3320620AS
                vendor: ATA
                physical id: 1
                bus info: scsi@1:0.0.0
                logical name: /dev/sdc
                version: 3.AA
                serial: 3QF05YW7
                size: 298GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume:0
                   description: Linux raid autodetect partition
                   physical id: 1
                   bus info: scsi@1:0.0.0,1
                   logical name: /dev/sdc1
                   capacity: 101MB
                   capabilities: primary bootable multi
              *-volume:1
                   description: Linux raid autodetect partition
                   physical id: 2
                   bus info: scsi@1:0.0.0,2
                   logical name: /dev/sdc2
                   capacity: 996MB
                   capabilities: primary multi
              *-volume:2
                   description: Linux raid autodetect partition
                   physical id: 3
                   bus info: scsi@1:0.0.0,3
                   logical name: /dev/sdc3
                   capacity: 195GB
                   capabilities: primary multi
              *-volume:3
                   description: Extended partition
                   physical id: 4
                   bus info: scsi@1:0.0.0,4
                   logical name: /dev/sdc4
                   size: 101GB
                   capacity: 101GB
                   capabilities: primary extended partitioned partitioned:extended
                 *-logicalvolume:0
                      description: Linux raid autodetect partition
                      physical id: 5
                      logical name: /dev/sdc5
                      serial: UTXwbr-aVT9-O3ez-1nQV-R2YL-wn21-DGPBwt
                      size: 58GB
                      capabilities: multi lvm2
                 *-logicalvolume:1
                      description: Linux raid autodetect partition
                      physical id: 6
                      logical name: /dev/sdc6
                      capacity: 101MB
                      capabilities: multi
                 *-logicalvolume:2
                      description: Linux raid autodetect partition
                      physical id: 7
                      logical name: /dev/sdc7
                      capacity: 3820MB
                      capabilities: multi
        *-serial UNCLAIMED
             description: SMBus
             product: 82801G (ICH7 Family) SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@00:1f.3
             version: 01
             width: 32 bits
             clock: 33MHz
             configuration: latency=0
             resources: ioport:400-41f

--------------040000040202070108040204--
