Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUHaT0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUHaT0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbUHaTYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:24:47 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:33187 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S268990AbUHaTQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:16:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2
Date: Tue, 31 Aug 2004 15:16:07 -0400
User-Agent: KMail/1.7
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>
References: <20040830235426.441f5b51.akpm@osdl.org> <230680000.1093978386@flay>
In-Reply-To: <230680000.1093978386@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311516.07980.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.62.54] at Tue, 31 Aug 2004 14:16:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 14:53, Martin J. Bligh wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-
>rc1/2.6.9-rc1-mm2/
>
>> Nothing particularly noteworthy here.  Some seriously bad
>> scheduler performance with SMT and HT was fixed up, as was the
>> fails-to-read-the-last-4k-of-a-file brown bag.
>
>Something is borked in ACPI:
>
>drivers/built-in.o(.text+0x1cf2c): In function `acpi_pci_root_add':
>/root/linux/2.6.9-rc1-mm2/drivers/acpi/pci_root.c:270: undefined
> reference to `pci_acpi_scan_root'
>
>Didn't actually realise I had ACPI config'ed in, so will just get
> rid of it, but though you might want to know.
>
>M.

I think the borken is maybe in the .config interpretor.  I don't have 
any ACPI stuff turned on at all, but I've got these lines in my dmesg 
I've never seen before:

CPI: RSDP (v000 Nvidia                                ) @ 0x000f7220
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x3fff3040
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x00000000
---
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
---
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
---
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
-ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 5 (level, low) -> IRQ 5
---
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 12
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 12 (level, low) -> IRQ 12
---
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
---
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 12
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 12 (level, low) -> IRQ 12
eth0: RealTek RTL8139 at 0xf883a000, 00:50:ba:5d:eb:7d, IRQ 12
---
eth0:  IdentiCPI: PCI Interrupt Link [LACI] enabled at IRQ 12
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 12 (level, low) -> IRQ 12
fied 8139 chip type 'RTL-8139C'
---

I don't know if this is going to screw me over or not.  But I am sure 
that ACPI is turned off as shown in a make xconfig. And I just 
double-checked, its off,

But: #>grep ACPI .config

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_PCI=y

Not sure whats going on, can someone turn on the lights?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
