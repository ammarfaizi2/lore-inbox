Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUEVPEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUEVPEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUEVPEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:04:48 -0400
Received: from ws3.netA.ort.spb.ru ([195.70.200.211]:35716 "EHLO
	gate-n.ort.spb.ru") by vger.kernel.org with ESMTP id S261500AbUEVPEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:04:44 -0400
Date: Sat, 22 May 2004 19:04:33 +0400 (MSD)
From: Andrew Shirrayev <andrews@gate.ort.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Adds: PROBLEM: SMP kernel freeze on e1000,ipx,ncp complex
In-Reply-To: <Pine.LNX.4.33.0405200357150.28012-100000@gate.ort.spb.ru>
Message-ID: <Pine.LNX.4.33.0405221854200.14832-100000@gate.ort.spb.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score-Gate: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same result SMP kernel with acpi=on on dual Xeon P4 (w/o HT)


Load ACPI klog:
kernel:  BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
kernel:  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
kernel: ACPI: RSDP (v000 AMI                                       ) @ 0x000ff900
kernel: ACPI: RSDT (v001 RCC    GCHE     0x00000001 MSFT 0x01000000) @ 0x3fff0000
kernel: ACPI: FADT (v001 RCC    GCHE     0x00000001 MSFT 0x01000000) @ 0x3fff0030
kernel: ACPI: MADT (v001 RCC    GCHE     0x00000001 MSFT 0x01000000) @ 0x3fff00b0
kernel: ACPI: DSDT (v001    RCC     GCSL 0x00000100 MSFT 0x0100000d) @ 0x00000000
kernel: ACPI: Local APIC address 0xfee00000
kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x00] disabled)
kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
kernel: ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
kernel: ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
kernel: ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
kernel: ACPI: IOAPIC (id[0x08] address[0xfec00000] global_irq_base[0x0])
kernel: ACPI: IOAPIC (id[0x09] address[0xfec01000] global_irq_base[0x10])
kernel: ACPI: IOAPIC (id[0x0a] address[0xfec02000] global_irq_base[0x20])
kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
kernel: Using ACPI (MADT) for SMP configuration information
kernel: Kernel command line: BOOT_IMAGE=Linux-ACPI root=802 acpi=on
kernel: ACPI: Subsystem revision 20040326
kernel:     ACPI-0562: *** Warning: Type override - [DEB_] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [MLIB] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [IO__] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [DATA] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [SB__] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [ICNT] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [ACPI] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [IORG] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [SB__] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [BIOS] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [CMOS] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [KBC_] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel:     ACPI-0562: *** Warning: Type override - [OEM_] had invalid type (Integer) for Scope operator, changed to (Scope)
kernel: ACPI: Interpreter enabled
kernel: ACPI: Using IOAPIC for interrupt routing
kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
kernel: ACPI: PCI Root Bridge [NRTH] (00:00)
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
kernel: ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN16] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN17] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN18] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN19] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN20] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN21] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN22] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN23] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN24] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN25] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN26] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN27] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN28] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN29] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN30] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LN31] (IRQs 3 4 5 7 9 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNUS] (IRQs 10)
kernel: ACPI: PCI Interrupt Link [LNTE] (IRQs 11)
kernel: ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 10
kernel: PCI: Using ACPI for IRQ routing
kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
kernel: ACPI: Power Button (FF) [PWRF]
kernel: ACPI: Sleep Button (CM) [SLPB]
kernel: ACPI: Processor [CPU0] (supports C1)
kernel: ACPI: Processor [CPU1] (supports C1)

