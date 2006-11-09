Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424212AbWKIWnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424212AbWKIWnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424213AbWKIWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:43:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:17716 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424212AbWKIWnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:43:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MouOna5KCM42XqRGbaKCJFqK7+v5bHk/hXNWJCyOFntn3hXNGV/N2dAmwrGfRVMeSDWaf7A45MOF0NCQks/imAL1LeLPjAioEkBA1pEr+3Sp5v0mGU8R73iXMjUuduZRUYDTWrDMdJ3kQ6NmLxlRURaDAvGWN/f6uEl/PwSi19I=
Message-ID: <68676e00611091443x4eac926fof7b1b403210c9cc8@mail.gmail.com>
Date: Thu, 9 Nov 2006 23:43:17 +0100
From: "Luca Tettamanti" <kronos.it@gmail.com>
To: Stephen.Clark@seclark.us
Subject: Re: Abysmal PATA IDE performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4553A8AC.2090805@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061109202319.GA13940@dreamland.darkstar.lan>
	 <4553903B.4010908@seclark.us>
	 <68676e00611091352l16663ff9o86f663a28190c0dc@mail.gmail.com>
	 <4553A8AC.2090805@seclark.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> Luca Tettamanti wrote:
>
> >On 11/9/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> >
> >>Luca Tettamanti wrote:
> >>
> >>>Stephen Clark <Stephen.Clark@seclark.us> ha scritto:
> >>>
> >>>>Looking at the dmesg output I am a little confused, see comments below:
> >>>>partial dmesg output follows:
> >>>>
> >>>>SCSI subsystem initialized
> >>>>libata version 2.00 loaded.
> >>>>ata_piix 0000:00:1f.2: version 2.00
> >>>>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> >>>>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
> >>>>PCI: Setting latency timer of device 0000:00:1f.2 to 64
> >>>>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> >>>>scsi0 : ata_piix
> >>>>Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
> >>>>input: SynPS/2 Synaptics TouchPad as /class/input/input1
> >>>>ATA: abnormal status 0x7F on port 0x1F7
> >>>>ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> >>>>scsi1 : ata_piix
> >>>>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> >>>>ata2.00: ata2: dev 0 multi count 16
> >>>>usb 2-2: new low speed USB device using uhci_hcd and address 3
> >>>>ata2.01: ATAPI, max UDMA/33
> >>>>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
> >>>>===============****
> >>>>
> >>>This is your optical (CD/DVD) unit; I doubt that you can saturate that
> >>>link, even if your drive can do a sustained 16x transfer with a DVD it
> >>>will use only 21MBps. Your HD is using UDMA/100.
> >>>
> >>aren't the ata2.00: messages referring to my hard drive and the
> >>ata2.01 messages referring to my optical drive?
> >>
> >>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> >>ata2.00: ata2: dev 0 multi count 16
> >>
> >>ata2.01: ATAPI, max UDMA/33
> >>
> >>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
> >>
> >>
> >
> >You're right, I misparsed your log. Probably Arjan is right about the wiring.
> >
> >Luca
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> The specs for the laptop say it supports ide 100MBps (Ultra DMA 5).

Well, the controller does support UDMA 5, maybe it's just marketing.
Or maybe autodetection just doesn't work.

Luca
