Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSLPDsp>; Sun, 15 Dec 2002 22:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSLPDsp>; Sun, 15 Dec 2002 22:48:45 -0500
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:9920 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S264931AbSLPDsn>; Sun, 15 Dec 2002 22:48:43 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: /proc/cpuinfo and hyperthreading
Date: Sun, 15 Dec 2002 22:58:12 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJCEJPDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20021216023453.GA19659@gagarin>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

When I cat /proc/cpuinfo on my Pentium 4 system, it says:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Pentium 4 (Northwood)
stepping	: 7
cpu MHz	: 2783.753
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 5488.64

Am I correct to infer that the "siblings" entry refers to the 2-way
hyperthreading on my CPU?

During boot, the system reports:

Dec 15 14:30:34 Tycho kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
enabled)
Dec 15 14:30:34 Tycho kernel: Processor #0 15:2 APIC version 16
Dec 15 14:30:34 Tycho kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]
enabled)
Dec 15 14:30:34 Tycho kernel: Processor #1 15:2 APIC version 16
Dec 15 14:30:34 Tycho kernel: Building zonelist for node : 0
Dec 15 14:30:34 Tycho kernel: Kernel command line: BOOT_IMAGE=smp ro
root=306
Dec 15 14:30:34 Tycho kernel: Found and enabled local APIC!
Dec 15 14:30:34 Tycho kernel: Initializing CPU#0
Dec 15 14:30:34 Tycho kernel: Detected 2783.753 MHz processor.
Dec 15 14:30:34 Tycho kernel: Console: colour VGA+ 80x25
Dec 15 14:30:34 Tycho kernel: Calibrating delay loop... 5488.64 BogoMIPS
Dec 15 14:30:34 Tycho kernel: Memory: 255916k/261888k available (1411k
kernel code, 5216k reserved, 567k data, 276k init, 0k highmem)
Dec 15 14:30:34 Tycho kernel: Dentry cache hash table entries: 32768 (order:
6, 262144 bytes)
Dec 15 14:30:34 Tycho kernel: Inode-cache hash table entries: 16384 (order:
5, 131072 bytes)
Dec 15 14:30:34 Tycho kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Dec 15 14:30:34 Tycho kernel: -> /dev
Dec 15 14:30:34 Tycho kernel: -> /dev/console
Dec 15 14:30:34 Tycho kernel: -> /root
Dec 15 14:30:34 Tycho kernel: CPU: Before vendor init, caps: bfebfbff
00000000 00000000, vendor = 0
Dec 15 14:30:34 Tycho kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 15 14:30:34 Tycho kernel: CPU: L2 cache: 512K
Dec 15 14:30:34 Tycho kernel: CPU: Physical Processor ID: 0
Dec 15 14:30:34 Tycho kernel: CPU: After vendor init, caps: bfebfbff
00000000 00000000 00000000
Dec 15 14:30:34 Tycho kernel: CPU:     After generic, caps: bfebfbff
00000000 00000000 00000000
Dec 15 14:30:34 Tycho kernel: CPU:             Common caps: bfebfbff
00000000 00000000 00000000
Dec 15 14:30:34 Tycho kernel: Enabling fast FPU save and restore... done.
Dec 15 14:30:34 Tycho kernel: Enabling unmasked SIMD FPU exception
support... done.
Dec 15 14:30:34 Tycho kernel: Checking 'hlt' instruction... OK.
Dec 15 14:30:34 Tycho kernel: POSIX conformance testing by UNIFIX
Dec 15 14:30:34 Tycho kernel: CPU0: Intel Pentium 4 (Northwood) stepping 07
Dec 15 14:30:34 Tycho kernel: per-CPU timeslice cutoff: 1462.97 usecs.
Dec 15 14:30:34 Tycho kernel: task migration cache decay timeout: 2 msecs.
Dec 15 14:30:34 Tycho kernel: SMP motherboard not detected.
Dec 15 14:30:34 Tycho kernel: enabled ExtINT on CPU#0
Dec 15 14:30:34 Tycho kernel: ESR value before enabling vector: 00000000
Dec 15 14:30:34 Tycho kernel: ESR value after enabling vector: 00000000
Dec 15 14:30:34 Tycho kernel: Using local APIC timer interrupts.
Dec 15 14:30:34 Tycho kernel: calibrating APIC timer ...
Dec 15 14:30:34 Tycho kernel: ..... CPU clock speed is 2783.0885 MHz.
Dec 15 14:30:34 Tycho kernel: ..... host bus clock speed is 132.0565 MHz.
Dec 15 14:30:34 Tycho kernel: Starting migration thread for cpu 0
Dec 15 14:30:34 Tycho kernel: CPUS done 2

I just want to be sure that hyperthreading is, in fact, working in 2.5.51.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

