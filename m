Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270090AbRHUGMl>; Tue, 21 Aug 2001 02:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRHUGMb>; Tue, 21 Aug 2001 02:12:31 -0400
Received: from rumpleteazer.ucsc.edu ([128.114.129.45]:46864 "EHLO
	cats.ucsc.edu") by vger.kernel.org with ESMTP id <S270090AbRHUGMQ>;
	Tue, 21 Aug 2001 02:12:16 -0400
From: Jim McCloskey <mcclosk@ling.ucsc.edu>
To: linux-kernel@vger.kernel.org
Subject: PCI resource allocation
Message-Id: <E15Z4kz-0000Uo-00@toraigh>
Date: Mon, 20 Aug 2001 23:11:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.9 (patched from 2.4.7). The hardware is this:

Mainboard:      Tyan Trinity K7 S238
CPU:            AMD Athlon K7 750MHz
Memory:         PC-133 128MB
Boot HD:        Seagate 9.1GB LVD
SCSI HBA:	Tekram DC390U2W PCI

I continue to get these warnings at boot-time:

Jul 31 09:14:58 kernel: PCI: Cannot allocate resource region 0 of device 01:00.0
Jul 31 09:14:58 kernel: PCI: Failed to allocate resource 0(d8000000-d8ffffff) for 01:00.0

Device 1 is the video card, which is a Matrox G400 AGP.

lspci reports:

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
        Flags: bus master, medium devsel, latency 32, IRQ 15
        Memory at d8000000 (32-bit, prefetchable) [size=16M]
        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

The card basically works, but I get problems under applications that
make heavy demands (programs hang or produce seg-faults). I've had the
warnings ever since upgrading from the 2.2.x series to the 2.4.x
series.

I gather from the archives that this is a known problem, and that it
has been discussed quite a bit. Is there a way I can help track down
the problem, or a proposed solution that I could try?

Thanks a lot,

Jim McCloskey





