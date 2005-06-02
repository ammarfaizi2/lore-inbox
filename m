Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFBLbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFBLbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 07:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFBLbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 07:31:25 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:20711 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S261376AbVFBLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 07:31:05 -0400
Message-ID: <429EEDF7.3030100@ribosome.natur.cuni.cz>
Date: Thu, 02 Jun 2005 13:31:03 +0200
From: =?ISO-8859-1?Q?Martin_MOKREJS=28?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: memory management weirdness
References: <4219E62D.7000009@ribosome.natur.cuni.cz> <m14qg5mq5v.fsf@muc.de>
In-Reply-To: <m14qg5mq5v.fsf@muc.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm continuing an old thread on this topic (see bottom of this mail fro previous discussion).
I've received some answer from ASUS and their German support says that although
their BIOS cannot re-map the memory the operating system can access the whole
memory (they mention Win200 Advanced Server OS)

0    - 3327 MB -> 3327 MB Mainmemory
3327 - 4096 MB -> PCI ROM Reserved
4096 - 4865 MB -> 769 MB Mainmemory (Rest of the 4 GB Memory)

At the moment I have all four 1gB ddr modules in the slots and BIOS has stopped
memory checks at 3327 MB and started to boot. I get sloow machine and:

Linux version 2.6.12-rc5-git6 (root@aquarius) (gcc version 3.4.3-20050110 (Gentoo Linux 3.4.3.20050110-r2, ssp-3.4.3.20050110-0, pie-8.7.7)) #2 Thu Jun 2 11:49:00 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfe30000 (usable)
 BIOS-e820: 00000000cfe30000 - 00000000cfe40000 (ACPI data)
 BIOS-e820: 00000000cfe40000 - 00000000cfef0000 (ACPI NVS)
 BIOS-e820: 00000000cfef0000 - 00000000cff00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
2430MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 851504
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 622128 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000426 MSFT 0x00000097) @ 0xcfe30100
ACPI: FADT (v003 A M I  OEMFACP  0x10000426 MSFT 0x00000097) @ 0xcfe30290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000426 MSFT 0x00000097) @ 0xcfe30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000426 MSFT 0x00000097) @ 0xcfe40040
ACPI: DSDT (v001  P4CED P4CED106 0x00000106 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at cff00000 (gap: cff00000:2fc80000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 128MB: write-back, count=1
reg03: base=0xc8000000 (3200MB), size=  64MB: write-back, count=1
reg04: base=0xcc000000 (3264MB), size=  32MB: write-back, count=1
reg05: base=0xce000000 (3296MB), size=  16MB: write-back, count=1
reg06: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=3
reg07: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1
#


My questions are:
how can I make linux kernel to use rest of the memory? Below is their original answer.
Maybe there's someone interrested in this problem while living in Germany and speaking
much better that I do ... AND understanding the kernel stuff (which I do not).
Martin



From: tsd_germany at asuscom dot de
Hallo,

Das Bios kann kein Remapping bei uns. Sie haben ja schon selber gemerkt, wenn eine etwas höhere Karte eingesetzt wird, geht auch der Speicher runter, das ist normal, weil manche AGP Karten mehr Rom brauchen. 

...

dies ist kein Fehler, da 32bit System standardmäßig nur 4GB adressieren können.
Da alle PCI ROMs (VGA, LAN Controller etc) unterhalb von 4GB adressiert werden müssen, reservieren diese sich Bereiche unterhalb von 4GB.
Dies können mehrere hundert MB sein.

Der eigentliche Arbeitsspeicher liegt dann oberhalb von 4GB und kann durch Betriebssysteme angesprochen werden. (Win2000 Advanced Server)

0    - 3327 MB -> 3327 MB Hauptspeicher
3327 - 4096 MB -> PCI ROM Reservierung
	 4096 MB -> 4GB Grenze
4096 - 4865 MB -> 769 MB Hauptspeicher (Rest der 4 GB Memory)

- Bitte fügen Sie einer Antwort immer den gesamten Schriftverkehr bei !

- Please always attach all previous mails !

Mit freundlichen Grüssen 

 

Technical Support Division  [M07M]
Customer Service Center
ASUS Computer Germany

Homepage: http://www.asuscom.de/
FTP-Server: ftp://ftp.asuscom.de/pub/ASUSCOM

Tel : 02102/9599 - 0 ( Mo. - Fr. 10-17Uhr )
Fax: 02102/959911 ( 24h ) 

ASUS Computer GmbH
Harkortstr. 25
40880 Ratingen











Andi Kleen wrote:
> Martin MOKREJ© <mmokrejs@ribosome.natur.cuni.cz> writes:
> 
> 
>>Hi,
>>  I have received no answer to my former question
>>(see http://marc.theaimsgroup.com/?l=linux-kernel&m=110827143716215&w=2).
> 
> 
> That's because it's a BIOS problem.
> 
> There are limits on how much Linux can work around BIOS breakage.
> 
> 
> 
>>  Although I've not re-tested this today again, it used to help a bit to specify
>>mem=3548M to decrease memory used by linux (tested with AGP card plugged in, when
>>bios reported 3556MB RAM only).
>>
>>  I found that removing the AGP based videoc card and using an old PCI based
>>video card results in bios detecting 4072MB of RAM. But still, the machine was
>>slow. I've tried to "cat >| /proc/mtrr" to alter the memory settings, but the
>>result was only a partial speedup.
>>
>>  I'm not sure how to convince linux kernel to run fast again.
> 
> 
> It's most likely a MTRR problem. Play more with them.
> 
> 
> 
>>  Finally, I put back two 512MB memory modules to have only 3GB RAM physically,
>>and the result is at http://www.natur.cuni.cz/~mmokrejs/tmp/128MB/only_phys_3GB/.
> 
> 
> 
> The cheaper Intel chipsets don't support >4GB at all, and you always
> need some space below 4GB for PCI memory mappings/AGP aperture etc.
> 
> 
> 
>>  About a week ago I tried to contact ASUS, but no answer so far from their
>>techinical support through some web robot.
>>http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM200502111723398547
>>I do not recommend their "greatest" and real "flag-ship" P4C800-E-Deluxe
>>motherboard for use with memory sizes above 3GB (although they claim 4GB
>>is possible). BIOS is the latest release 1.19, although 1.20.001 was tested
>>as well.
> 
> 
> In general non server boards tend to be not very well or not at all
> tested with a lot of memory ("a lot" is defined as >2GB for higher end
> desktop boards, or >1GB on very cheap desktop boards). That is a
> common problem on other motherboards too; Asus is not alone with this.
> 
> -Andi
> 
> 
