Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135612AbRD2BBZ>; Sat, 28 Apr 2001 21:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRD2BBG>; Sat, 28 Apr 2001 21:01:06 -0400
Received: from gateway.folmsbee.com ([204.250.21.200]:21777 "EHLO
	gateway.folmsbee.com") by vger.kernel.org with ESMTP
	id <S135612AbRD2BBA>; Sat, 28 Apr 2001 21:01:00 -0400
Message-ID: <000a01c0d047$eb250060$030a0a0a@aaron.home>
From: "Aaron M. Folmsbee" <aaron@folmsbee.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x SMP Kernel Exception (Bug?)
Date: Sat, 28 Apr 2001 14:32:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the 2.4.x kernels are failing on my dual Intel PII system with a kernel
panic. I have tried everything I could (disable swap, setting memory size,
build kernel with minimal options, etc..) and have been unable to boot the
kernel so I suspect there may be a bug. The 2.4.x kernels build without SMP
support boot without any problems at all.

The kernel message from the 2.4.4 version follows:

invalid operand: 0000
CPU: 0
EIP: 0010:[<c010c630>]
EFLAGS: 00010206
eax: 0183fbff ebx: cba52000 ecx: c02d0000 edx: cba52000
esi: c02d0000 edi: c02d0350 edp: 00000000 esp: c02d1f74
ds: 0018 es:0018  ss:0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack:  c010581d cba52000 c0305800 cba52350 cba52000 cbd87a40 00000000
cba53e1c
  c0110e66 c02d1fd4 00000001 cdb87a40 c01051b0 cba52000 c02d0000 00000001
  c02d0000 00000030 00000000 c02d0000 c0309440 c01051b0 c02d0000 c02d0000
Call Trace:[<c010581d>] [<c0110e66>] [<c01051b0>] [<c01051b0>]
           [<c01051b0>] [<c010526e>] [<c0105000>] [<c01001cf>]
Code: 0f ae 82 90 03 00 00 db e2 eb 0c 90 8d 74 26 00 dd b2 90 03
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


Some info from the successfull uni-processor kernel startup:

Apr 27 18:50:09 GANDALF kernel: Linux version 2.4.3aaronUP (root@GANDALF)
(gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-81)) #1 Mon Apr 23 18:37:57 PDT 2001
Apr 27 18:50:09 GANDALF kernel: BIOS-provided physical RAM map:
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 0000000000100000 -
000000000bff0000 (usable)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 000000000bff0000 -
000000000bff8000 (ACPI data)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 000000000bff8000 -
000000000c000000 (ACPI NVS)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Apr 27 18:50:09 GANDALF kernel:  BIOS-e820: 00000000fffe0000 -
0000000100000000 (reserved)
Apr 27 18:50:09 GANDALF kernel: Scan SMP from c0000000 for 1024 bytes.
Apr 27 18:50:09 GANDALF kernel: Scan SMP from c009fc00 for 1024 bytes.
Apr 27 18:50:09 GANDALF kernel: Scan SMP from c00f0000 for 65536 bytes.
Apr 27 18:50:09 GANDALF kernel: found SMP MP-table at 000fb650
Apr 27 18:50:09 GANDALF kernel: hm, page 000fb000 reserved twice.
Apr 27 18:50:09 GANDALF kernel: hm, page 000fc000 reserved twice.
Apr 27 18:50:09 GANDALF kernel: hm, page 000f6000 reserved twice.
Apr 27 18:50:09 GANDALF kernel: hm, page 000f7000 reserved twice.
Apr 27 18:50:09 GANDALF kernel: On node 0 totalpages: 49136
Apr 27 18:50:09 GANDALF kernel: zone(0): 4096 pages.
Apr 27 18:50:09 GANDALF kernel: zone(1): 45040 pages.
Apr 27 18:50:09 GANDALF kernel: zone(2): 0 pages.
Apr 27 18:50:09 GANDALF kernel: Intel MultiProcessor Specification v1.4
Apr 27 18:50:09 GANDALF kernel:     Virtual Wire compatibility mode.
Apr 27 18:50:09 GANDALF kernel: OEM ID: INTEL    Product ID: 440LX
APIC at: 0xFEE00000
Apr 27 18:50:09 GANDALF kernel: Processor #0 Pentium(tm) Pro APIC version 17
Apr 27 18:50:09 GANDALF kernel:     Floating point unit present.
Apr 27 18:50:09 GANDALF kernel:     Machine Exception supported.
Apr 27 18:50:09 GANDALF kernel:     64 bit compare & exchange supported.
Apr 27 18:50:09 GANDALF kernel:     Internal APIC present.
Apr 27 18:50:09 GANDALF kernel:     SEP present.
Apr 27 18:50:09 GANDALF kernel:     MTRR  present.
Apr 27 18:50:09 GANDALF kernel:     PGE  present.
Apr 27 18:50:09 GANDALF kernel:     MCA  present.
Apr 27 18:50:09 GANDALF kernel:     CMOV  present.
Apr 27 18:50:09 GANDALF kernel:     MMX  present.
Apr 27 18:50:09 GANDALF kernel:     Bootup CPU
Apr 27 18:50:09 GANDALF kernel: Processor #1 Pentium(tm) Pro APIC version 17
Apr 27 18:50:09 GANDALF kernel:     Floating point unit present.
Apr 27 18:50:09 GANDALF kernel:     Machine Exception supported.
Apr 27 18:50:09 GANDALF kernel:     64 bit compare & exchange supported.
Apr 27 18:50:09 GANDALF kernel:     Internal APIC present.
Apr 27 18:50:09 GANDALF kernel:     SEP present.
Apr 27 18:50:09 GANDALF kernel:     MTRR  present.
Apr 27 18:50:09 GANDALF kernel:     PGE  present.
Apr 27 18:50:09 GANDALF kernel:     MCA  present.
Apr 27 18:50:09 GANDALF kernel:     CMOV  present.
Apr 27 18:50:09 GANDALF kernel:     PAT  present.
Apr 27 18:50:09 GANDALF kernel:     PSE  present.
Apr 27 18:50:09 GANDALF kernel:     MMX  present.
Apr 27 18:50:09 GANDALF kernel:     FXSR  present.
Apr 27 18:50:09 GANDALF kernel: Bus #0 is PCI
Apr 27 18:50:09 GANDALF kernel: Bus #1 is PCI
Apr 27 18:50:09 GANDALF kernel: Bus #2 is ISA
Apr 27 18:50:09 GANDALF kernel: I/O APIC #2 Version 17 at 0xFEC00000.
...
Apr 27 18:50:09 GANDALF kernel: Processors: 2
Apr 27 18:50:09 GANDALF kernel: mapped APIC to ffffe000 (fee00000)
Apr 27 18:50:09 GANDALF kernel: mapped IOAPIC to ffffd000 (fec00000)
Apr 27 18:50:09 GANDALF kernel: Kernel command line: auto
BOOT_IMAGE=linux-aaron ro root=303
 BOOT_FILE=/boot/vmlinuz-2.4.3aaronUP
Apr 27 18:50:09 GANDALF kernel: Initializing CPU#0
Apr 27 18:50:09 GANDALF kernel: Detected 298.732 MHz processor.
Apr 27 18:50:09 GANDALF kernel: Console: colour VGA+ 80x25
Apr 27 18:50:09 GANDALF kernel: Calibrating delay loop... 596.37 BogoMIPS
Apr 27 18:50:09 GANDALF kernel: Memory: 190728k/196544k available (1230k
kernel code, 5428k
reserved, 501k data, 196k init, 0k highmem)
Apr 27 18:50:09 GANDALF kernel: Dentry-cache hash table entries: 32768
(order: 6, 262144 bytes)
Apr 27 18:50:09 GANDALF kernel: Buffer-cache hash table entries: 8192
(order: 3, 32768 bytes)
Apr 27 18:50:09 GANDALF kernel: Page-cache hash table entries: 65536 (order:
6, 262144 bytes)
Apr 27 18:50:09 GANDALF kernel: Inode-cache hash table entries: 16384
(order: 5, 131072 bytes)
Apr 27 18:50:09 GANDALF kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Apr 27 18:50:09 GANDALF kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Apr 27 18:50:09 GANDALF kernel: CPU: L2 cache: 512K
Apr 27 18:50:09 GANDALF kernel: Intel machine check architecture supported.
Apr 27 18:50:09 GANDALF kernel: Intel machine check reporting enabled on
CPU#0.
Apr 27 18:50:09 GANDALF kernel: CPU: Intel Pentium II (Klamath) stepping 04
Apr 27 18:50:09 GANDALF kernel: Checking 'hlt' instruction... OK.
Apr 27 18:50:09 GANDALF kernel: POSIX conformance testing by UNIFIX
Apr 27 18:50:09 GANDALF kernel: enabled ExtINT on CPU#0
Apr 27 18:50:09 GANDALF kernel: ESR value before enabling vector: 00000004
Apr 27 18:50:09 GANDALF kernel: ESR value after enabling vector: 00000000
Apr 27 18:50:09 GANDALF kernel: ENABLING IO-APIC IRQs
Apr 27 18:50:09 GANDALF kernel: ...changing IO-APIC physical APIC ID to 2
... ok.
Apr 27 18:50:09 GANDALF kernel: Synchronizing Arb IDs.
Apr 27 18:50:09 GANDALF kernel: ..TIMER: vector=49 pin1=2 pin2=0
Apr 27 18:50:09 GANDALF kernel: testing the IO APIC.......................
Apr 27 18:50:09 GANDALF kernel:
Apr 27 18:50:09 GANDALF kernel: .................................... done.
Apr 27 18:50:09 GANDALF kernel: calibrating APIC timer ...
Apr 27 18:50:09 GANDALF kernel: ..... CPU clock speed is 298.7387 MHz.
Apr 27 18:50:09 GANDALF kernel: ..... host bus clock speed is 66.3860 MHz.
Apr 27 18:50:09 GANDALF kernel: cpu: 0, clocks: 663860, slice: 331930
Apr 27 18:50:09 GANDALF kernel:
CPU0<T0:663856,T1:331920,D:6,S:331930,C:663860>

