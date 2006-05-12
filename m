Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWELXEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWELXEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWELXEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:04:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:51098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751182AbWELXEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:04:51 -0400
X-Authenticated: #20450766
Date: Sat, 13 May 2006 01:04:44 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Updated libata PATA patch
In-Reply-To: <1147196676.3172.133.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0605130059300.14238@poirot.grange>
References: <1147196676.3172.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Alan Cox wrote:

> - Re-enable per device speed setting
> - Fix VIA cable detect bug  (reporter: Mathieu Castet)
> - Fix AMD cable detect bug  (reporter: Sangoi Leonard)
> - Fix CS5535 build (reporter: Meelis Roos)
> - Trap 0 IRQ case
> - Fix IRQ allocation for pata_pcmcia (reporter: Kevin Radloff)
> 
> http://zeniv.linux.org.uk/~alan/IDE

Just a little thank-you  - just booted with your patch a ppc machine with 
a "IDE interface: Silicon Image, Inc. (formerly CMD Technology Inc) 
PCI0680 Ultra ATA-133 Host Controller (rev 02)" controller, kernel 
2.6.17-rc3, your patch patch-2.6.17-rc3-ide2. An extract from dmesg:

sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
ata1: PATA max UDMA/133 cmd 0xBFFEF8 ctl 0xBFFEF6 bmdma 0xBFFED0 irq 17
ata2: PATA max UDMA/133 cmd 0xBFFEE8 ctl 0xBFFEE6 bmdma 0xBFFED8 irq 17
ata1: dev 0 ATA-6, max UDMA/100, 40020624 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : pata_sil680
scsi1 : pata_sil680
  Vendor: ATA       Model: Maxtor 2B020H1    Rev: WAH2
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 40020624 512-byte hdwr sectors (20491 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 40020624 512-byte hdwr sectors (20491 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0

Will see how well it survives:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
