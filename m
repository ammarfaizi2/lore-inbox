Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268791AbTBZP5B>; Wed, 26 Feb 2003 10:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268786AbTBZP5B>; Wed, 26 Feb 2003 10:57:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22972 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268791AbTBZP4E>; Wed, 26 Feb 2003 10:56:04 -0500
Date: Wed, 26 Feb 2003 08:06:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: New: unexpected IO-APIC
Message-ID: <6500000.1046275575@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=410

           Summary: unexpected IO-APIC, please file a report at
                    http://bugzilla.kernel.org
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: MurrayR@brain.org


Distribution: Mandrake Cooker
Hardware Environment: ASUS P4S533 (SiS645DX chipset)
Software Environment:
Problem Description:
The "unexpected IO-APIC" message at boot.
Also applies to all versions from 2.5.58 - I didn't go back any further to
see. cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1991.228
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3932.16

Contents of /var/log/messages:

Feb 26 10:33:24 Master kernel: Inspecting /boot/System.map-2.5.62
Feb 26 10:33:24 Master kernel: Loaded 27046 symbols from
/boot/System.map-2.5.62. Feb 26 10:33:24 Master kernel: Symbols match
kernel version 2.5.62. Feb 26 10:33:24 Master kernel: No module symbols
loaded - kernel modules not enabled. 
Feb 26 10:33:24 Master kernel: Linux version 2.5.62 (grimau@Master.Wizards)
(gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-1mdk)) #1 Mon Feb 17 21:57:10
EST 2003 Feb 26 10:33:24 Master kernel: Video mode to be used for restore
is 31a Feb 26 10:33:24 Master kernel: BIOS-provided physical RAM map:
Feb 26 10:33:24 Master kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 0000000000100000 -
000000003fffc000 (usable)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 000000003fffc000 -
000000003ffff000 (ACPI data)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 000000003ffff000 -
0000000040000000 (ACPI NVS)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Feb 26 10:33:24 Master kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Feb 26 10:33:24 Master kernel: 127MB HIGHMEM available.
Feb 26 10:33:24 Master kernel: 896MB LOWMEM available.
Feb 26 10:33:24 Master kernel: On node 0 totalpages: 262140
Feb 26 10:33:24 Master kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 26 10:33:24 Master kernel:   Normal zone: 225280 pages, LIFO batch:16
Feb 26 10:33:24 Master kernel:   HighMem zone: 32764 pages, LIFO batch:7
Feb 26 10:33:24 Master kernel: ACPI: RSDP (v000 ASUS
) @ 0x000f6860
Feb 26 10:33:24 Master kernel: ACPI: RSDT (v001 ASUS   P4S533
16944.11825) @ 0x3fffc000
Feb 26 10:33:24 Master kernel: ACPI: FADT (v001 ASUS   P4S533
16944.11825) @ 0x3fffc100
Feb 26 10:33:24 Master kernel: ACPI: BOOT (v001 ASUS   P4S533
16944.11825) @ 0x3fffc040
Feb 26 10:33:24 Master kernel: ACPI: MADT (v001 ASUS   P4S533
16944.11825) @ 0x3fffc080
Feb 26 10:33:24 Master kernel: ACPI: DSDT (v001   ASUS P4S533
00000.04096) @ 0x00000000
Feb 26 10:33:24 Master kernel: ACPI: BIOS passes blacklist
Feb 26 10:33:24 Master kernel: ACPI: Local APIC address 0xfee00000
Feb 26 10:33:24 Master kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00]
enabled) Feb 26 10:33:24 Master kernel: Processor #0 15:2 APIC version 16
Feb 26 10:33:24 Master kernel: ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1]
trigger[0x1] lint[0x1])
Feb 26 10:33:24 Master kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000]
global_irq_base[0x0])
Feb 26 10:33:24 Master kernel: IOAPIC[0]: Assigned apic_id 2
Feb 26 10:33:24 Master kernel: IOAPIC[0]: apic_id 2, version 0, address
0xfec00000, IRQ 0-23
Feb 26 10:33:24 Master kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0]
global_irq[0x2] polarity[0x0] trigger[0x1])
Feb 26 10:33:24 Master kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9]
global_irq[0x14] polarity[0x3] trigger[0x3])
Feb 26 10:33:24 Master kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 26 10:33:24 Master kernel: Using ACPI (MADT) for SMP configuration
information Feb 26 10:33:24 Master kernel: Building zonelist for node : 0
Feb 26 10:33:24 Master kernel: Kernel command line: BOOT_IMAGE=2562 ro
root=305 hdc=ide-scsi
Feb 26 10:33:24 Master kernel: ide_setup: hdc=ide-scsi
Feb 26 10:33:24 Master kernel: Initializing CPU#0
Feb 26 10:33:24 Master kernel: PID hash table entries: 4096 (order 12:
32768 bytes) Feb 26 10:33:24 Master kernel: Detected 1991.228 MHz processor.
Feb 26 10:33:24 Master kernel: Console: colour dummy device 80x25
Feb 26 10:33:24 Master kernel: Calibrating delay loop... 3932.16 BogoMIPS
Feb 26 10:33:24 Master kernel: Memory: 1033156k/1048560k available (2543k
kernel code, 14472k reserved, 1082k data, 140k init, 131056k highmem)
Feb 26 10:33:24 Master kernel: Dentry cache hash table entries: 131072
(order: 8, 1048576 bytes)
Feb 26 10:33:24 Master kernel: Inode-cache hash table entries: 65536
(order: 7, 524288 bytes)
Feb 26 10:33:24 Master kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Feb 26 10:33:24 Master kernel: -> /dev
Feb 26 10:33:24 Master kernel: -> /dev/console
Feb 26 10:33:24 Master kernel: -> /root
Feb 26 10:33:24 Master kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb 26 10:33:24 Master kernel: CPU: L2 cache: 512K
Feb 26 10:33:24 Master kernel: Intel machine check architecture supported.
Feb 26 10:33:24 Master kernel: Intel machine check reporting enabled on
CPU#0. Feb 26 10:33:24 Master kernel: CPU#0: Intel P4/Xeon Extended MCE
MSRs (12) available Feb 26 10:33:24 Master kernel: CPU#0: Thermal
monitoring enabled
Feb 26 10:33:24 Master kernel: Machine check exception polling timer
started. Feb 26 10:33:24 Master kernel: CPU: Intel(R) Pentium(R) 4 CPU
2.00GHz stepping 04 Feb 26 10:33:24 Master kernel: Enabling fast FPU save
and restore... done. Feb 26 10:33:24 Master kernel: Enabling unmasked SIMD
FPU exception support... done. Feb 26 10:33:24 Master kernel: Checking
'hlt' instruction... OK.
Feb 26 10:33:24 Master kernel: POSIX conformance testing by UNIFIX
Feb 26 10:33:24 Master kernel: enabled ExtINT on CPU#0
Feb 26 10:33:24 Master kernel: ESR value before enabling vector: 00000000
Feb 26 10:33:24 Master kernel: ESR value after enabling vector: 00000000
Feb 26 10:33:24 Master kernel: ENABLING IO-APIC IRQs
Feb 26 10:33:24 Master kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 26 10:33:24 Master kernel: testing the IO APIC.......................
Feb 26 10:33:24 Master kernel: 
Feb 26 10:33:24 Master kernel: INFO: unexpected IO-APIC, please file a
report at Feb 26 10:33:24 Master kernel:       http://bugzilla.kernel.org
Feb 26 10:33:24 Master kernel:       if your kernel is less than 3 months
old. Feb 26 10:33:24 Master kernel: ....................................
done. Feb 26 10:33:24 Master kernel: Using local APIC timer interrupts. Feb
26 10:33:24 Master kernel: calibrating APIC timer ...
Feb 26 10:33:24 Master kernel: ..... CPU clock speed is 1991.0440 MHz.
Feb 26 10:33:24 Master kernel: ..... host bus clock speed is 99.0572 MHz.

Steps to reproduce: config kernel with local APIC and IO-APIC for UP,
boot to it.


