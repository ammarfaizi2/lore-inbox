Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281442AbRKMCxw>; Mon, 12 Nov 2001 21:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKMCxm>; Mon, 12 Nov 2001 21:53:42 -0500
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:26752 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S281445AbRKMCxc>; Mon, 12 Nov 2001 21:53:32 -0500
Message-ID: <3BF08B26.D31563C4@home.com>
Date: Mon, 12 Nov 2001 20:53:26 -0600
From: Jordan Breeding <ledzep37@home.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre4-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Weird boot messages using acpismp=force with 2.4.15-pre4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Around a week ago I decided to test the acpismp=force boot time option
of the current -ac kernels, it worked great and I got the following
messages upon boot:

Nov  5 17:48:52 ledzep kernel: ACPI: Searched entire block, no RSDP was
found.
Nov  5 17:48:52 ledzep kernel: ACPI: RSDP located at physical address
c00f6f60
Nov  5 17:48:52 ledzep kernel: RSD PTR  v0 [VIA694]
Nov  5 17:48:52 ledzep kernel: ACPI table found: RSDT v1 [VIA694
AWRDACPI 16944.11825]
Nov  5 17:48:52 ledzep kernel: ACPI table found: FACP v1 [VIA694
AWRDACPI 16944.11825]
Nov  5 17:48:52 ledzep kernel: ACPI table found: APIC v1 [VIA694
AWRDACPI 16944.11825]
Nov  5 17:48:52 ledzep kernel: LAPIC (acpi_id[0x0000] id[0x0]
enabled[1])
Nov  5 17:48:52 ledzep kernel: CPU 0 (0x0000) enabledProcessor #0
Pentium(tm) Pro APIC version 16
Nov  5 17:48:52 ledzep kernel:
Nov  5 17:48:52 ledzep kernel: LAPIC (acpi_id[0x0001] id[0x1]
enabled[1])
Nov  5 17:48:52 ledzep kernel: CPU 1 (0x0100) enabledProcessor #1
Pentium(tm) Pro APIC version 16
Nov  5 17:48:52 ledzep kernel:
Nov  5 17:48:52 ledzep kernel: IOAPIC (id[0x2] address[0xfec00000]
global_irq_base[0x0])
Nov  5 17:48:52 ledzep kernel: INT_SRC_OVR (bus[0] irq[0x0]
global_irq[0x2] polarity[0x0] trigger[0x0])
Nov  5 17:48:52 ledzep kernel: INT_SRC_OVR (bus[0] irq[0x9]
global_irq[0x9] polarity[0x0] trigger[0x0])
Nov  5 17:48:52 ledzep kernel: 2 CPUs total
Nov  5 17:48:52 ledzep kernel: Local APIC address fee00000
Nov  5 17:48:52 ledzep kernel: Enabling the CPU's according to the ACPI
table

Then while setting up a 2.4.15-pre4 kernel I noticed that it also had
this option now and decided to try it with that kernel as well, however
it has some mm/init.c error messages on boot, are these harmeless or if
not can they be fixed, here are the messages:

Nov 12 20:15:14 ledzep kernel: ACPI: Searched entire block, no RSDP was
found.
Nov 12 20:15:14 ledzep kernel: ACPI: RSDP located at physical address
c00f6f60
Nov 12 20:15:14 ledzep kernel: RSD PTR  v0 [VIA694]
Nov 12 20:15:14 ledzep kernel: ACPI table found: RSDT v1 [VIA694
AWRDACPI 16944.11825]
Nov 12 20:15:14 ledzep kernel: init.c:147: bad pte 3fff3163.
Nov 12 20:15:14 ledzep kernel: ACPI table found: FACP v1 [VIA694
AWRDACPI 16944.11825]
Nov 12 20:15:14 ledzep kernel: init.c:147: bad pte 3fff3163.
Nov 12 20:15:14 ledzep kernel: ACPI table found: APIC v1 [VIA694
AWRDACPI 16944.11825]
Nov 12 20:15:14 ledzep kernel: init.c:147: bad pte 3fff5163.
Nov 12 20:15:14 ledzep kernel: LAPIC (acpi_id[0x0000] id[0x0]
enabled[1])
Nov 12 20:15:14 ledzep kernel: CPU 0 (0x0000) enabled Processor #0
Pentium(tm) Pro APIC version 16
Nov 12 20:15:14 ledzep kernel:
Nov 12 20:15:14 ledzep kernel: LAPIC (acpi_id[0x0001] id[0x1]
enabled[1])
Nov 12 20:15:14 ledzep kernel: CPU 1 (0x0100) enabled Processor #1
Pentium(tm) Pro APIC version 16
Nov 12 20:15:14 ledzep kernel:
Nov 12 20:15:14 ledzep kernel: IOAPIC (id[0x2] address[0xfec00000]
global_irq_base[0x0])
Nov 12 20:15:14 ledzep kernel: INT_SRC_OVR (bus[0] irq[0x0]
global_irq[0x2] polarity[0x0] trigger[0x0])
Nov 12 20:15:14 ledzep kernel: INT_SRC_OVR (bus[0] irq[0x7]
global_irq[0x7] polarity[0x0] trigger[0x0])
Nov 12 20:15:14 ledzep kernel: 2 CPUs total
Nov 12 20:15:14 ledzep kernel: Local APIC address fee00000
Nov 12 20:15:14 ledzep kernel: Enabling the CPU's according to the ACPI
table

Thank you for any help in figuring out what these messages mean.  BTW,
these messages only appear when booting 2.4.15-pre4 using acpismp=force
not when booting the same kernel without the option specified.

Jordan
