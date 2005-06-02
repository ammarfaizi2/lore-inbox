Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFBJeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFBJeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFBJeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:34:36 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:18317 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S261333AbVFBJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:34:27 -0400
Message-ID: <429ED2A2.6000606@ribosome.natur.cuni.cz>
Date: Thu, 02 Jun 2005 11:34:26 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc5-git6 mis-counted ide interfaces
References: <429ECE20.1030403@ribosome.natur.cuni.cz> <58cb370e050602022570ee3eba@mail.gmail.com>
In-Reply-To: <58cb370e050602022570ee3eba@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 6/2/05, Martin MOKREJŠ <mmokrejs@ribosome.natur.cuni.cz> wrote:
> 
>>Hi,
>>  I get the following when I boot my PIIX computer (Asus P4C800E-Deluxe):
>>
>>
>>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>ide: Assuming 66MHz system bus speed for PIO modes
>>ICH5: IDE controller at PCI slot 0000:00:1f.1
>>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>>ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
>>ICH5: chipset revision 2
>>ICH5: not 100% native mode: will probe irqs later
>>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
>>Probing IDE interface ide0...
>>hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>Probing IDE interface ide1...
>>----------------------^^^^ ide0 I believe
> 
> 
> ide0 is 3 lines above
> 
> 
>>Probing IDE interface ide1...
>>Probing IDE interface ide2...
>>Probing IDE interface ide3...
>>Probing IDE interface ide4...
>>Probing IDE interface ide5...
> 
> 
> If you have CONFIG_IDE_GENERIC=y in your config everything is fine
> (IDE driver simply tries to probe legacy ports).

Yes, I do, I was just fooled why I see twice probe for ide1. So you say the "extra"
probe for ide1 is because of CONFIG_IDE_GENERIC=y?

The next ide port are two SATA port and two SATA-RAID ports, btw.
Martin
