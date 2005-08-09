Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVHIBma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHIBma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 21:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVHIBma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 21:42:30 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:19472 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932401AbVHIBm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 21:42:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gpyuIjJzeeJaL0mO0EdRJu8NVbQ4CSD/F6hom9lcRd6q5hYnHL0GMy+Gdx1bMmcrt4ldy7vQte7ZXfNzCX0q4GsUNhT9Vx+rvd3IThdecmpHtF3poItCKjNQ07kXj8qidWqZJaftYLTRzthOLuvdLoZiRWdGiLQppTSbpaeGOoE=
Message-ID: <3aa654a40508081842250b2be4@mail.gmail.com>
Date: Mon, 8 Aug 2005 18:42:28 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Shaun Jackman <sjackman@gmail.com>
Subject: Re: SATALink Sil3112 and Linux woes
Cc: debian-boot@lists.debian.org, debian-user@debian.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7f45d9390508081645c1afd1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390508081645c1afd1c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/05, Shaun Jackman <sjackman@gmail.com> wrote:
> setup. Is this card well supported under Linux? If it's a black sheep,
> could someone please recommend a PCI SATA card that works well?

I have onboard SATALink Sil3112 (on my Asus A7N8X) and it's worked
fine (libata and non).

> First off, every 2.6 kernel I've tried distributed with Debian and
> Knoppix stalls for about ten minutes immediately after booting and
> without displaying anything. After waiting the ten minutes, the boot

2.6 kernel works fine with my 2 160gb drives in a linear RAID,
although I'm not sure what the issue might be.

My dmesg:
Aug  8 16:01:21 rocket [4294675.305000] libata version 1.11 loaded.
Aug  8 16:01:21 rocket [4294675.305000] sata_sil version 0.9
Aug  8 16:01:21 rocket [4294675.306000] ACPI: PCI Interrupt Link
[APC3] enabled at IRQ 18
Aug  8 16:01:21 rocket [4294675.306000] ACPI: PCI Interrupt
0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) -> IRQ 19
Aug  8 16:01:21 rocket [4294675.306000] ata1: SATA max UDMA/100 cmd
0xF8804080 ctl 0xF880408A bmdma 0xF8804000 irq 19
Aug  8 16:01:21 rocket [4294675.306000] ata2: SATA max UDMA/100 cmd
0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008 irq 19
Aug  8 16:01:21 rocket [4294675.661000] ata1: dev 0 cfg 49:2f00
82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
Aug  8 16:01:21 rocket [4294675.661000] ata1: dev 0 ATA-7, max
UDMA/133, 320173056 sectors: LBA48
Aug  8 16:01:21 rocket [4294675.661000] ata1: dev 0 configured for UDMA/100
Aug  8 16:01:21 rocket [4294675.661000] scsi0 : sata_sil
Aug  8 16:01:21 rocket [4294676.016000] ata2: dev 0 cfg 49:2f00
82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
Aug  8 16:01:21 rocket [4294676.016000] ata2: dev 0 ATA-7, max
UDMA/133, 320173056 sectors: LBA48
Aug  8 16:01:21 rocket [4294676.016000] ata2: dev 0 configured for UDMA/100
Aug  8 16:01:21 rocket [4294676.016000] scsi1 : sata_sil
Aug  8 16:01:21 rocket [4294676.016000]   Vendor: ATA       Model:
Maxtor 6Y160M0    Rev: YAR5
Aug  8 16:01:21 rocket [4294676.016000]   Type:   Direct-Access       
              ANSI SCSI revision: 05
Aug  8 16:01:21 rocket [4294676.017000]   Vendor: ATA       Model:
Maxtor 6Y160M0    Rev: YAR5
Aug  8 16:01:21 rocket [4294676.017000]   Type:   Direct-Access       
              ANSI SCSI revision: 05
Aug  8 16:01:21 rocket [4294676.018000] SCSI device sda: 320173056
512-byte hdwr sectors (163929 MB)
Aug  8 16:01:21 rocket [4294676.018000] SCSI device sda: drive cache: write back
Aug  8 16:01:21 rocket [4294676.018000] SCSI device sda: 320173056
512-byte hdwr sectors (163929 MB)
Aug  8 16:01:21 rocket [4294676.018000] SCSI device sda: drive cache: write back
Aug  8 16:01:21 rocket [4294676.018000]  sda: sda1
Aug  8 16:01:21 rocket [4294676.041000] Attached scsi disk sda at
scsi0, channel 0, id 0, lun 0
Aug  8 16:01:21 rocket [4294676.041000] SCSI device sdb: 320173056
512-byte hdwr sectors (163929 MB)
Aug  8 16:01:21 rocket [4294676.041000] SCSI device sdb: drive cache: write back
Aug  8 16:01:21 rocket [4294676.041000] SCSI device sdb: 320173056
512-byte hdwr sectors (163929 MB)
Aug  8 16:01:21 rocket [4294676.041000] SCSI device sdb: drive cache: write back
Aug  8 16:01:21 rocket [4294676.041000]  sdb: sdb1
Aug  8 16:01:21 rocket [4294676.061000] Attached scsi disk sdb at
scsi1, channel 0, id 0, lun 0
Aug  8 16:01:21 rocket [4294676.061000] Attached scsi generic sg0 at
scsi0, channel 0, id 0, lun 0,  type 0
Aug  8 16:01:21 rocket [4294676.061000] Attached scsi generic sg1 at
scsi1, channel 0, id 0, lun 0,  type 0

avuton
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
