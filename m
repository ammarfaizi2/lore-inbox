Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161838AbWKIVwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161838AbWKIVwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161843AbWKIVwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:52:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:46110 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161838AbWKIVwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:52:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T6JXaBz3WFhfwvfHfit0HvhktwTrCqYC6a58mOz/lG4OXmARYcpMoDdgm+WsJQnZds9t/YWhOzJe/3/jWE5jhkrh0MG0AkPCf9H9HmieY7zBrgZpJI2yujyr5IhVwH/8bd0iJABzdfCxN9uZDexWA8tU9cchfx9xSr7/atxr6Lo=
Message-ID: <68676e00611091352l16663ff9o86f663a28190c0dc@mail.gmail.com>
Date: Thu, 9 Nov 2006 22:52:04 +0100
From: "Luca Tettamanti" <kronos.it@gmail.com>
To: Stephen.Clark@seclark.us
Subject: Re: Abysmal PATA IDE performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4553903B.4010908@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061109202319.GA13940@dreamland.darkstar.lan>
	 <4553903B.4010908@seclark.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> Luca Tettamanti wrote:
>
> >Stephen Clark <Stephen.Clark@seclark.us> ha scritto:
> >
> >
> >>Looking at the dmesg output I am a little confused, see comments below:
> >>partial dmesg output follows:
> >>
> >>SCSI subsystem initialized
> >>libata version 2.00 loaded.
> >>ata_piix 0000:00:1f.2: version 2.00
> >>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> >>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
> >>PCI: Setting latency timer of device 0000:00:1f.2 to 64
> >>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> >>scsi0 : ata_piix
> >>Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
> >>input: SynPS/2 Synaptics TouchPad as /class/input/input1
> >>ATA: abnormal status 0x7F on port 0x1F7
> >>ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> >>scsi1 : ata_piix
> >>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> >>ata2.00: ata2: dev 0 multi count 16
> >>usb 2-2: new low speed USB device using uhci_hcd and address 3
> >>ata2.01: ATAPI, max UDMA/33
> >>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
> >>===============****
> >>
> >>
> >
> >This is your optical (CD/DVD) unit; I doubt that you can saturate that
> >link, even if your drive can do a sustained 16x transfer with a DVD it
> >will use only 21MBps. Your HD is using UDMA/100.
>
> aren't the ata2.00: messages referring to my hard drive and the
> ata2.01 messages referring to my optical drive?
>
> ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
>
> ata2.01: ATAPI, max UDMA/33
>
> ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?

You're right, I misparsed your log. Probably Arjan is right about the wiring.

Luca
