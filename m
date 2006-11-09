Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423860AbWKIUXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423860AbWKIUXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965559AbWKIUXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:23:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:58309 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965546AbWKIUXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:23:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ahUbz43mWtOXYzlLAs1gAb+WN3Crw6zxORM9SD5ee48MONdxZUysdF43w9SHTCYhrEfU76XZ0Ox/bZGoiqYcYF3oVnIX9/Ha6u9dJG14LiVHd4AtNfZs48GYnh+mFhZJcQ+v9ylIWnYwDW2vK0bPiY48V0CsTKbs2ihIWX2eZY8=
Date: Thu, 9 Nov 2006 21:23:19 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal PATA IDE performance
Message-ID: <20061109202319.GA13940@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45536653.50006@seclark.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark <Stephen.Clark@seclark.us> ha scritto:
> Looking at the dmesg output I am a little confused, see comments below:
> partial dmesg output follows:
> 
> SCSI subsystem initialized
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.2: version 2.00
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> scsi0 : ata_piix
> Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
> input: SynPS/2 Synaptics TouchPad as /class/input/input1
> ATA: abnormal status 0x7F on port 0x1F7
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> scsi1 : ata_piix
> ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
> usb 2-2: new low speed USB device using uhci_hcd and address 3
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
> ===============****

This is your optical (CD/DVD) unit; I doubt that you can saturate that
link, even if your drive can do a sustained 16x transfer with a DVD it
will use only 21MBps. Your HD is using UDMA/100.

Forcing the interface to a higher speed may lead to CRC errors when
using the drive.

Luca
-- 
Windows NT: Designed for the Internet. The Internet: Designed for Unix.
