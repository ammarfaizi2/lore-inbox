Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUAFRun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAFRum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:50:42 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:38408 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S264566AbUAFRuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:50:06 -0500
Date: Tue, 6 Jan 2004 18:47:55 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1rc1] oops while cdrecord -scanbus 
Message-ID: <20040106174755.GA8855@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i have seen the oops below after i clicked on "Rescan devices" in
xcdroast which should call "cdrecord -scanbus" or something.
Nevertheless - I have attached a firewire DVD Burner (Sony DRU-500)

This is a 2.6.1rc1 without any patches ... Attached on the USB Bus was a=20
MemoryStick which shows up as SCSI Device too.=20


Unable to handle kernel NULL pointer dereference at virtual address 000009f8
 printing eip:
c015da96
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015da96>]    Not tainted
EFLAGS: 00010202
EIP is at cdev_get+0x2a/0xb2
eax: dfd88000   ebx: 000009f8   ecx: 00000015   edx: c015d993
esi: de5e4e00   edi: 00000001   ebp: de5e4e00   esp: dfd89ed8
ds: 007b   es: 007b   ss: 0068
Process cdrecord.mmap (pid: 19734, threadinfo=3Ddfd88000 task=3Dde0986a0)
Stack: c012f075 df3a0300 00000000 dfd88000 c015d9a2 de5e4e00 c022dbfe 01500=
000=20
       de5e4e00 00000006 c015d98e 00000000 dfd88000 00000000 00000000 00000=
000=20
       c015d857 dff70c00 01500000 dfd89f28 00000000 da6fbc00 c7fccc0c 00000=
001=20
Call Trace:
 [<c012f075>] in_group_p+0x25/0x2d
 [<c015d9a2>] exact_lock+0xf/0x1e
 [<c022dbfe>] kobj_lookup+0x102/0x1d5
 [<c015d98e>] exact_match+0x0/0x5
 [<c015d857>] chrdev_open+0x196/0x214
 [<c01542a6>] dentry_open+0x13d/0x1fe
 [<c0154167>] filp_open+0x62/0x64
 [<c01545cd>] sys_open+0x5b/0x8b
 [<c01091fb>] syscall_call+0x7/0xb

Code: 83 3b 02 74 7f ff 83 00 01 00 00 b8 00 e0 ff ff 21 e0 83 68=20
 <6>note: cdrecord.mmap[19734] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 000009f8
 printing eip:
c015da96
*pde =3D 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c015da96>]    Not tainted
EFLAGS: 00010202
EIP is at cdev_get+0x2a/0xb2
eax: dc1c8000   ebx: 000009f8   ecx: 00000015   edx: c015d993
esi: de5e4e00   edi: 00000001   ebp: de5e4e00   esp: dc1c9ed8
ds: 007b   es: 007b   ss: 0068
Process cdrecord.mmap (pid: 19740, threadinfo=3Ddc1c8000 task=3Dde5eccc0)
Stack: c549cb80 df3a0300 00000000 dc1c8000 c015d9a2 de5e4e00 c022dbfe 01500=
000=20
       de5e4e00 00000006 c015d98e 00000000 dc1c8000 00000000 00000000 00000=
000=20
       c015d857 dff70c00 01500000 dc1c9f28 00000000 c3668d80 c7fccc0c 00000=
001=20
Call Trace:
 [<c015d9a2>] exact_lock+0xf/0x1e
 [<c022dbfe>] kobj_lookup+0x102/0x1d5
 [<c015d98e>] exact_match+0x0/0x5
 [<c015d857>] chrdev_open+0x196/0x214
 [<c01542a6>] dentry_open+0x13d/0x1fe
 [<c0154167>] filp_open+0x62/0x64
 [<c01545cd>] sys_open+0x5b/0x8b
 [<c01091fb>] syscall_call+0x7/0xb

Code: 83 3b 02 74 7f ff 83 00 01 00 00 b8 00 e0 ff ff 21 e0 83 68=20
 <6>note: cdrecord.mmap[19740] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011e28f>] schedule+0x576/0x57b
 [<c0146789>] unmap_page_range+0x43/0x69
 [<c014695f>] unmap_vmas+0x1b0/0x208
 [<c014a51a>] exit_mmap+0x7c/0x190
 [<c011fae2>] mmput+0x66/0xb5
 [<c01238ba>] do_exit+0x150/0x40a
 [<c011c402>] do_page_fault+0x0/0x50c
 [<c010a27c>] do_divide_error+0x0/0xfa
 [<c011c5da>] do_page_fault+0x1d8/0x50c
 [<c013e8b1>] buffered_rmqueue+0xd4/0x16e
 [<c013e9f1>] __alloc_pages+0xa6/0x314
 [<c013ac3f>] find_get_page+0x2d/0x56
 [<c013bd6d>] filemap_nopage+0x2c2/0x35a
 [<c011c402>] do_page_fault+0x0/0x50c
 [<c0109c25>] error_code+0x2d/0x38
 [<c015d993>] exact_lock+0x0/0x1e
 [<c015da96>] cdev_get+0x2a/0xb2
 [<c015d9a2>] exact_lock+0xf/0x1e
 [<c022dbfe>] kobj_lookup+0x102/0x1d5
 [<c015d98e>] exact_match+0x0/0x5
 [<c015d857>] chrdev_open+0x196/0x214
 [<c01542a6>] dentry_open+0x13d/0x1fe
 [<c0154167>] filp_open+0x62/0x64
 [<c01545cd>] sys_open+0x5b/0x8b
 [<c01091fb>] syscall_call+0x7/0xb

request_module: failed /sbin/modprobe -- block-major-11-1. error =3D 256
request_module: failed /sbin/modprobe -- block-major-11-1. error =3D 256
request_module: failed /sbin/modprobe -- block-major-11-1. error =3D 256



Dmesg=20



PIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x=
1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D306
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2392.592 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514604k/523776k available (1968k kernel code, 8356k reserved, 827k =
data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4718.59 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
=2E... register #00: 01000000
=2E......    : physical APIC id: 01
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00178020
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0020
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... register #03: 00000001
=2E......     : Boot DT    : 1
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
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
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 2391.0998 MHz.
=2E.... host bus clock speed is 132.0888 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
=2E.....................................................
Table [DSDT](id F004) - 410 Objects with 51 Devices 101 Methods 13 Regions
ACPI Namespace successfully loaded at root c03f813c
IOAPIC[0]: Set PCI routing entry (1-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 00=
0000000000F028 on int 9
Completing Region/Field/Buffer/Package initialization:.....................=
=2E....................................................
Initialized 13/13 Regions 6/6 Fields 33/33 Buffers 22/22 Packages (418 node=
s)
Executing all Device _STA and_INI methods:.................................=
=2E..................
52 Devices found containing: 52 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 1-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 1-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:1f[A] -> 1-18 -> IRQ 18
Pin 1-17 already programmed
Pin 1-16 already programmed
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 1-19 -> IRQ 19
Pin 1-18 already programmed
IOAPIC[0]: Set PCI routing entry (1-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 1-23 -> IRQ 23
Pin 1-16 already programmed
Pin 1-17 already programmed
Pin 1-17 already programmed
Pin 1-18 already programmed
Pin 1-19 already programmed
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:05[D] -> 1-20 -> IRQ 20
Pin 1-18 already programmed
Pin 1-19 already programmed
Pin 1-20 already programmed
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:02:07[D] -> 1-21 -> IRQ 21
Pin 1-20 already programmed
Pin 1-19 already programmed
Pin 1-20 already programmed
Pin 1-21 already programmed
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:02:09[D] -> 1-22 -> IRQ 22
Pin 1-20 already programmed
Pin 1-21 already programmed
Pin 1-22 already programmed
Pin 1-23 already programmed
Pin 1-21 already programmed
Pin 1-22 already programmed
Pin 1-23 already programmed
Pin 1-16 already programmed
Pin 1-22 already programmed
Pin 1-23 already programmed
Pin 1-16 already programmed
Pin 1-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
speedstep-smi: signature:0x00008680, command:0x0000e6f5, event:0x00000000, =
perf_level:0x47534943.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2800-0x2807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2808-0x280f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 2F040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 6Y120L0, ATA DISK drive
hdd: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(1=
00)
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: max request size: 128KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA=
(33)
 hdc: unknown partition table
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 505976k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:05:3D:B1:E9, IRQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[18]  MMIO=3D[d1005000-d1005=
7ff]  Max Packet=3D[2048]
SCSI subsystem initialized
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0004830252004f0f]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0001b7000001515b]
sbp2: $Rev: 1082 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: SONY      Model: DVD RW DRU-500A   Rev: 2.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem e088a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001000
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 2, assigned address 2
Disabled Privacy Extensions on device c0380f60(lo)
hub 2-0:1.0: new USB device on port 1, assigned address 2
ip_tables: (C) 2000-2002 Netfilter core team

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+vTLUaz2rXW+gJcRAu1PAJ9F0UBfwbmGjHENZHXSL0BI/aE26wCeNUeN
R8rhWagFOnP4Gyu5bK3TqPQ=
=KEHe
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
