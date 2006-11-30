Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758999AbWK3EJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999AbWK3EJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758994AbWK3EJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:09:58 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:38200 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758532AbWK3EJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:09:57 -0500
Date: Wed, 29 Nov 2006 20:10:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
Message-Id: <20061129201006.b7ae509f.randy.dunlap@oracle.com>
In-Reply-To: <200611292242.20358.edt@aei.ca>
References: <20061128020246.47e481eb.akpm@osdl.org>
	<200611292242.20358.edt@aei.ca>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 22:42:20 -0500 Ed Tomlinson wrote:

> On Tuesday 28 November 2006 05:02, Andrew Morton wrote:
> 
> > Will appear eventually at
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> 
> This kernel does not boot here.  It does not get far enough to post anything to my serial console.

Have you tried using "earlyprintk=..." to see if it produces any
more output?

> The last booted kernel here is 19-rc5-mm2.   Grub is used to boot, here is the starting log
> of rc5-mm2 build is UP AMD64:
> 
> [    0.000000] Linux version 2.6.19-rc5-mm2 (root@grover) (gcc version 4.1.1 (Gentoo 4.1.1-r1)) #1 PREEM6
> [    0.000000] Command line: root=/dev/sda3 vga=0x318 video=vesafb:ywrap,mtrr:3 console=tty0 console=tty1
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
> [    0.000000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
> [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
> [    0.000000]  BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
> [    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> [    0.000000] end_pfn_map = 1048576
> [    0.000000] DMI 2.2 present.
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->     4096
> [    0.000000]   DMA32        4096 ->  1048576
> [    0.000000]   Normal    1048576 ->  1048576
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0:        0 ->      159
> [    0.000000]     0:      256 ->   262128
> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
> [    0.000000] ACPI: PM-Timer IO Port: 0x4008
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> [    0.000000] Processor #0 (Bootup-CPU)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
> [    0.000000] Setting APIC routing to flat
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
> [    0.000000] Nosave address range: 00000000000a0000 - 00000000000f0000
> [    0.000000] Nosave address range: 00000000000f0000 - 0000000000100000
> [    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
> [    0.000000] Built 1 zonelists.  Total pages: 257320
> [    0.000000] Kernel command line: root=/dev/sda3 vga=0x318 video=vesafb:ywrap,mtrr:3 console=tty0 cons1
> [    0.000000] Initializing CPU#0
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> 
> Any ideas what I should try or suggestions on patches to remove/try.
> 
> Thanks
> Ed

---
~Randy
