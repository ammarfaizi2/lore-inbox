Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUDPG3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUDPG3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:29:45 -0400
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:25777 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S262462AbUDPG3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:29:42 -0400
Date: Fri, 16 Apr 2004 09:29:45 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Andi Kleen <ak@muc.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
In-Reply-To: <200404152141.18395.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58L0.0404160922200.1660@ahriman.bucharest.roedu.net>
References: <1Ljts-1eQ-29@gated-at.bofh.it> <m37jwhqc2u.fsf@averell.firstfloor.org>
 <200404152141.18395.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Bartlomiej Zolnierkiewicz wrote:

> ICH5 SATA and SiI3112 are the only affected chipsets.
> You don't have to enable libata drivers for them or their
> PCI IDs can be removed from the libata drivers if needed.

Hmm, do you mean that existent SATA drives on current 2.4.x kernels where 
"seen" as /dev/hdX and with the SATA merge will be /dev/sdX ? I dont think 
2.4.x supported SATA (at least not on Intel). I have a ICH5 motherboard 
with one PATA drive and one SATA drive. With 2.6.5 kernel with support for 
IDE PIIX (in the ATA section) and SATA PIIX (in the SCSI low level drivers 
section) I see my PATA as /dev/hda and my SATA as /dev/sdb (I have another 
SCSI disk on a SCSI controller which is /dev/sda). So it does seem to me 
to do the right thing. Also on 2.4.25 with PIIX support I only saw the 
PATA disk. In BIOS the PATA/SATA configuration is set to "Enhanced". More 
informations:

ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later

00:1f.1 IDE interface: Intel Corp.: Unknown device 25a2 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 342f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 25a3 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corp.: Unknown device 342f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 2: I/O ports at e400 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at dc00 [size=16]



> Bartlomiej

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
