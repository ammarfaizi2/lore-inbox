Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUFTO2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUFTO2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUFTO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:28:13 -0400
Received: from mailout.despammed.com ([65.112.71.29]:26535 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S265331AbUFTO2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:28:06 -0400
Date: Sun, 20 Jun 2004 09:14:35 -0500 (CDT)
Message-Id: <200406201414.i5KEEZk18928@mailout.despammed.com>
From: alftanner@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Please help for SiS 180 parallel ata
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I own a brand new mb for my AMD3200+, Jetway S755max
with a Sis chipset 755, southbridge 963 + Sis 180.

I would like to use my Pioneer dvd recorder on the
third parallel ide, controlled by the sis 180 chipset.
I am running fedora core 1, with
kernel-2.4.22-1.2188.nptl.
I have tried this patch for kernel 2.4.25

2.4.25-libata16.patch.bz2 
found at:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/old/

and enabled sata_sis.c, compiling it directly in the
kernel (not as module).

Unfortunately it is not detected at boot time. The
lspci -vv output gives:
00:0c.0 RAID bus controller: Silicon Integrated
Systems [SiS]: Unknown device 0180 (prog-if 85)
        Subsystem: Silicon Integrated Systems [SiS]:
Unknown device 0180
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: I/O ports at <unassigned>
        Expansion ROM at <unassigned> [disabled]
[size=64K]


I have installed the SiS driver and xp is happy with
the dvd recorder. It is correctly detected by the
bios.

Afterwards, I tried to compile sata_sis as a module.

The parallel Pioneer is still not recognised:

When I modprobe sata_sis I obtain:

libata version 1.02 loaded.
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD802 bmdma
0xE400 irq 12
ata2: SATA max UDMA/133 cmd 0xDC00 ctl 0xE002 bmdma
0xE408 irq 12
ata1: no device found (phy stat 41b7c0c6)
ata1: thread exiting
i8253 count too high! resetting..
ata2: no device found (phy stat 00ff078b)
ata2: thread exiting
scsi1 : sata_sis
scsi2 : sata_sis
i8253 count too high! resetting..

Does it mean that Sis 180 works only with sata, not
with its parallel port?

Thanks

