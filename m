Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWB1Wco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWB1Wco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWB1Wco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:32:44 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32972 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S932567AbWB1Wcn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:32:43 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch for 2.6.16-rc5
Date: Tue, 28 Feb 2006 23:32:22 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1141054370.3089.0.camel@localhost.localdomain>
In-Reply-To: <1141054370.3089.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602282332.22672.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:32, Alan Cox wrote:
> This is at
> 	http://zeniv.linux.org.uk/~alan/IDE
>
> Some more fixes, and the ALi driver should now work although I've yet to
> finish the MWDMA work or finish chasing down the slow performance.
>

Hello Alan,

  on ALi here devices are now recognized successfully. Some excerpts from the 
logs:

libata version 1.20 loaded.
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x2040 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7fe8 84:4023 85:f469 86:3e48 87:4023 
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 78140160 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ali
  Vendor: ATA       Model: IC25N040ATMR04-0  Rev: MO2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2048 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata2: dev 0 ATAPI, max MWDMA2
ata2: dev 0 configured for PIO4
scsi1 : ali
  Vendor: HL-DT-ST  Model: RW/DVD GCC-4241N  Rev: 0C29
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0

The improvement from the previous patch is that the cdrom is seen as "sr0" now 
(instead of "sdb") and the bogus warnings have disappeared. Performances are 
still low, as expected. Please tell me if I can do something else.

Thanks and regards,

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
