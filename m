Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVFHVVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVFHVVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFHVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:21:42 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:43086 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261732AbVFHVVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:21:25 -0400
Message-ID: <42A75525.3050704@tls.msk.ru>
Date: Thu, 09 Jun 2005 00:29:25 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>	 <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr>	 <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com>	 <42A4D1AB.3090508@tls.msk.ru> <1118224334.3245.89.camel@localhost.localdomain>
In-Reply-To: <1118224334.3245.89.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
[]
>>>>[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
>>>> as Content-Type: text/plain, for some reason.  I grabbed iasl
>>>> and converted that stuff into .dsls, available at:
>>>> http://www.corpit.ru/mjt/hpml310.dsl and
>>>> http://www.corpit.ru/mjt/hpml150.dsl ]
[]
> Hi,
> 
> I'm sorry for the delayed response, as this bug is very difficult to
> track down.  The information you provided was helpful and I appreciate
> it.  I have a theory as to what is going on, and the patch below might
> solve your problem.  If not, it will at least give us some more
> information.

Well, not much of info, really.. ;)

> The following would be useful:
> 
> 1.) a complete dmesg after initial boot with the patch
> 2.) kernel message output after "rmmod parport_pc" and "modprobe
> parport_pc" with the patch

Here it is.  From HP ML 150 box.  I compiled 2.6.11-rc6 with
the patch you've sent.

Linux version 2.6.12-i786smp-rc6-0 (mjt@paltus.tls.msk.ru) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 SMP Wed Jun 8 18:01:05 MSD 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294896 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4fa0
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000311 MSFT 0x00000097) @ 0x7fff0000
ACPI: FADT (v002 A M I  OEMFACP  0x08000311 MSFT 0x00000097) @ 0x7fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x08000311 MSFT 0x00000097) @ 0x7fff0300
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000311 MSFT 0x00000097) @ 0x7ffff040
ACPI: DSDT (v001  0ABBP 0ABBP001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.12-rc6-0 ro root=100 panic=60 elevator=
deadline
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80400)
Initializing CPU#0
....
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: skipping dma from _CRS
pnp: broken dma code, fix me
pnp: broken dma code, fix me
pnp: broken dma code, fix me
pnp: broken dma code, fix me
pnp: skipping dma from _CRS
pnp: broken dma code, fix me
pnp: broken dma code, fix me
pnp: broken dma code, fix me
pnp: broken irq code, fix me
pnp: broken dma code, fix me
pnp: broken irq code, fix me
pnp: broken dma code, fix me
pnp: broken irq code, fix me
pnp: broken dma code, fix me
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
...
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x295-0x296 has been reserved
pnp: 00:0c: ioport range 0x3e0-0x3e7 has been reserved
....
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
....

[modprobe parport_pc]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
[rmmod parport_pc]
pnp: Device 00:07 disabled.
[modprobe parport_pc]
pnp: attempting to fix irq flags
bug squashed - dma

[at this point, modprobe is stuck, with `_stext' (it seems)
 in /proc/$modprobe_pid/wchan, eating 100% of one CPU, with
 another fair load from migration/0 and events/0 threads.
 strace on it gets stuck too.]

I can try 2.6.11 too.  I'm a bit afraid to try this on
HP ML 310 box for now - this HPML150 seems to have rebooted
nicely without any bad things, but if that HPML310 (production)
machine will not come back automatically, it'll be a bit of
a problem.. ;)

/mjt

> I designed this patch to fix both "hpml150.dsl" and "hpml310.dsl".  If
> you have time, could you test it on both platforms?  This is a hack, so
> if it works, I'll give a more complete explanation and an official fix.
> 
> Thanks,
> Adam
> 
> --- a/drivers/pnp/pnpacpi/rsparser.c	2005-05-27 22:06:02.000000000 -0400
> +++ b/drivers/pnp/pnpacpi/rsparser.c	2005-06-08 05:36:57.410599288 -0400
[]
