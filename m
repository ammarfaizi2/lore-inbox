Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUHKT0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUHKT0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268187AbUHKT0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:26:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268011AbUHKT0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:26:38 -0400
Message-ID: <411A72E0.2010301@pobox.com>
Date: Wed, 11 Aug 2004 15:26:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arvind Autar <arvind.autar@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: SATA issue's
References: <80c0fd0e040731150713ca0e6c@mail.gmail.com>
In-Reply-To: <80c0fd0e040731150713ca0e6c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Autar wrote:
> So, here I'm, trying to setup a box.
> I installed debian sarge with 2.4.25-1-386. It ran fine, but didn't
> work with my s-ata disk.
> 
> I grabbed 2.6.8-rc2 and 2.6.8-rc1-mm1. Bot gave me the same results.
> 
> My ata disk uses Amd74xx Adn the s-ata siimage/sata_sil . The amd74
> got compiled in as * because that's the disk where linux got
> installed. siimage/sata_sil got copmiled as a module, I needed the
> disk to mount my fat32 partition so I could get to mine music files. I
> booted both kernels both of them started to freeze after a while. So I
> started to look in the log files and found this: (see attachment)208K
> Unfortunately I don't have any debugging(?) info from the Amd74xx all
> I know is that it gives some error about kernel bug at
> drivers/ide/ide-10.c:112 and it makes my computer probably freeze. I
> even booted with: 'noirqdebug' but the results I got where
> 
> SCSI subsystem initialized
> ACPI : PCI interrupt 0000:01:0b[A] -> GSI 11(level , low ) -> IRQ 11
> ata1 : SATA max UDMA / 100 cmd 0xE0B8E080 ctl 0xE0B8E08A bmdma 0xE0B8E000 irq 11
> ata2 : SATA max UDMA / 100 cmd 0xE0B8E0C0 ctl 0xE0B8E0CA bmdma 0xE0B8E008 irq 11
> and then there was a freeze
> 
> I hope this problem gets solved soon.


Most likely you need to update your BIOS, or boot with "noapic", or boot 
with "pci=noacpi", or similar.

	Jeff


