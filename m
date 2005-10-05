Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVJETRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVJETRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVJETRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:17:04 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:51145 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S965229AbVJETRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:17:02 -0400
Date: Wed, 5 Oct 2005 21:14:44 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Brett Russ <russb@emc.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode)
 (resend: v0.22)
In-Reply-To: <20050930053600.F3B821CDD0@lns1058.lss.emc.com>
Message-ID: <Pine.LNX.4.44.0510052106580.23892-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, Brett Russ wrote:

> The 5xxx series parts are not yet DMA capable in this driver because
> the registers have differences that haven't been accounted for yet.

In my setup with a MV88SX5041, this new driver doesn't recognize any 
disk connected to the controller. The controller seems to be 
recognized fine, but nothing else:

sata_mv version 0.22
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 209
MSI INIT SUCCESS
sata_mv(0000:02:08.0) 32 slots 4 ports SCSI mode IRQ via MSI
ata3: SATA max PIO4 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 209
ata4: SATA max PIO4 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 209
ata5: SATA max PIO4 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 209
ata6: SATA max PIO4 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 209
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv

(starting at scsi2 'cause the first 2 are on a ata_piix SATA).
/proc/interrupts shows no interrupts received:

209:          0          0   IO-APIC-level  libata

Thanks!

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

