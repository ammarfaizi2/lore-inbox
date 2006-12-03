Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753946AbWLCPvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbWLCPvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbWLCPvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:51:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5330 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753942AbWLCPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:51:11 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <gregkh@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de>
Date: Sun, 03 Dec 2006 08:49:47 -0700
In-Reply-To: <20061201191916.GB3539@suse.de> (Greg KH's message of "Fri, 1 Dec
	2006 11:19:16 -0800")
Message-ID: <m13b7xf084.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> On Fri, Dec 01, 2006 at 10:55:48AM -0800, Lu, Yinghai wrote:
>> -----Original Message-----
>> From: Greg KH [mailto:gregkh@suse.de] 
>> 
>> >I can do that in about 15 minutes if you give me the device ids for the
>> >usb debug device that you wish to have.
>> 
>> >Or you can also use the generic usb-serial driver today just fine with
>> >no modification.  Have you had a problem with using that option?
>> 
>> We are talking about using USB debug device/EHCI debug port in LinuxBIOS
>> in legacy free PC.
>> Because one AM2+MCP55 MB doesn't have serial port.
>> 
>> I guess Eric is working on USB debug device/EHCI debug port for
>> earlyprintk or printk.
>
> Well, earlyprintk will not work, as you need PCI up and running.

*grin*  I just generated the bootlog below.  So I think I have
it working.  There is a lot of cleanup left and I need some sleep but
it works for me.  I will generate a patch to start the conversation
after I wake up.

> And I have some code that barely works for this already, perhaps Eric
> and I should work together on this :)

Eric


Linux version 2.6.19-rc6devel (eric@fess.biederman.org) (gcc version 4.1.1 2006
0525 (Red Hat 4.1.1-1)) #153 SMP Sun Dec 3 07:56:52 MST 2006
Command line: ro root=LABEL=/ rhgb earlyprintk=dbgp console=tty0 console=ttyS0,1
15200 panic=30
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000009ffd0000 (usable)
 BIOS-e820: 000000009ffd0000 - 000000009ffde000 (ACPI data)
 BIOS-e820: 000000009ffde000 - 00000000a0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000024c000000 (usable)
end_pfn_map = 2408448
kernel direct mapping tables up to 24c000000 @ 8000-13000
DMI 2.3 present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 100000-a0000000
SRAT: Node 1 PXM 1 14c000000-24c000000
SRAT: Node 0 PXM 0 100000-14c000000
SRAT: Node 0 PXM 0 0-14c000000
Bootmem setup node 0 0000000000000000-000000014c000000
Bootmem setup node 1 000000014c000000-000000024c000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2408448
early_node_map[4] active PFN ranges
    0:        0 ->      159
    0:      256 ->   655312
    0:  1048576 ->  1359872
    1:  1359872 ->  2408448
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xdfefc000] gsi_base[24])
IOAPIC[1]: apic_id 5, address 0xdfefc000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e6000
Nosave address range: 00000000000e6000 - 0000000000100000
Nosave address range: 000000009ffd0000 - 000000009ffde000
Nosave address range: 000000009ffde000 - 00000000a0000000
Nosave address range: 00000000a0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 00000000fec01000
Nosave address range: 00000000fec01000 - 00000000fee00000
Nosave address range: 00000000fee00000 - 00000000fee01000
Nosave address range: 00000000fee01000 - 00000000ff780000
Nosave address range: 00000000ff780000 - 0000000100000000
Allocating PCI resources starting at a8000000 (gap: a0000000:5ec00000)
PERCPU: Allocating 66560 bytes of per cpu data
Built 2 zonelists.  Total pages: 1960348
Kernel command line: ro root=LABEL=/ rhgb earlyprintk=dbgp console=tty0 console=
ttyS0,115200 panic=30
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
disabling early console
