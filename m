Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTKYAh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKYAh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:37:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29444
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261752AbTKYAhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:37:11 -0500
Date: Mon, 24 Nov 2003 16:36:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
Message-ID: <20031125003658.GA1342@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031121121116.61db0160.akpm@osdl.org> <20031124225527.GB1343@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com> <20031124235807.GA1586@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20031124235807.GA1586@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2003 at 03:58:07PM -0800, Mike Fedyk wrote:
> I just compiled witout preempt and it still gives an oops at the same spot.

Just compiled vanilla 2.6.0-test9 and it doesn't oops.

Let me know if you still want me to hand type that oops.

--- linux-2.6.0-test9/.config	2003-11-24 15:47:54.000000000 -0800
+++ linux-2.6.0-test9-mm5/.config	2003-11-24 15:33:22.000000000 -0800
@@ -29,6 +29,8 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -84,11 +86,16 @@
 CONFIG_X86_POPAD_OK=y
 CONFIG_X86_ALIGNMENT_16=y
 CONFIG_X86_INTEL_USERCOPY=y
+# CONFIG_X86_4G is not set
+# CONFIG_X86_SWITCH_PAGETABLES is not set
+# CONFIG_X86_4G_VM_LAYOUT is not set
+# CONFIG_X86_UACCESS_INDIRECT is not set
+# CONFIG_X86_HIGH_ENTRY is not set
 CONFIG_HPET_TIMER=y
 # CONFIG_HPET_EMULATE_RTC is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_PREEMPT=y
+# CONFIG_PREEMPT is not set
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
 CONFIG_X86_MCE=y
@@ -107,6 +114,7 @@
 CONFIG_HIGHPTE=y
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
+# CONFIG_EFI is not set
 CONFIG_HAVE_DEC_LOCK=y
 
 #
@@ -138,6 +146,7 @@
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
 # CONFIG_ACPI_RELAXED_AML is not set
+CONFIG_X86_PM_TIMER=y
 
 #
 # APM (Advanced Power Management) BIOS Support
@@ -165,6 +174,7 @@
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
+CONFIG_PCI_USE_VECTOR=y
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
@@ -233,6 +243,7 @@
 #
 CONFIG_ISAPNP=y
 CONFIG_PNPBIOS=y
+CONFIG_PNPBIOS_PROC_FS=y
 
 #
 # Block devices
@@ -316,7 +327,6 @@
 CONFIG_BLK_DEV_OPTI621=y
 CONFIG_BLK_DEV_RZ1000=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDE_TCQ is not set
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
@@ -365,6 +375,7 @@
 # SCSI support type (disk, tape, CD-ROM)
 #
 CONFIG_BLK_DEV_SD=y
+CONFIG_MAX_SD_DISKS=256
 CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
@@ -682,6 +693,8 @@
 CONFIG_TULIP=m
 CONFIG_TULIP_MWI=y
 CONFIG_TULIP_MMIO=y
+CONFIG_TULIP_NAPI=y
+CONFIG_TULIP_NAPI_HW_MITIGATION=y
 CONFIG_DE4X5=m
 CONFIG_WINBOND_840=m
 CONFIG_DM9102=m
@@ -697,6 +710,7 @@
 CONFIG_AC3200=m
 CONFIG_APRICOT=m
 CONFIG_B44=m
+# CONFIG_FORCEDETH is not set
 CONFIG_CS89x0=m
 CONFIG_DGRS=m
 CONFIG_EEPRO100=m
@@ -763,6 +777,7 @@
 # CONFIG_NET_FC is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # Wan interfaces
@@ -1335,7 +1350,6 @@
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_BELKIN=m
-# CONFIG_USB_SERIAL_WHITEHEAT is not set
 CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
 CONFIG_USB_SERIAL_EMPEG=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -1513,12 +1527,11 @@
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
-CONFIG_SMB_NLS=y
-CONFIG_NLS=y
 
 #
 # Native Language Support
 #
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=m
 # CONFIG_NLS_CODEPAGE_737 is not set
@@ -1573,9 +1586,12 @@
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
 # CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_SPINLINE is not set
 CONFIG_DEBUG_HIGHMEM=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_LOCKMETER is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_KGDB is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_X86_EXTRA_IRQS=y
 CONFIG_X86_FIND_SMP_CONFIG=y

Linux version 2.6.0-test9 (root@mis-mike-wstn) (gcc version 3.3.2 (Debian)) #1 SMP Mon Nov 24 15:54:45 PST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
 BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393212
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 163836 pages, LIFO batch:16
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5dc0
ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc000
ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc030
ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x5fffc058
ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro vga=extended nmi_watchdog=2 ide=reverse
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2083.203 MHz processor.
Console: colour VGA+ 80x50
spurious 8259A interrupt: IRQ7.
Memory: 1552352k/1572848k available (2324k kernel code, 19344k reserved, 890k data, 196k init, 655344k highmem)
Calibrating delay loop... 4104.19 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(TM) XP 2600+ stepping 01
per-CPU timeslice cutoff: 731.36 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Total of 1 processors activated (4104.19 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2082.0719 MHz.
..... host bus clock speed is 333.0235 MHz.
Starting migration thread for cpu 0
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf15e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9bf0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c20, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:07[A] -> 2-17 -> IRQ 17
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
sage repeated 2 times
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23 Mode:1 Active:1)
00:00:12[A] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
divert: not allocating divert_blk for non-ethernet device lo
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled

2.6.0-test9-mm5 oopses here.

ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x8400-0x8407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DPTA-372730, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SiI680: IDE controller at PCI slot 0000:00:0e.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133 
SiI680: 100%% native mode on irq 17
    ide2: MMIO-DMA at 0xf880a000-0xf880a007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf880a008-0xf880a00f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y160P0, ATA DISK drive
ide2 at 0xf880a080-0xf880a087,0xf880a08a on irq 17
hdg: Maxtor 6Y160P0, ATA DISK drive
ide3 at 0xf880a0c0-0xf880a0c7,0xf880a0ca on irq 17
PDC20269: IDE controller at PCI slot 0000:00:0c.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 19
    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio
hdi: Maxtor 6Y160P0, ATA DISK drive
ide4 at 0xd800-0xd807,0xd402 on irq 19
hdk: Maxtor 6Y160P0, ATA DISK drive
ide5 at 0xd000-0xd007,0xb802 on irq 19
hda: max request size: 128KiB
hda: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hda: hda1 hda2
hde: max request size: 64KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hde: hde1 hde2 hde3
hdg: max request size: 64KiB
hdg: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdg: hdg1 hdg2
hdi: max request size: 1024KiB
hdi: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdi: hdi1 hdi3
hdk: max request size: 1024KiB
hdk: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hdk: hdk1 hdk2 hdk3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2948.000 MB/sec
   8regs_prefetch:  2844.000 MB/sec
   32regs    :  1984.000 MB/sec
   32regs_prefetch:  1864.000 MB/sec
   pIII_sse  :  1648.000 MB/sec
   pII_mmx   :  5572.000 MB/sec
   p5_mmx    :  7424.000 MB/sec
raid5: using function: pIII_sse (1648.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
BIOS EDD facility v0.10 2003-Oct-11, 5 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdk3 ...
md:  adding hdk3 ...
md: hdk1 has different UUID to hdk3
md:  adding hdi3 ...
md:  adding hde3 ...
md: hde1 has different UUID to hdk3
md: created md0
md: bind<hde3>
md: bind<hdi3>
md: bind<hdk3>
md: running: <hdk3><hdi3><hde3>
raid5: device hdk3 operational as raid disk 2
raid5: device hdi3 operational as raid disk 1
raid5: device hde3 operational as raid disk 0
raid5: allocated 3148kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 0
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hde3
 disk 1, o:1, dev:hdi3
 disk 2, o:1, dev:hdk3
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hde1 ...
md: created md1
md: bind<hde1>
md: bind<hdk1>
md: running: <hdk1><hde1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
NET: Registered protocol family 1
Adding 364888k swap on /dev/hda2.  Priority:1 extents:1
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12
8139too Fast Ethernet driver 0.9.26
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
divert: allocating divert_blk for eth0
eth0: VIA VT6102 Rhine-II at 0xf7000000, 00:0c:6e:1f:81:95, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
inserting floppy driver for 2.6.0-test9
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
Adding 262136k swap on /usr/swap_file.  Priority:2 extents:68
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 21, pci mem f8875000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 21, io base 00009400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 21, io base 00009000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 21, io base 00008800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 2-0:1.0: new USB device on port 2, assigned address 2
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
nfs warning: mount version older than kernel
sage repeated 3 times
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
process `named' is using obsolete setsockopt SO_BSDCOMPAT
sage repeated 5 times
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/input/hid-ff.c: hid_ff_init could not find initializer
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:10.0-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver

--FL5UXtIhxfXey3p5
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="260t9.config.bz2"
Content-Transfer-Encoding: base64

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

--FL5UXtIhxfXey3p5--
