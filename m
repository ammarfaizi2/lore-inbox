Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275263AbTHASVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275264AbTHASVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:21:01 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:30696
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S275263AbTHASU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:20:27 -0400
Date: Fri, 1 Aug 2003 14:22:07 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030801182207.GA3759@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.6.0-test2-mm2
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.52; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello folks,

Under 2.6.0-test2-mm2 keeps getting Badness in device_release at
drivers/base/core.c:84 when loading USB modules on NFORCE2 based board.

uname: Linux blaze 2.6.0-test2-mm2 #1 Thu Jul 31 13:11:05 EDT 2003 i686
unknown on Linux Slackware 9.0, GCC 3.2.2

Device '' does not have a release() function, it is broken and must be
fixed.
Badness in device_release at drivers/base/core.c:84
Call Trace:
[<c021dfd8>] kobject_cleanup+0x88/0x90
[<c02c03ff>] hub_port_connect_change+0x2af/0x330
[<c02bfcfd>] hub_port_status+0x3d/0xb0
[<c02c07bd>] hub_events+0x33d/0x3b0
[<c02c0865>] hub_thread+0x35/0xf0
[<c011b810>] default_wake_function+0x0/0x30
[<c02c0830>] hub_thread+0x0/0xf0
[<c01070c9>] kernel_thread_helper+0x5/0xc
		  =20
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
Device '' does not have a release() function, it is broken and
must be fixed.
Badness in device_release at drivers/base/core.c:84
Call Trace:
[<c021dfd8>] kobject_cleanup+0x88/0x90
[<c02c03ff>] hub_port_connect_change+0x2af/0x330
[<c02bfcfd>] hub_port_status+0x3d/0xb0
[<c02c07bd>] hub_events+0x33d/0x3b0
[<c02c0865>] hub_thread+0x35/0xf0
[<c011b810>] default_wake_function+0x0/0x30
[<c02c0830>] hub_thread+0x0/0xf0
[<c01070c9>] kernel_thread_helper+0x5/0xc
					 =20
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status
0x501
Device '' does not have a release() function, it is
broken and must be fixed.
Badness in device_release at drivers/base/core.c:84
Call Trace:
[<c021dfd8>] kobject_cleanup+0x88/0x90
[<c02c03ff>] hub_port_connect_change+0x2af/0x330
[<c02bfcfd>] hub_port_status+0x3d/0xb0
[<c02c07bd>] hub_events+0x33d/0x3b0
[<c02c0865>] hub_thread+0x35/0xf0
[<c011b810>] default_wake_function+0x0/0x30
[<c02c0830>] hub_thread+0x0/0xf0
[<c01070c9>] kernel_thread_helper+0x5/0xc

Also keep getting oops in radeon module:

[drm] Loading R200 Microcode
Unable to handle kernel NULL pointer dereference at virtual address 00000120
printing eip:
c02a8cae
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c02a8cae>]    Not tainted VLI
EFLAGS: 00210286
EIP is at aic7xxx_proc_info+0x2e/0xc80
eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20   edx: 00000000
esi: 00000400   edi: f1715000   ebp: 412de000   esp: f620fecc
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 3555, threadinfo=3Df620e000 task=3Df6216720)
Stack: 000001f7 00000000 00000000 c013c612 c0379eb0 00000000 00000000 f6613=
340
       00000000 00000000 c0379eb0 00000400 00000400 f1715000 412de000 c0295=
6fc
       c1bb2400 f1715000 f620ff60 00000000 00000400 00000000 c02956c0 c018b=
c91
Call Trace:
[<c013c612>] __alloc_pages+0x92/0x320
[<c02956fc>] proc_scsi_read+0x3c/0x60
[<c02956c0>] proc_scsi_read+0x0/0x60
[<c018bc91>] proc_file_read+0xd1/0x280
[<c015617c>] vfs_read+0xbc/0x130
[<c0156452>] sys_read+0x42/0x70
[<c01091f7>] syscall_call+0x7/0xb
Code: 53 83 ec 2c a1 b8 a6 38 c0 89 44 24 20 8b 98 20 01 00 00 85 db 74
1e 8d b6 00 00 00 00 8b 54 24 20 8b 92 1c 01 00 00 89 54 24 20 <8b> 8a
20 01 00 00 85 c9 75 e8 8b 54 24 20 85 d2 0f 84 e4 0b 00

There also seems to be a problem with SCSI subsystem where /dev/sda
devices are labeled as /dev/sdb as seen in the dmesg.txt attached file.

Regards,

Paul B.


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-full.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.0-test2-mm2 (diffie@blaze) (gcc version 3.2.2) #1 Thu Jul=
 31 13:11:05 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f52c0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
ACPI: RSDP (v000 Nvidia                     ) @ 0x000f6c30
ACPI: RSDT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff7680
ACPI: DSDT (v001 NVIDIA AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3D2.6.0 ro root=3D803 rootflags=3Dquota roo=
t=3D/dev/sdb3
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2205.019 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4358.14 BogoMIPS
Memory: 1033784k/1048512k available (2223k kernel code, 13788k reserved, 59=
4k data, 332k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
=2E.MP-BIOS bug: 8254 timer not connected to IO-APIC
=2E..trying to set up timer (IRQ0) through the 8259A ...  failed.
=2E..trying to set up timer as Virtual Wire IRQ... failed.
=2E..trying to set up timer as ExtINT IRQ... works.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00170011
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
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
=2E.... CPU clock speed is 2204.0719 MHz.
=2E.... host bus clock speed is 400.0858 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfad30, last bus=3D3
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17, disabled)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16, disabled)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:0)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:0)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:0)
00:01:06[D] -> 2-17 -> IRQ 17
Pin 2-19 already programmed
Pin 2-16 already programmed
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
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
pty: 512 Unix98 ptys configured
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux 2.6.0-test2-mm2 with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 control=
ler on pci0000:00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-372200, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=3D43800/16/63
 /dev/ide/host0/bus0/target0/lun0: p1
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
  Vendor:           Model:                   Rev:    =20
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
sda: Spinning up disk......<5>Attached scsi disk sda at scsi0, channel 0, i=
d 3, lun 0
(scsi0:0:6:0) Synchronous at 80.0 Mbyte/sec, offset 63.
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target6/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 0
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
XFS mounting filesystem sdb3
Starting XFS recovery on filesystem: sdb3 (dev: 8/19)
Ending XFS recovery on filesystem: sdb3 (dev: 8/19)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 332k freed
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17, disabled)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16, disabled)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:0)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:0)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:0)
00:01:06[D] -> 2-17 -> IRQ 17
Pin 2-19 already programmed
Pin 2-16 already programmed
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
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
pty: 512 Unix98 ptys configured
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux 2.6.0-test2-mm2 with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 control=
ler on pci0000:00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-372200, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=3D43800/16/63
 /dev/ide/host0/bus0/target0/lun0: p1
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
  Vendor:           Model:                   Rev:    =20
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
sda: Spinning up disk......<5>Attached scsi disk sda at scsi0, channel 0, i=
d 3, lun 0
(scsi0:0:6:0) Synchronous at 80.0 Mbyte/sec, offset 63.
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target6/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 0
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
XFS mounting filesystem sdb3
Ending clean XFS mount for filesystem: sdb3
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 332k freed
Adding 248968k swap on /dev/sdb10.  Priority:-1 extents:1
(scsi0:0:4:0) Synchronous at 20.0 Mbyte/sec, offset 16.
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.0.
XFS mounting filesystem sdb5
Ending clean XFS mount for filesystem: sdb5
XFS mounting filesystem sdb6
Ending clean XFS mount for filesystem: sdb6
XFS mounting filesystem sdb7
Ending clean XFS mount for filesystem: sdb7
XFS mounting filesystem sdb8
Ending clean XFS mount for filesystem: sdb8
XFS mounting filesystem sdb9
Ending clean XFS mount for filesystem: sdb9
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
Real Time Clock Driver v1.11
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
Intel(R) PRO/1000 Network Driver - version 5.1.13-k2
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
ohci1394: $Rev: 1011 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D[22]  MMIO=3D[ce084000-ce0847ff]  Ma=
x Packet=3D[2048]
ohci1394_0: SelfID received outside of bus reset sequence
Intel 810 + AC97 Audio, version 0.24, 13:15:12 Jul 31 2003
PCI: Setting latency timer of device 0000:00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xd000 and 0xe400, MEM 0x0000 and 0x0=
000, IRQ 21
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value =3D 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels =3D 6
i810_audio: setting clocking to 48648
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
ehci_hcd 0000:00:02.2: irq 21, pci mem f88c4000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci-hcd 0000:00:02.0: PCI device 10de:0067 (nVidia Corporation)
ohci-hcd 0000:00:02.0: irq 20, pci mem f8970000
ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci-hcd 0000:00:02.1: PCI device 10de:0067 (nVidia Corporation)
ohci-hcd 0000:00:02.1: irq 22, pci mem f8972000
ohci-hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 512M @ 0xa0000000
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
Device '' does not have a release() function, it is broken and must be fixe=
d.
Badness in device_release at drivers/base/core.c:84
Call Trace:
 [<c021dfd8>] kobject_cleanup+0x88/0x90
 [<c02c03ff>] hub_port_connect_change+0x2af/0x330
 [<c02bfcfd>] hub_port_status+0x3d/0xb0
 [<c02c07bd>] hub_events+0x33d/0x3b0
 [<c02c0865>] hub_thread+0x35/0xf0
 [<c011b810>] default_wake_function+0x0/0x30
 [<c02c0830>] hub_thread+0x0/0xf0
 [<c01070c9>] kernel_thread_helper+0x5/0xc

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
Device '' does not have a release() function, it is broken and must be fixe=
d.
Badness in device_release at drivers/base/core.c:84
Call Trace:
 [<c021dfd8>] kobject_cleanup+0x88/0x90
 [<c02c03ff>] hub_port_connect_change+0x2af/0x330
 [<c02bfcfd>] hub_port_status+0x3d/0xb0
 [<c02c07bd>] hub_events+0x33d/0x3b0
 [<c02c0865>] hub_thread+0x35/0xf0
 [<c011b810>] default_wake_function+0x0/0x30
 [<c02c0830>] hub_thread+0x0/0xf0
 [<c01070c9>] kernel_thread_helper+0x5/0xc

hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
Device '' does not have a release() function, it is broken and must be fixe=
d.
Badness in device_release at drivers/base/core.c:84
Call Trace:
 [<c021dfd8>] kobject_cleanup+0x88/0x90
 [<c02c03ff>] hub_port_connect_change+0x2af/0x330
 [<c02bfcfd>] hub_port_status+0x3d/0xb0
 [<c02c07bd>] hub_events+0x33d/0x3b0
 [<c02c0865>] hub_thread+0x35/0xf0
 [<c011b810>] default_wake_function+0x0/0x30
 [<c02c0830>] hub_thread+0x0/0xf0
 [<c01070c9>] kernel_thread_helper+0x5/0xc

hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
hub 2-1:0: USB hub found
hub 2-1:0: 3 ports detected
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 2, assigned address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with Intelli=
Eye(TM)] on usb-0000:00:02.0-2
hub 2-1:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-1:0: new USB device on port 1, assigned address 4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000:=
00:02.0-1.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:00=
:02.0-1.1
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 1x mode
[drm] Loading R200 Microcode
Unable to handle kernel NULL pointer dereference at virtual address 00000120
 printing eip:
c02a8cae
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
CPU:    0
EIP:    0060:[<c02a8cae>]    Not tainted VLI
EFLAGS: 00210286
EIP is at aic7xxx_proc_info+0x2e/0xc80
eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20   edx: 00000000
esi: 00000400   edi: f1715000   ebp: 412de000   esp: f620fecc
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 3555, threadinfo=3Df620e000 task=3Df6216720)
Stack: 000001f7 00000000 00000000 c013c612 c0379eb0 00000000 00000000 f6613=
340=20
       00000000 00000000 c0379eb0 00000400 00000400 f1715000 412de000 c0295=
6fc=20
       c1bb2400 f1715000 f620ff60 00000000 00000400 00000000 c02956c0 c018b=
c91=20
Call Trace:
 [<c013c612>] __alloc_pages+0x92/0x320
 [<c02956fc>] proc_scsi_read+0x3c/0x60
 [<c02956c0>] proc_scsi_read+0x0/0x60
 [<c018bc91>] proc_file_read+0xd1/0x280
 [<c015617c>] vfs_read+0xbc/0x130
 [<c0156452>] sys_read+0x42/0x70
 [<c01091f7>] syscall_call+0x7/0xb

Code: 53 83 ec 2c a1 b8 a6 38 c0 89 44 24 20 8b 98 20 01 00 00 85 db 74 1e =
8d b6 00 00 00 00 8b 54 24 20 8b 92 1c 01 00 00 89 54 24 20 <8b> 8a 20 01 0=
0 00 85 c9 75 e8 8b 54 24 20 85 d2 0f 84 e4 0b 00=20
=20

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.8 on i686 2.6.0-test2-mm2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2-mm2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jul 31 11:11:24 blaze kernel: cpu: 0, clocks: 4009054, slice: 2004527
Jul 31 12:06:57 blaze kernel: cpu: 0, clocks: 4009123, slice: 2004561
Jul 31 12:32:01 blaze kernel: cpu: 0, clocks: 4009252, slice: 2004626
Jul 31 14:00:47 blaze kernel: Call Trace:
Jul 31 14:00:47 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:00:47 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:00:47 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:00:47 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:00:47 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:00:47 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:00:47 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:00:47 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:00:47 blaze kernel: Call Trace:
Jul 31 14:00:47 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:00:47 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:00:47 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:00:47 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:00:47 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:00:47 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:00:47 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:00:47 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

Jul 31 14:18:03 blaze kernel: Call Trace:
Jul 31 14:18:03 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:18:03 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:18:03 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:18:03 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:18:03 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:18:03 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:18:03 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:18:03 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:18:03 blaze kernel: Call Trace:
Jul 31 14:18:03 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:18:03 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:18:03 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:18:03 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:18:03 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:18:03 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:18:03 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:18:03 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:18:20 blaze kernel: Call Trace:
Jul 31 14:18:20 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:18:20 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:18:20 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:18:20 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:18:20 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:18:20 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:18:20 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:18:20 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:20:55 blaze kernel: Call Trace:
Jul 31 14:20:55 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:20:55 blaze kernel:  [<c0264d03>] device_unregister+0x13/0x30
Jul 31 14:20:55 blaze kernel:  [<c02bd9a9>] usb_disconnect+0xa9/0x100
Jul 31 14:20:55 blaze kernel:  [<c02c0475>] hub_port_connect_change+0x325/0=
x330
Jul 31 14:20:55 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:20:55 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:20:55 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:20:55 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:20:55 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:20:55 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c0264d03 <sysdev_shutdown+d3/120>
Trace; c02bd9a9 <dvd_read_struct+39/90>
Trace; c02c0475 <cdrom_sysctl_info+2f5/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

Jul 31 14:23:49 blaze kernel: Call Trace:
Jul 31 14:23:49 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:23:49 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:23:49 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:23:49 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:23:49 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:23:49 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:23:49 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:23:49 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:23:49 blaze kernel: Call Trace:
Jul 31 14:23:49 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:23:49 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:23:49 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:23:49 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:23:49 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:23:49 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:23:49 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:23:49 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

Jul 31 14:46:37 blaze kernel: Unable to handle kernel paging request at vir=
tual address f885d6c8
Jul 31 14:46:37 blaze kernel: f8b27e5b
Jul 31 14:46:37 blaze kernel: *pde =3D 37f84067
Jul 31 14:46:37 blaze kernel: Oops: 0000 [#1]
Jul 31 14:46:37 blaze kernel: CPU:    0
Jul 31 14:46:37 blaze kernel: EIP:    0060:[<f8b27e5b>]    Tainted: PF  VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 31 14:46:37 blaze kernel: EFLAGS: 00213212
Jul 31 14:46:37 blaze kernel: eax: 00000000   ebx: 00000000   ecx: 00000000=
   edx: c0377538
Jul 31 14:46:37 blaze kernel: esi: 00000001   edi: 00000380   ebp: 00000000=
   esp: f60bbea8
Jul 31 14:46:37 blaze kernel: ds: 007b   es: 007b   ss: 0068
Jul 31 14:46:37 blaze kernel: Stack: c041c356 00203246 00000000 f8b4f570 f8=
b4f0c8 00000000 f8b27ee8 f60bbef4=20
Jul 31 14:46:37 blaze kernel:        f8b4f51c cb000000 f66b5980 f8b4f570 f8=
b4f570 f74f4140 f8b4f3b0 f8b280f0=20
Jul 31 14:46:37 blaze kernel:        f8b3db20 00000000 00000063 f8b2b296 00=
000000 00000001 f6fcb540 f8b2b35d=20
Jul 31 14:46:37 blaze kernel: Call Trace:
Jul 31 14:46:37 blaze kernel:  [<f8b27ee8>] agp_backend_initialize+0x28/0x1=
b0 [fglrx]
Jul 31 14:46:37 blaze kernel:  [<f8b280f0>] __fgl_agp_init+0x30/0x50 [fglrx]
Jul 31 14:46:37 blaze kernel:  [<f8b2b296>] __ke_firegl_agpgart_available+0=
x16/0x80 [fglrx]
Jul 31 14:46:37 blaze kernel:  [<f8b2b35d>] __ke_agp_available+0x2d/0x30 [f=
glrx]
Jul 31 14:46:37 blaze kernel:  [<f8b3b6e2>] drm_agp_init+0x42/0x90 [fglrx]
Jul 31 14:46:37 blaze kernel:  [<f8b3a8a4>] _firegl_agp_acquire+0x74/0x330 =
[fglrx]
Jul 31 14:46:37 blaze kernel:  [<f8b3abe1>] firegl_agp_acquire+0x61/0x90 [f=
glrx]
Jul 31 14:46:37 blaze kernel:  [<f8b3ab80>] firegl_agp_acquire+0x0/0x90 [fg=
lrx]
Jul 31 14:46:37 blaze kernel:  [<f8b2bef6>] firegl_ioctl+0x146/0x1b0 [fglrx]
Jul 31 14:46:37 blaze kernel:  [<c0169a33>] sys_ioctl+0xf3/0x280
Jul 31 14:46:37 blaze kernel:  [<c01091f7>] syscall_call+0x7/0xb
Jul 31 14:46:37 blaze kernel: Code: c7 89 c6 eb c5 8d 74 26 00 8d bc 27 00 =
00 00 00 55 57 56 be 01 00 00 00 53 83 ec 08 8b 3d 28 79 42 c0 81 c7 00 00 =
00 40 c1 ef 14 <3b> 3d c8 d6 85 f8 7e 10 b8 c0 d6 85 f8 46 3b 3c f0 7e 05 8=
3 fe=20


>>EIP; f8b27e5b <_end+386c87eb/3fb9e990>   <=3D=3D=3D=3D=3D

>>edx; c0377538 <__func__.0+2e7ef/36427>
>>esp; f60bbea8 <_end+35c5c838/3fb9e990>

Trace; f8b27ee8 <_end+386c8878/3fb9e990>
Trace; f8b280f0 <_end+386c8a80/3fb9e990>
Trace; f8b2b296 <_end+386cbc26/3fb9e990>
Trace; f8b2b35d <_end+386cbced/3fb9e990>
Trace; f8b3b6e2 <_end+386dc072/3fb9e990>
Trace; f8b3a8a4 <_end+386db234/3fb9e990>
Trace; f8b3abe1 <_end+386db571/3fb9e990>
Trace; f8b3ab80 <_end+386db510/3fb9e990>
Trace; f8b2bef6 <_end+386cc886/3fb9e990>
Trace; c0169a33 <__posix_lock_file+173/5f0>
Trace; c01091f7 <syscall_call+7/b>

Code;  f8b27e30 <_end+386c87c0/3fb9e990>
00000000 <_EIP>:
Code;  f8b27e30 <_end+386c87c0/3fb9e990>
   0:   c7 89 c6 eb c5 8d 74      movl   $0x8d002674,0x8dc5ebc6(%ecx)
Code;  f8b27e37 <_end+386c87c7/3fb9e990>
   7:   26 00 8d=20
Code;  f8b27e3a <_end+386c87ca/3fb9e990>
   a:   bc 27 00 00 00            mov    $0x27,%esp
Code;  f8b27e3f <_end+386c87cf/3fb9e990>
   f:   00 55 57                  add    %dl,0x57(%ebp)
Code;  f8b27e42 <_end+386c87d2/3fb9e990>
  12:   56                        push   %esi
Code;  f8b27e43 <_end+386c87d3/3fb9e990>
  13:   be 01 00 00 00            mov    $0x1,%esi
Code;  f8b27e48 <_end+386c87d8/3fb9e990>
  18:   53                        push   %ebx
Code;  f8b27e49 <_end+386c87d9/3fb9e990>
  19:   83 ec 08                  sub    $0x8,%esp
Code;  f8b27e4c <_end+386c87dc/3fb9e990>
  1c:   8b 3d 28 79 42 c0         mov    0xc0427928,%edi
Code;  f8b27e52 <_end+386c87e2/3fb9e990>
  22:   81 c7 00 00 00 40         add    $0x40000000,%edi
Code;  f8b27e58 <_end+386c87e8/3fb9e990>
  28:   c1 ef 14                  shr    $0x14,%edi
Code;  f8b27e5b <_end+386c87eb/3fb9e990>   <=3D=3D=3D=3D=3D
  2b:   3b 3d c8 d6 85 f8         cmp    0xf885d6c8,%edi   <=3D=3D=3D=3D=3D
Code;  f8b27e61 <_end+386c87f1/3fb9e990>
  31:   7e 10                     jle    43 <_EIP+0x43>
Code;  f8b27e63 <_end+386c87f3/3fb9e990>
  33:   b8 c0 d6 85 f8            mov    $0xf885d6c0,%eax
Code;  f8b27e68 <_end+386c87f8/3fb9e990>
  38:   46                        inc    %esi
Code;  f8b27e69 <_end+386c87f9/3fb9e990>
  39:   3b 3c f0                  cmp    (%eax,%esi,8),%edi
Code;  f8b27e6c <_end+386c87fc/3fb9e990>
  3c:   7e 05                     jle    43 <_EIP+0x43>
Code;  f8b27e6e <_end+386c87fe/3fb9e990>
  3e:   83                        .byte 0x83
Code;  f8b27e6f <_end+386c87ff/3fb9e990>
  3f:   fe                        .byte 0xfe

Jul 31 14:49:12 blaze kernel: Call Trace:
Jul 31 14:49:12 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:49:12 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:49:12 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:49:12 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:49:12 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:49:12 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:49:12 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:49:12 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:49:12 blaze kernel: Call Trace:
Jul 31 14:49:12 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:49:12 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:49:12 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:49:12 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:49:12 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:49:12 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:49:12 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:49:12 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Jul 31 14:49:31 blaze kernel: Call Trace:
Jul 31 14:49:31 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Jul 31 14:49:31 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Jul 31 14:49:31 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Jul 31 14:49:31 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Jul 31 14:49:31 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Jul 31 14:49:31 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Jul 31 14:49:31 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Jul 31 14:49:31 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

Aug  1 02:49:43 blaze kernel: Call Trace:
Aug  1 02:49:43 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:49:43 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:49:43 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:49:43 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:49:43 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:49:43 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:49:43 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:49:43 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 02:49:43 blaze kernel: Call Trace:
Aug  1 02:49:43 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:49:43 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:49:43 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:49:43 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:49:43 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:49:43 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:49:43 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:49:43 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 02:49:43 blaze kernel: Call Trace:
Aug  1 02:49:43 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:49:43 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:49:43 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:49:43 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:49:43 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:49:43 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:49:43 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:49:43 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

Aug  1 02:53:16 blaze kernel: Call Trace:
Aug  1 02:53:16 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:53:16 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:53:16 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:53:16 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:53:16 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:53:16 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:53:16 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:53:16 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 02:53:16 blaze kernel: Call Trace:
Aug  1 02:53:16 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:53:16 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:53:16 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:53:16 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:53:16 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:53:16 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:53:16 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:53:16 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 02:53:16 blaze kernel: Call Trace:
Aug  1 02:53:16 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 02:53:16 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 02:53:16 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 02:53:16 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 02:53:16 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 02:53:16 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 02:53:16 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 02:53:16 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 04:13:20 blaze kernel: Unable to handle kernel NULL pointer derefere=
nce at virtual address 00000120
Aug  1 04:13:20 blaze kernel: c02a8cae
Aug  1 04:13:20 blaze kernel: *pde =3D 00000000
Aug  1 04:13:20 blaze kernel: Oops: 0000 [#1]
Aug  1 04:13:20 blaze kernel: CPU:    0
Aug  1 04:13:20 blaze kernel: EIP:    0060:[<c02a8cae>]    Not tainted VLI
Aug  1 04:13:20 blaze kernel: EFLAGS: 00210286
Aug  1 04:13:20 blaze kernel: eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20=
   edx: 00000000
Aug  1 04:13:20 blaze kernel: esi: 00000400   edi: f3a10000   ebp: 412de000=
   esp: f6219ecc
Aug  1 04:13:20 blaze kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 04:13:20 blaze kernel: Stack: 000001f7 00000000 00000000 c013c612 c0=
379eb0 00000000 00000000 f65e5340=20
Aug  1 04:13:20 blaze kernel:        00000000 00000000 c0379eb0 00000400 00=
000400 f3a10000 412de000 c02956fc=20
Aug  1 04:13:20 blaze kernel:        c1bb2400 f3a10000 f6219f60 00000000 00=
000400 00000000 c02956c0 c018bc91=20
Aug  1 04:13:20 blaze kernel: Call Trace:
Aug  1 04:13:20 blaze kernel:  [<c013c612>] __alloc_pages+0x92/0x320
Aug  1 04:13:20 blaze kernel:  [<c02956fc>] proc_scsi_read+0x3c/0x60
Aug  1 04:13:20 blaze kernel:  [<c02956c0>] proc_scsi_read+0x0/0x60
Aug  1 04:13:20 blaze kernel:  [<c018bc91>] proc_file_read+0xd1/0x280
Aug  1 04:13:20 blaze kernel:  [<c015617c>] vfs_read+0xbc/0x130
Aug  1 04:13:20 blaze kernel:  [<c0156452>] sys_read+0x42/0x70
Aug  1 04:13:20 blaze kernel:  [<c01091f7>] syscall_call+0x7/0xb
Aug  1 04:13:20 blaze kernel: Code: 53 83 ec 2c a1 b8 a6 38 c0 89 44 24 20 =
8b 98 20 01 00 00 85 db 74 1e 8d b6 00 00 00 00 8b 54 24 20 8b 92 1c 01 00 =
00 89 54 24 20 <8b> 8a 20 01 00 00 85 c9 75 e8 8b 54 24 20 85 d2 0f 84 e4 0=
b 00=20


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

>>EIP; c02a8cae <configure_termination+58e/680>   <=3D=3D=3D=3D=3D

>>eax; c1bb25b0 <_end+1752f40/3fb9e990>
>>ebx; c1bb2400 <_end+1752d90/3fb9e990>
>>ecx; c038bb20 <init_mm+0/160>
>>edi; f3a10000 <_end+335b0990/3fb9e990>
>>esp; f6219ecc <_end+35dba85c/3fb9e990>

Trace; c013c612 <do_writepages+32/40>
Trace; c02956fc <scsi_scan_target+3c/c0>
Trace; c02956c0 <scsi_scan_target+0/c0>
Trace; c018bc91 <kstat_read_proc+1c1/300>
Trace; c015617c <__set_page_dirty_buffers+ec/170>
Trace; c0156452 <invalidate_inode_buffers+52/70>
Trace; c01091f7 <syscall_call+7/b>

Code;  c02a8c83 <configure_termination+563/680>
00000000 <_EIP>:
Code;  c02a8c83 <configure_termination+563/680>
   0:   53                        push   %ebx
Code;  c02a8c84 <configure_termination+564/680>
   1:   83 ec 2c                  sub    $0x2c,%esp
Code;  c02a8c87 <configure_termination+567/680>
   4:   a1 b8 a6 38 c0            mov    0xc038a6b8,%eax
Code;  c02a8c8c <configure_termination+56c/680>
   9:   89 44 24 20               mov    %eax,0x20(%esp,1)
Code;  c02a8c90 <configure_termination+570/680>
   d:   8b 98 20 01 00 00         mov    0x120(%eax),%ebx
Code;  c02a8c96 <configure_termination+576/680>
  13:   85 db                     test   %ebx,%ebx
Code;  c02a8c98 <configure_termination+578/680>
  15:   74 1e                     je     35 <_EIP+0x35>
Code;  c02a8c9a <configure_termination+57a/680>
  17:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c02a8ca0 <configure_termination+580/680>
  1d:   8b 54 24 20               mov    0x20(%esp,1),%edx
Code;  c02a8ca4 <configure_termination+584/680>
  21:   8b 92 1c 01 00 00         mov    0x11c(%edx),%edx
Code;  c02a8caa <configure_termination+58a/680>
  27:   89 54 24 20               mov    %edx,0x20(%esp,1)
Code;  c02a8cae <configure_termination+58e/680>   <=3D=3D=3D=3D=3D
  2b:   8b 8a 20 01 00 00         mov    0x120(%edx),%ecx   <=3D=3D=3D=3D=3D
Code;  c02a8cb4 <configure_termination+594/680>
  31:   85 c9                     test   %ecx,%ecx
Code;  c02a8cb6 <configure_termination+596/680>
  33:   75 e8                     jne    1d <_EIP+0x1d>
Code;  c02a8cb8 <configure_termination+598/680>
  35:   8b 54 24 20               mov    0x20(%esp,1),%edx
Code;  c02a8cbc <configure_termination+59c/680>
  39:   85 d2                     test   %edx,%edx
Code;  c02a8cbe <configure_termination+59e/680>
  3b:   0f                        .byte 0xf
Code;  c02a8cbf <configure_termination+59f/680>
  3c:   84 e4                     test   %ah,%ah
Code;  c02a8cc1 <configure_termination+5a1/680>
  3e:   0b 00                     or     (%eax),%eax

Aug  1 13:13:31 blaze kernel: Call Trace:
Aug  1 13:13:31 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 13:13:31 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 13:13:31 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 13:13:31 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 13:13:31 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 13:13:31 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 13:13:31 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 13:13:31 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 13:13:31 blaze kernel: Call Trace:
Aug  1 13:13:31 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 13:13:31 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 13:13:31 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 13:13:31 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 13:13:31 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 13:13:31 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 13:13:31 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 13:13:31 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 13:13:31 blaze kernel: Call Trace:
Aug  1 13:13:31 blaze kernel:  [<c021dfd8>] kobject_cleanup+0x88/0x90
Aug  1 13:13:31 blaze kernel:  [<c02c03ff>] hub_port_connect_change+0x2af/0=
x330
Aug  1 13:13:31 blaze kernel:  [<c02bfcfd>] hub_port_status+0x3d/0xb0
Aug  1 13:13:31 blaze kernel:  [<c02c07bd>] hub_events+0x33d/0x3b0
Aug  1 13:13:31 blaze kernel:  [<c02c0865>] hub_thread+0x35/0xf0
Aug  1 13:13:31 blaze kernel:  [<c011b810>] default_wake_function+0x0/0x30
Aug  1 13:13:31 blaze kernel:  [<c02c0830>] hub_thread+0x0/0xf0
Aug  1 13:13:31 blaze kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Aug  1 13:52:57 blaze kernel: Unable to handle kernel NULL pointer derefere=
nce at virtual address 00000120
Aug  1 13:52:57 blaze kernel: c02a8cae
Aug  1 13:52:57 blaze kernel: *pde =3D 00000000
Aug  1 13:52:57 blaze kernel: Oops: 0000 [#1]
Aug  1 13:52:57 blaze kernel: CPU:    0
Aug  1 13:52:57 blaze kernel: EIP:    0060:[<c02a8cae>]    Not tainted VLI
Aug  1 13:52:57 blaze kernel: EFLAGS: 00210286
Aug  1 13:52:57 blaze kernel: eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20=
   edx: 00000000
Aug  1 13:52:57 blaze kernel: esi: 00000400   edi: f1715000   ebp: 412de000=
   esp: f620fecc
Aug  1 13:52:57 blaze kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 13:52:57 blaze kernel: Stack: 000001f7 00000000 00000000 c013c612 c0=
379eb0 00000000 00000000 f6613340=20
Aug  1 13:52:57 blaze kernel:        00000000 00000000 c0379eb0 00000400 00=
000400 f1715000 412de000 c02956fc=20
Aug  1 13:52:57 blaze kernel:        c1bb2400 f1715000 f620ff60 00000000 00=
000400 00000000 c02956c0 c018bc91=20
Aug  1 13:52:57 blaze kernel: Call Trace:
Aug  1 13:52:57 blaze kernel:  [<c013c612>] __alloc_pages+0x92/0x320
Aug  1 13:52:57 blaze kernel:  [<c02956fc>] proc_scsi_read+0x3c/0x60
Aug  1 13:52:57 blaze kernel:  [<c02956c0>] proc_scsi_read+0x0/0x60
Aug  1 13:52:57 blaze kernel:  [<c018bc91>] proc_file_read+0xd1/0x280
Aug  1 13:52:57 blaze kernel:  [<c015617c>] vfs_read+0xbc/0x130
Aug  1 13:52:57 blaze kernel:  [<c0156452>] sys_read+0x42/0x70
Aug  1 13:52:57 blaze kernel:  [<c01091f7>] syscall_call+0x7/0xb
Aug  1 13:52:57 blaze kernel: Code: 53 83 ec 2c a1 b8 a6 38 c0 89 44 24 20 =
8b 98 20 01 00 00 85 db 74 1e 8d b6 00 00 00 00 8b 54 24 20 8b 92 1c 01 00 =
00 89 54 24 20 <8b> 8a 20 01 00 00 85 c9 75 e8 8b 54 24 20 85 d2 0f 84 e4 0=
b 00=20


Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>
Trace; c021dfd8 <rwsem_down_read_failed+18/150>
Trace; c02c03ff <cdrom_sysctl_info+27f/650>
Trace; c02bfcfd <mmc_ioctl+e4d/f10>
Trace; c02c07bd <cdrom_sysctl_info+63d/650>
Trace; c02c0865 <cdrom_update_settings+95/110>
Trace; c011b810 <setscheduler+2c0/300>
Trace; c02c0830 <cdrom_update_settings+60/110>
Trace; c01070c9 <kernel_thread_helper+5/c>

>>EIP; c02a8cae <configure_termination+58e/680>   <=3D=3D=3D=3D=3D

>>eax; c1bb25b0 <_end+1752f40/3fb9e990>
>>ebx; c1bb2400 <_end+1752d90/3fb9e990>
>>ecx; c038bb20 <init_mm+0/160>
>>edi; f1715000 <_end+312b5990/3fb9e990>
>>esp; f620fecc <_end+35db085c/3fb9e990>

Trace; c013c612 <do_writepages+32/40>
Trace; c02956fc <scsi_scan_target+3c/c0>
Trace; c02956c0 <scsi_scan_target+0/c0>
Trace; c018bc91 <kstat_read_proc+1c1/300>
Trace; c015617c <__set_page_dirty_buffers+ec/170>
Trace; c0156452 <invalidate_inode_buffers+52/70>
Trace; c01091f7 <syscall_call+7/b>

Code;  c02a8c83 <configure_termination+563/680>
00000000 <_EIP>:
Code;  c02a8c83 <configure_termination+563/680>
   0:   53                        push   %ebx
Code;  c02a8c84 <configure_termination+564/680>
   1:   83 ec 2c                  sub    $0x2c,%esp
Code;  c02a8c87 <configure_termination+567/680>
   4:   a1 b8 a6 38 c0            mov    0xc038a6b8,%eax
Code;  c02a8c8c <configure_termination+56c/680>
   9:   89 44 24 20               mov    %eax,0x20(%esp,1)
Code;  c02a8c90 <configure_termination+570/680>
   d:   8b 98 20 01 00 00         mov    0x120(%eax),%ebx
Code;  c02a8c96 <configure_termination+576/680>
  13:   85 db                     test   %ebx,%ebx
Code;  c02a8c98 <configure_termination+578/680>
  15:   74 1e                     je     35 <_EIP+0x35>
Code;  c02a8c9a <configure_termination+57a/680>
  17:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c02a8ca0 <configure_termination+580/680>
  1d:   8b 54 24 20               mov    0x20(%esp,1),%edx
Code;  c02a8ca4 <configure_termination+584/680>
  21:   8b 92 1c 01 00 00         mov    0x11c(%edx),%edx
Code;  c02a8caa <configure_termination+58a/680>
  27:   89 54 24 20               mov    %edx,0x20(%esp,1)
Code;  c02a8cae <configure_termination+58e/680>   <=3D=3D=3D=3D=3D
  2b:   8b 8a 20 01 00 00         mov    0x120(%edx),%ecx   <=3D=3D=3D=3D=3D
Code;  c02a8cb4 <configure_termination+594/680>
  31:   85 c9                     test   %ecx,%ecx
Code;  c02a8cb6 <configure_termination+596/680>
  33:   75 e8                     jne    1d <_EIP+0x1d>
Code;  c02a8cb8 <configure_termination+598/680>
  35:   8b 54 24 20               mov    0x20(%esp,1),%edx
Code;  c02a8cbc <configure_termination+59c/680>
  39:   85 d2                     test   %edx,%edx
Code;  c02a8cbe <configure_termination+59e/680>
  3b:   0f                        .byte 0xf
Code;  c02a8cbf <configure_termination+59f/680>
  3c:   84 e4                     test   %ah,%ah
Code;  c02a8cc1 <configure_termination+5a1/680>
  3e:   0b 00                     or     (%eax),%eax


6 warnings and 1 error issued.  Results may not be reliable.

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Kq/PIymMQsXoRDARAsqcAJ9tzyznzIBQuUW+H/d23WKsj+ThVQCfU4rL
S++Gfusbnb2u3Ftun6TaMAM=
=8wX3
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
