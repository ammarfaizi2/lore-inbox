Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWBTV0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWBTV0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBTV0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:26:48 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:5614 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1030190AbWBTV0r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:26:47 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Date: Mon, 20 Feb 2006 22:26:43 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1140445182.26526.1.camel@localhost.localdomain>
In-Reply-To: <1140445182.26526.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602202226.43772.biscani@pd.astro.it>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 15:19, Alan Cox wrote:
> Various fixes and cleanups, some new functionality notably Promise
> 20246/2026x support which although basic should get it going with disk.
> Not 100% sure about ATAPI on PDC2026x yet.
>
> http://zeniv.linux.org.uk/~alan/IDE

Got an Ali chipset  here, it booted fine.

Feb 20 22:06:17 kurtz Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 20 22:06:17 kurtz ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Feb 20 22:06:17 kurtz libata version 1.20 loaded.
Feb 20 22:06:17 kurtz ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
Feb 20 22:06:17 kurtz ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x2040 
irq 14
Feb 20 22:06:17 kurtz ata1: dev 0 cfg 49:0f00 82:746b 83:7fe8 84:4023 85:f469 
86:3e48 87:4023 88:203f
Feb 20 22:06:17 kurtz ata1: dev 0 ATA-6, max UDMA/100, 78140160 sectors: LBA48
Feb 20 22:06:17 kurtz ata1: dev 0 configured for UDMA/100
Feb 20 22:06:17 kurtz scsi0 : ali
Feb 20 22:06:17 kurtz Vendor: ATA       Model: IC25N040ATMR04-0  Rev: MO2O
Feb 20 22:06:17 kurtz Type:   Direct-Access                      ANSI SCSI 
revision: 05
Feb 20 22:06:17 kurtz ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2048 
irq 15
Feb 20 22:06:17 kurtz ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0000
Feb 20 22:06:17 kurtz ata2: dev 0 ATAPI, max MWDMA2
Feb 20 22:06:17 kurtz ata2: dev 0 configured for MWDMA2
Feb 20 22:06:17 kurtz scsi1 : ali
Feb 20 22:06:17 kurtz ata2(0): WARNING: ATAPI is disabled, device ignored.
Feb 20 22:06:17 kurtz SCSI device sda: 78140160 512-byte hdwr sectors (40008 
MB)
Feb 20 22:06:17 kurtz sda: Write Protect is off
Feb 20 22:06:17 kurtz sda: Mode Sense: 00 3a 00 00
Feb 20 22:06:17 kurtz SCSI device sda: drive cache: write back
Feb 20 22:06:17 kurtz SCSI device sda: 78140160 512-byte hdwr sectors (40008 
MB)
Feb 20 22:06:17 kurtz sda: Write Protect is off
Feb 20 22:06:17 kurtz sda: Mode Sense: 00 3a 00 00
Feb 20 22:06:17 kurtz SCSI device sda: drive cache: write back
Feb 20 22:06:17 kurtz sda: sda1 sda2 sda3 < sda5 sda6 > sda4
Feb 20 22:06:17 kurtz sd 0:0:0:0: Attached scsi disk sda

The CDROM on the second ide channel was not recognized (what's up with that 
WARNING?). And the HD was pretty slow (around 1-2 MB/s), I guess that's 
because UDMA support is not there yet?

Regards,

  Francesco


-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
