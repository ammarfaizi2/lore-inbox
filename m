Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWBGUxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWBGUxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBGUxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:53:11 -0500
Received: from mail.ccur.com ([66.10.65.12]:63621 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S932287AbWBGUxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:53:09 -0500
Message-ID: <43E908B1.7020402@ccur.com>
Date: Tue, 07 Feb 2006 15:53:05 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, bugsy@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2006 20:53:06.0410 (UTC) FILETIME=[7EC9B4A0:01C62C28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > John,
 >
 > Can you please double check if the problem is still there in the latest
 > 2.6.16-rc2-git* kernel? I fixed a couple of SRAT issues in there and at
 > least one change could have fixed your problem too.
 >
 > Thanks,
 > -Andi

Hi Andi,

Sorry, but the 2.6.16-rc2-git3 version didn't seem to work any better 
for me.
I have the output with numa=noacpi, and another output without the 
'numa=noacpi'.

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
grub> boot 

Bootdata ok (command line is root=/dev/sda2 console=ttyS0,115200 
earlyprintk=serial,ttyS0,115200 numa=noacpi)
Linux version 2.6.16-rc2-git3 (johnb@mario) (gcc version 3.2.3 20030502 
(Red Hat Linux 3.2.3-49)) #1 SMP PREEMPT Tue Feb 7
14:27:13 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
  BIOS-e820: 00000000bff70000 - 00000000bff7f000 (ACPI data)
  BIOS-e820: 00000000bff7f000 - 00000000bff80000 (ACPI NVS)
  BIOS-e820: 00000000bff80000 - 00000000d0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
kernel direct mapping tables up to 180000000 @ 8000-8000
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 0000000040000000
Node 1 MemBase 0000000040000000 Limit 0000000080000000
Skipping disabled node 2
Node 3 MemBase 0000000080000000 Limit 0000000180000000
Using node hash shift of 30
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-0000000080000000
Bootmem setup node 3 0000000080000000-0000000180000000
ACPI: PM-Timer IO Port: 0xc008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xee200000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xee200000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xee201000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xee201000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xee203000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xee203000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xee205000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xee205000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d4000000 (gap: d0000000:2ec00000)
Checking aperture...
CPU 0: aperture @ c0000000 size 256 MB
CPU 1: aperture @ c0000000 size 256 MB
CPU 2: aperture @ c0000000 size 256 MB
CPU 3: aperture @ c0000000 size 256 MB
PANIC: early exception rip ffffffff80837ea3 error 0 cr2 8b8

Call Trace: <ffffffff80837ea3>{build_zonelists_node+33}
        <ffffffff80838133>{build_zonelists+276} 
<ffffffff808381a3>{build_all_zonelists+58}
        <ffffffff808227d2>{start_kernel+78} 
<ffffffff808222d2>{x86_64_start_kernel+467}

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

grub> boot 

Bootdata ok (command line is root=/dev/sda2 console=ttyS0,115200 
earlyprintk=serial,ttyS0,115200)
Linux version 2.6.16-rc2-git3 (johnb@mario) (gcc version 3.2.3 20030502 
(Red Hat Linux 3.2.3-49)) #1 SMP PREEMPT Tue Feb 7 14:27:13 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
  BIOS-e820: 00000000bff70000 - 00000000bff7f000 (ACPI data)
  BIOS-e820: 00000000bff7f000 - 00000000bff80000 (ACPI NVS)
  BIOS-e820: 00000000bff80000 - 00000000d0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
kernel direct mapping tables up to 180000000 @ 8000-8000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-40000000
SRAT: Node 1 PXM 1 40000000-80000000
SRAT: Node 3 PXM 3 80000000-c0000000
SRAT: Node 3 PXM 3 80000000-180000000
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-0000000080000000
Bootmem setup node 3 0000000080000000-0000000180000000
PANIC: early exception rip ffffffff8011cb08 error 0 cr2 3440
PANIC: early exception rip ffffffff80115d92 error 0 cr2 ffffffffff5fd023
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

