Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSLPOBc>; Mon, 16 Dec 2002 09:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLPOBc>; Mon, 16 Dec 2002 09:01:32 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61074 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265656AbSLPOBb>;
	Mon, 16 Dec 2002 09:01:31 -0500
Date: Mon, 16 Dec 2002 14:08:10 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo and hyperthreading
Message-ID: <20021216140809.GE11616@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Scott Robert Ladd <scott@coyotegulch.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021216023453.GA19659@gagarin> <FKEAJLBKJCGBDJJIPJLJCEJPDLAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJCEJPDLAA.scott@coyotegulch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 10:58:12PM -0500, Scott Robert Ladd wrote:
 > During boot, the system reports:
 > Dec 15 14:30:34 Tycho kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
 > enabled)
 > Dec 15 14:30:34 Tycho kernel: Processor #0 15:2 APIC version 16
 > Dec 15 14:30:34 Tycho kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]
 > enabled)
 > Dec 15 14:30:34 Tycho kernel: Processor #1 15:2 APIC version 16
 > Dec 15 14:30:34 Tycho kernel: Building zonelist for node : 0

Looks like you're either missing some ACPI config options, or
you haven't updated the BIOS yet. On 2.5.51 with latest BIOS on
the same box, I get..

Dec 12 16:28:55 tetrachloride kernel: Processor #1 15:2 APIC version 16
Dec 12 16:28:55 tetrachloride kernel: ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
Dec 12 16:28:55 tetrachloride kernel: ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
Dec 12 16:28:55 tetrachloride kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Dec 12 16:28:55 tetrachloride kernel: IOAPIC[0]: Assigned apic_id 2
Dec 12 16:28:55 tetrachloride kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
Dec 12 16:28:55 tetrachloride kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Dec 12 16:28:55 tetrachloride kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Dec 12 16:28:55 tetrachloride kernel: Using ACPI (MADT) for SMP configuration information
Dec 12 16:28:55 tetrachloride kernel: Building zonelist for node: 0

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
