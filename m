Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJBTPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJBTPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJBTPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 15:15:09 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:10155 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S1751153AbVJBTPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 15:15:08 -0400
Date: Sun, 2 Oct 2005 23:14:59 +0400 (MSD)
From: Evgeny Rodichev <er@sai.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode)
Message-ID: <Pine.GSO.4.63.0510022307280.5120@ra.sai.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch doesn't work for me. Controller is

03:04.0 RAID bus controller: Marvell MV88SX6041 4-port SATA II PCI-X Controller (rev 03)
         Subsystem: Super Micro Computer Inc: Unknown device 6880
         Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 64, IRQ 20
         Memory at dd300000 (64-bit, non-prefetchable) [size=1M]
         I/O ports at 3000 [size=256]
         Capabilities: [40] Power Management version 2
         Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
         Capabilities: [60] PCI-X non-bridge device.

After modprobe sata_mv I got in dmesg:

sata_mv version 0.22
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 56 (level, low) -> IRQ 20
sata_mv(0000:03:04.0) 32 slots 4 ports unknown mode IRQ via INTx
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 20
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 20
ATA: abnormal status 0x80 on port 0xF8A2211C
ATA: abnormal status 0x80 on port 0xF8A2211C

modprobe did not finished, and it is impossible to kill the modprobe
process.

Regards,
E.R.
_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
