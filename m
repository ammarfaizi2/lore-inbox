Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVDAQKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVDAQKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVDAQKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:10:01 -0500
Received: from smtp06.web.de ([217.72.192.224]:35006 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S262781AbVDAQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:08:10 -0500
Message-ID: <424D71DE.5060703@web.de>
Date: Fri, 01 Apr 2005 18:07:58 +0200
From: Michael Thonke <tk-shockwave@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050323)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
 2.6.12-rc1[mm1-4]
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl>
In-Reply-To: <424D5E2E.8040207@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 0513-2, 01.04.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Jacek,

its not related to the vendor so far we are :-)
Maybe Andrew Morton or some other will read this. Because 2.6.12 should 
be a stable version not a flacky one. But what is wrong now on 
2.6.12-rc1 **. It work flawlessly on 2.6.11.X kernels.
Mebye we back that out :-)

Greetz


|Jacek Luczak schrieb:

> Michael Thonke napisał(a):
>
>> Hello,
>>
>> since the first version of 2.6.12-rc1 and mm[1-4] kernel I can't use any
>> of my PCI-Express devices that worked with all 2.6.11.[1-6] kernels. 
>> It's a real odd right now.
>>
>> I have 25 computers with an Intel 925XE Chipset based motherboards 
>> and Intel 6xx CPU on it. So far it does not metter which vendor I 
>> choose (ASUS,ABIT,MSI etc.) the problem stay the same and spread all 
>> over.I
>> tried to boot with pci=routeicq but it did not help to get one device
>> working with any 2.6.12-rc1-xx kernel. As I mentioned before I tested 
>> it with on several (over 25 computer) with various motherboards (with 
>> ASUS,ABIT,MSI etc.) no luck. Its an 64bit system with [EMT64] and 
>> SMP/SMT and preempt enabled + cpufreq.
>>
>> My first look was on PCI Routingtable and I found a difference to
>> 2.6.11.x working kernel:
>>
>
> I've got the same problem with i915 on Asus P5GDC V Deluxe Mainboard.
> This fragment of dmesg is from 2.6.12-rc1-mm4 kernel:
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
> Boot video device is 0000:00:02.0
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Can't get handler for 0000:00:02.0
> ACPI: Can't get handler for 0000:00:02.1
> ACPI: Can't get handler for 0000:00:1b.0
> ACPI: Can't get handler for 0000:00:1f.3
> ACPI: Can't get handler for 0000:02:00.0
> ACPI: Can't get handler for 0000:01:04.0
> ACPI: Can't get handler for 0000:01:0a.0
> ACPI: Can't get handler for 0000:01:0b.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
> disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> ACPI: No ACPI bus support for 00:00
> ACPI: No ACPI bus support for 00:01
> ACPI: No ACPI bus support for 00:02
> ACPI: No ACPI bus support for 00:03
> ACPI: No ACPI bus support for 00:04
> ACPI: No ACPI bus support for 00:05
> ACPI: No ACPI bus support for 00:06
> ACPI: No ACPI bus support for 00:07
> ACPI: No ACPI bus support for 00:08
> ACPI: No ACPI bus support for 00:09
> ACPI: No ACPI bus support for 00:0a
> ACPI: No ACPI bus support for 00:0b
> ACPI: No ACPI bus support for 00:0c
> ACPI: No ACPI bus support for 00:0d
> ACPI: No ACPI bus support for 00:0e
> ACPI: No ACPI bus support for 00:0f
> ACPI: No ACPI bus support for 00:10
> pnp: PnP ACPI: found 17 devices
> SCSI subsystem initialized
>
> LSPCI OUTPUT:
> 00:00.0 Host bridge: Intel Corp.: Unknown device 2580 (rev 04)
>     Subsystem: Intel Corp.: Unknown device 2580
>     Flags: bus master, fast devsel, latency 0
>     Capabilities: [e0] #09 [2109]
>
> 00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2582 
> (rev 04) (prog-if 00 [VGA])
>     Subsystem: Asustek Computer, Inc.: Unknown device 2582
>     Flags: bus master, fast devsel, latency 0, IRQ 16
>     Memory at cfc80000 (32-bit, non-prefetchable) [size=512K]
>     I/O ports at 9800 [size=8]
>     Memory at d0000000 (32-bit, prefetchable) [size=256M]
>     Memory at cfd80000 (32-bit, non-prefetchable) [size=256K]
>     Expansion ROM at <unassigned> [disabled]
>     Capabilities: [d0] Power Management version 2
>
> 00:02.1 Display controller: Intel Corp.: Unknown device 2782 (rev 04)
>     Subsystem: Asustek Computer, Inc.: Unknown device 2582
>     Flags: bus master, fast devsel, latency 0
>     Memory at cfd00000 (32-bit, non-prefetchable) [size=512K]
>     Capabilities: [d0] Power Management version 2
>
> 00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 03)
>     Subsystem: Asustek Computer, Inc.: Unknown device 813d
>     Flags: bus master, fast devsel, latency 0, IRQ 10
>     Memory at cfdf4000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>     Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
> Enable-
>     Capabilities: [70] #10 [0091]
>
> 00:1c.0 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 0 
> (rev 03) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0
>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: 0000e000-0000efff
>     Capabilities: [40] #10 [0141]
>     Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>     Capabilities: [90] #0d [0000]
>     Capabilities: [a0] Power Management version 2
>
> 00:1c.1 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 1 
> (rev 03) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 0000d000-0000dfff
>     Memory behind bridge: cff00000-cfffffff
>     Capabilities: [40] #10 [0141]
>     Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>     Capabilities: [90] #0d [0000]
>     Capabilities: [a0] Power Management version 2
>
> 00:1d.0 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) 
> (prog-if 00 [UHCI])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 23
>     I/O ports at 9880 [size=32]
>
> 00:1d.1 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) 
> (prog-if 00 [UHCI])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 19
>     I/O ports at 9c00 [size=32]
>
> 00:1d.2 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) 
> (prog-if 00 [UHCI])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 18
>     I/O ports at a000 [size=32]
>
> 00:1d.3 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03) 
> (prog-if 00 [UHCI])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 16
>     I/O ports at a080 [size=32]
>
> 00:1d.7 USB Controller: Intel Corp. I/O Controller Hub USB2 (rev 03) 
> (prog-if 20 [EHCI])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 11
>     Memory at cfdff800 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>     Capabilities: [58] #0a [20a0]
>
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to 
> PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
>     Flags: bus master, fast devsel, latency 0
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>     I/O behind bridge: 0000b000-0000cfff
>     Memory behind bridge: cfe00000-cfefffff
>     Capabilities: [50] #0d [0000]
>
> 00:1f.0 ISA bridge: Intel Corp. I/O Controller Hub LPC (rev 03)
>     Flags: bus master, medium devsel, latency 0
>
> 00:1f.1 IDE interface: Intel Corp. I/O Controller Hub PATA (rev 03) 
> (prog-if 8a [Master SecP PriP])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: bus master, medium devsel, latency 0, IRQ 18
>     I/O ports at <unassigned>
>     I/O ports at <unassigned>
>     I/O ports at <unassigned>
>     I/O ports at <unassigned>
>     I/O ports at ffa0 [size=16]
>
> 00:1f.2 IDE interface: Intel Corp. I/O Controller Hub SATA cc=raid 
> (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
>     Subsystem: Asustek Computer, Inc.: Unknown device 2601
>     Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
>     I/O ports at ac00 [size=8]
>     I/O ports at a880 [size=4]
>     I/O ports at a800 [size=8]
>     I/O ports at a480 [size=4]
>     I/O ports at a400 [size=16]
>     Memory at cfdffc00 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [70] Power Management version 2
>
> 00:1f.3 SMBus: Intel Corp. I/O Controller Hub SMBus (rev 03)
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Flags: medium devsel
>     I/O ports at 0400 [size=32]
>
> 01:04.0 Unknown mass storage controller: Integrated Technology 
> Express, Inc.: Unknown device 8212 (rev 13)
>     Subsystem: Asustek Computer, Inc.: Unknown device 813a
>     Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
>     I/O ports at cc00 [size=8]
>     I/O ports at c080 [size=4]
>     I/O ports at c000 [size=8]
>     I/O ports at bc00 [size=4]
>     I/O ports at b880 [size=16]
>     Expansion ROM at cfec0000 [disabled] [size=128K]
>     Capabilities: [80] Power Management version 2
>
> 01:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 
> (rev 10)
>     Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
>     Flags: bus master, medium devsel, latency 64, IRQ 21
>     I/O ports at c400 [size=256]
>     Capabilities: [c0] Power Management version 2
>
> 01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown 
> device 8180 (rev 20)
>     Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8180
>     Flags: bus master, medium devsel, latency 64, IRQ 22
>     I/O ports at c800 [size=256]
>     Memory at cfeffc00 (32-bit, non-prefetchable) [size=256]
>     Capabilities: [50] Power Management version 2
>
> 02:00.0 Ethernet controller: Marvell: Unknown device 4362 (rev 15)
>     Subsystem: Asustek Computer, Inc.: Unknown device 8142
>     Flags: bus master, fast devsel, latency 0, IRQ 17
>     Memory at cfffc000 (64-bit, non-prefetchable) [size=16K]
>     I/O ports at d800 [size=256]
>     Expansion ROM at cffc0000 [disabled] [size=128K]
>     Capabilities: [48] Power Management version 2
>     Capabilities: [50] Vital Product Data
>     Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 
> Enable-
>     Capabilities: [e0] #10 [0011]
>
>
>
>

