Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbUKPQPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUKPQPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKPQNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:13:48 -0500
Received: from lax-gate6.raytheon.com ([199.46.200.237]:854 "EHLO
	lax-gate6.raytheon.com") by vger.kernel.org with ESMTP
	id S262024AbUKPQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:11:32 -0500
To: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Date: Tue, 16 Nov 2004 10:09:38 -0600
Message-ID: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/16/2004 10:09:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt <mista.tapas@gmx.net> wrote:

>ok, this new build still hangs at the same spot.

Me too. The serial console output follows at the end. Will try a
few boot alternatives and let you know if I can get this to run.
>From what I can tell, it was attempting to test the NMI watchdog
when it failed.

  --Mark

-----

Linux version 2.6.10-rc2-mm1-RT-V0.7.27-4 (root@dws77) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Tue Nov 16 09:18:20 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000fb170
DMI 2.3 present.
Using APIC driver default
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=LABEL=/ nmi_watchdog=1 single
console=ttyS0,9600n8r profile=2
kernel CPU profiling enabled
kernel profiling shift: 2
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 864.206 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511224k/524224k available (2231k kernel code, 12612k reserved, 658k
data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.77 usecs.
task migration cache decay timeout: 1 msecs.
Booting processor 1/1 eip 2000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3411.96 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
t<

[from a good boot of -V0.7.26-4...]
testing NMI watchdog ... OK.
checking TSC synchronization across 2 CPUs: passed.
IRQ#0 thread RT prio: 49.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
desched cpu_callback 3/00000001
desched cpu_callback 2/00000001
ksoftirqd started up.
softirq RT prio: 24.
Brought up 2 CPUs
... and so on ...

