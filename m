Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWKDKMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWKDKMG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWKDKMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:12:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:38336 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965186AbWKDKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:12:04 -0500
Message-ID: <454C6767.3090901@gmx.net>
Date: Sat, 04 Nov 2006 11:11:51 +0100
From: otto Meier <gf435@gmx.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
CC: jeff@garzik.org
Subject: More Promise chipset specs opened
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:468b128da021a7447d21877842847db4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff Garzik wrote:
>
>     Promise has given me permission to post hardware programming info
>     for one of their chips (Linux driver: sata_promise), PDC20319.
>     This also marks the first open chipset for Promise (AFAIK), so
>     let's give them a round of applause. 
>
>
> I missed an email from Promise which supplied even more chipset docs
> to open. Whoops. The entire line supported by sata_promise.c should
> now be open:

I use the following Promise Card : (lspci output):

02:06.0 Mass storage controller: Promise Technology, Inc. PDC20718 (SATA
300 TX4) (rev 02)
        Subsystem: Promise Technology, Inc. PDC20718 (SATA 300 TX4)
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 185
        I/O ports at bc00 [size=128]
        I/O ports at b800 [size=256]
        Memory at fdeff000 (32-bit, non-prefetchable) [size=4K]
        Memory at fdec0000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at fdd80000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

lspci -vvn:

02:06.0 Class 0180: 105a:3d17 (rev 02)
        Subsystem: 105a:3d17
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at bc00 [size=128]
        Region 2: I/O ports at b800 [size=256]
        Region 3: Memory at fdeff000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fdec0000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at fdd80000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-





Dmesg:
<7>sata_promise 0000:02:06.0: version 1.04
<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
<6>GSI 17 sharing vector 0xB9 and IRQ 17
<6>ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [APC1] -> GSI 16 (level,
low) -> IRQ 185
<6>ata5: SATA max UDMA/133 cmd 0xFFFFC20000022200 ctl 0xFFFFC20000022238
bmdma 0x0 irq 185
<6>ata6: SATA max UDMA/133 cmd 0xFFFFC20000022280 ctl 0xFFFFC200000222B8
bmdma 0x0 irq 185
<6>ata7: SATA max UDMA/133 cmd 0xFFFFC20000022300 ctl 0xFFFFC20000022338
bmdma 0x0 irq 185
<6>ata8: SATA max UDMA/133 cmd 0xFFFFC20000022380 ctl 0xFFFFC200000223B8
bmdma 0x0 irq 185
<6>scsi4 : sata_promise
<6>ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
<6>ata5.00: configured for UDMA/133

In which controller classes does it belong?
Promise claims it should  have NCQ  how to enable ?

Best regards

