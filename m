Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUGDSDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUGDSDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUGDSDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:03:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61894 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265293AbUGDSDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:03:36 -0400
Message-ID: <40E8466B.9000702@pobox.com>
Date: Sun, 04 Jul 2004 14:03:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5
 ok
References: <20040630005420.GA4163@ti64.telemetry-investments.com>
In-Reply-To: <20040630005420.GA4163@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> Jeff,
> 
> I have a Dell Poweredge 750 with a pair of Maxtor 250GB SATA drives
> running Fedora Core 1 + upgrades to support 2.6.
> 
> The Dell BIOS configures the controller in combined mode.
> Kernel 2.6.7-bk5 boots, while 2.6.7-bk6,bk12 generate the following
> timeout (copied by hand):
> 
> ata_piix: combined mode detected
> ACPI: PCI interrupt 0000:1f.2[A]: no GSI
> ata: 0x1f0 IDE port busy
> ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
> ata1: dev 0 ATA, max UDMA/133 488281250 sectors: lba48
> ata1: dev 1 ATA, max UDMA/133 488281250 sectors: lba48
> ata1: dev0 configured for UDMA/133
> ata1: dev1 configured for UDMA/133
> scsi0: ata_piix
>   Vendor: ATA      Model: Maxtor 7Y250M0    Rev: YAR5
>   Type: Direct Access                       ANSI SCSI revision: 05
> SCSI device sda: 488281250 512-byte hdwr sectors (250000MB)
> SCSI device sda: drive cache: write back
>  sda:<3>ata1: command 0x25 timeout, stat 0xd0 host_stat 0x64


If "acpi=off" does not fix this, please test the patch I posted recently
	[PATCH,RFT] SATA interrupt handling


