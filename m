Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTGMMj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 08:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTGMMj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 08:39:59 -0400
Received: from tag.witbe.net ([81.88.96.48]:30225 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264242AbTGMMjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 08:39:54 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.5.75] Oops at boot : kobject_get from nbd_init
Date: Sun, 13 Jul 2003 14:54:39 +0200
Message-ID: <010a01c3493d$ebec23e0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've the following when booting a vanilla 2.5.75, no module configured,
just plain stock kernel.

LILO boot: debug
Loading debug.............................................
Linux version 2.5.75 (root@donald.as2917.net) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sun Jul 13 14:44:22 CEST 2003
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f5820
ACPI: RSDT (v001 ASUS   P4S8X    16944.11825) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S8X    16944.11825) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   P4S8X    16944.11825) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S8X    16944.11825) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S8X    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=debug ro BOOT_FILE=/boot/vmlinuz-2.5.75 panic=30 idebus=66 hdd=ide-cd console=tty1
console=ttyS0
ide_setup: idebus=66
ide_setup: hdd=ide-cd
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2423.819 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 513092k/524272k available (3398k kernel code, 10388k reserved, 1097k data, 396k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0438 MHz.
..... host bus clock speed is 134.0635 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf11a0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
Linux Plug and Play Support v0.96 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: No IRQ known for interrupt pin A of device 0000:00:03.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported SiS chipset (device id: 0648), you might want to try agp_try_unsupported=1.
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 920C
lp0: using parport0 (polling).
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Unable to handle kernel paging request at virtual address 33cc33e8
 printing eip:
c0256509
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0256509>]    Not tainted
EFLAGS: 00010206
EIP is at kobject_get+0xf/0x4e
eax: 33cc33d4   ebx: 33cc33d4   ecx: c04725cd   edx: c049a8bc
esi: dfd8fd3c   edi: dfd8fd3c   ebp: 00000440   esp: dff8df3c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff8c000 task=dff8f880)
Stack: dfd90bfc dfd90bfc dfd90bfc ffffffff dfd8fd3c c0256227 33cc33d4 dfd8fc00 
       c02563dd dfd8fd3c dfd8fd3c 00000014 dfd8fc00 c05ee1e8 c02c7e5f dfd8fd3c 
       00000014 c049a8ba c04725c8 dfd90b80 c05ee1e8 00000010 c0580430 dfd90b80 
Call Trace:
 [<c0256227>] kobject_init+0x2d/0x48
 [<c02563dd>] kobject_register+0x1b/0x5a
 [<c02c7e5f>] blk_register_queue+0x83/0xa8
 [<c0580430>] nbd_init+0x154/0x1ac
 [<c02c8cd8>] exact_match+0x0/0x8
 [<c056871b>] do_initcalls+0x27/0x94
 [<c012c689>] init_workqueues+0xf/0x26
 [<c010509a>] init+0x36/0x194
 [<c0105064>] init+0x0/0x194
 [<c0108a09>] kernel_thread_helper+0x5/0xc

Code: 8b 43 14 85 c0 74 0d ff 43 14 89 d8 8b 5c 24 10 83 c4 14 c3 
 <0>Kernel panic: Attempted to kill init!
 <0>Rebooting in 30 seconds..


