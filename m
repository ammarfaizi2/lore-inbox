Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbUKPNDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUKPNDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUKPNCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:02:13 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:2351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261973AbUKPNBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:01:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Qtn5ZRpFy1kOMlWf1Gw2tsvo0fni28lvfmgQm78hxiqygWswdxaarloTfyFnbBwz6Iqzje5o4PsqCSMvcRSBk7ArI/c9AG9HM1xbs3WbB85KGM689rwznc+sEI+nO+6jHKTaFC0bJTSI/2/hsRbO0ZG69shDXXx+hUXBZAsxS6k=
Message-ID: <58cb370e04111605019fc1df8@mail.gmail.com>
Date: Tue, 16 Nov 2004 14:01:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 23:46:56 +1100 (EST), Srihari Vijayaraghavan
<sriharivijayaraghavan@yahoo.com.au> wrote:
> As of 2.6.9-rc4 (I have verified this to be case all
> the way up to 2.6.10-rc2), kernel displays this
> message:
> 
> Uniform Multi-Platform E-IDE driver Revision:
> 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level,
> low) -> IRQ 20
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on
> pci0000:00:0f.1
>     ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings:
> hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings:
> hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: ST3120026A, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: Pioneer DVD-ROM ATAPIModel DVD-113 0113, ATAPI
> CD/DVD-ROM drive
> hdd: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
> hdd: Disabling (U)DMA for RICOH CD-R/RW MP7083A
> (blacklisted)
> 
> The kernel disables DMA on the CD-R/RW (/dev/hdd) and
> of course it would not let me enable it manually
> either. Up until 2.6.9-rc3 the drive worked in DMA
> mode just fine.
> 
> (I have been using this drive for more than 4 years. I
> have used it under 2.2.x, 2.4.x, >=2.5.50 in DMA mode
> just fine. Although I have changed everything else in
> the computer in those long years: CPU, M/B, RAM, HDD
> etc., save this great CD-R/RW drive, which has been
> working fine.)
> 
> So the question is: why?
> (And what can I do to enable DMA again?)

Previously VIA IDE driver ignored DMA blacklists completely
(which was of course wrong), it was fixed.

Probably this drive should be removed from the blacklist.
Does anybody remember why was it added there?

Bartlomiej
