Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVA1UTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVA1UTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVA1URp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:17:45 -0500
Received: from math.ut.ee ([193.40.5.125]:43921 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262756AbVA1UQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:16:45 -0500
Date: Fri, 28 Jan 2005 22:16:43 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: TI Cardbus bridge has unsupported PM cap regs version
Message-ID: <Pine.SOC.4.61.0501282209580.3696@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system is working fine, it just gives warnings about unsupported PM 
cap regs version (1). This is an excerpt from dmesg:

PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
PCI: Enabling device 0000:00:11.0 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
PCI: 0000:00:11.1 has unsupported PM cap regs version (1)
PCI: Enabling device 0000:00:11.1 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:11.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
PCI: 0000:00:11.1 has unsupported PM cap regs version (1)
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000020

0000:00:11 is TI cardbus bridge with 2 ports:

0000:00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
         16-bit legacy interface ports at 0001

0000:00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
         Memory window 0: 10c00000-10fff000 (prefetchable)
         Memory window 1: 11000000-113ff000
         I/O window 0: 00004800-000048ff
         I/O window 1: 00004c00-00004cff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
         16-bit legacy interface ports at 0001

One of the ports has a realtek 8139c nic plugged in, the other is empty, 
but this probably doesn't matter.

-- 
Meelis Roos (mroos@linux.ee)
