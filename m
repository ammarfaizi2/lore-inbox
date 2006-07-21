Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWGUIDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWGUIDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWGUIDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:03:05 -0400
Received: from ns2.tasking.nl ([195.193.207.10]:46931 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S1161016AbWGUIDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:03:04 -0400
To: linux-kernel@vger.kernel.org
From: Kees Bakker <spam@altium.nl>
Subject: powernow-k8: internal error - pending bit very stuck - no further pstate changes possible
Date: Fri, 21 Jul 2006 10:02:59 +0200
User-Agent: KNode/0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Host: 172.17.1.96
Message-ID: <17e3.44c08a33.9f1b0@altium.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my brandnew system, MSI K8MM3-V with a Celeron 3000+ and OpenSUSE 10.1 (with 2.6.16.13 kernel),
there are a lot of worrying powernow-k8 messages. How would I go about debugging this problem?
Any help is appreciated.

Below there are some lines of interest from /var/log/{boot.msg,messages}. This is a pretty
naked system. It has no keyboard or screen attached. The mobo has on-board VGA. There are
two SATA disks attached, and there is 512Mb memory. That's about it. If someone knowledgeable
would need more info, please let me know. The "failing targ, change pending bit set" messages
seem to be triggered on a moment that the SUSE system tries to switch cpufreq, for example
when Beagle kicks in.

Besides these powernow-k8 messages I am not able to see anything in /proc/acpi/thermal_zone

Some lines extracted from /var/log/boot.msg:
...
DMI 2.3 present.
IO/L-APIC allowed because system is MP or new enough
ACPI: RSDP (v000 VIAK8M                                ) @ 0x000f8c80
ACPI: RSDT (v001 VIAK8M AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1bff3040
ACPI: FADT (v001 VIAK8M AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1bff30c0
ACPI: MADT (v001 VIAK8M AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1bff8080
ACPI: DSDT (v001 VIAK8M AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
...
CPU: AMD Sempron(tm) Processor 3000+ stepping 02
...

And some lines from /var/log/messages
Jul 19 15:28:20 plankie kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
Jul 19 15:28:20 plankie kernel: powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
Jul 19 15:28:20 plankie kernel: powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
Jul 19 15:28:20 plankie kernel: cpu_init done, current fid 0xa, vid 0x4
Jul 19 15:28:20 plankie kernel: powernow-k8: ph2 null fid transition 0xa
...
Jul 20 07:45:12 plankie kernel: powernow-k8: internal error - pending bit very stuck - no further pstate changes possible
Jul 20 07:45:12 plankie kernel: powernow-k8: transition frequency failed
Jul 20 07:45:21 plankie kernel: powernow-k8: failing targ, change pending bit set
...
Jul 20 10:03:17 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:18 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:29 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:31 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:32 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:33 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:34 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:36 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:37 plankie kernel: powernow-k8: failing targ, change pending bit set
Jul 20 10:03:38 plankie kernel: powernow-k8: failing targ, change pending bit set

- Kees


