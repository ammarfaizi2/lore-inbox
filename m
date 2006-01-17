Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWAQUoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWAQUoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWAQUoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:44:23 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:56445 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932179AbWAQUoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:44:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eoaC+QaKC7v5a3lgte6xs8r7+XM/FP4nV+HPzcJuFQcPbmLTX5xpW7S8CsOipmrQZs0AvGL7zaxAQY4sn3HDFAcGqd5k50tSjqFQHfxUBfG+ESy0MiwPZH96rzhUehPkd24JLo/Pu+1bn8rw8j+Eu6NsQgYHbrI0My6GnXLGQTM=
Message-ID: <e0286e8f0601171244s1e49c0cfob01e4c7db4c006c4@mail.gmail.com>
Date: Tue, 17 Jan 2006 21:44:21 +0100
From: =?ISO-8859-1?Q?Jon_Arne_J=F8rgensen?= <jonjon.arnearne@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 libata/sata_sil: not detecting my SATA dvd-drive.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6.13.4, I'm able to acces my dvd-drive by changing these
lines in include/linux/libata.h

 #define ATA_ENABLE_ATAPI
 #define ATA_ENABLE_PATA
 #define ATAPI_ENABLE_DMADIR

 but after upgrading to 2.6.15, and using the libata.atapi_enabled=1
boot option, i can no longer access my dvd-drive.
 Instead i get this in my dmesg:

 sata_sil 0000:03:03.0: version 0.9
 ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 17
 ata3: SATA max UDMA/100 cmd 0xF8802080 ctl 0xF880208A bmdma 0xF8802000 irq 17
 ata4: SATA max UDMA/100 cmd 0xF88020C0 ctl 0xF88020CA bmdma 0xF8802008 irq 17
 ata3: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0007
 ata3: dev 0 ATAPI, max UDMA/33
 ata3: dev 0 configured for UDMA/33
 scsi2 : sata_sil
 ata4: no device found (phy stat 00000000)
 scsi3 : sata_sil
 ata3: command 0xa0 timeout, stat 0x78 host_stat 0x1
 ATA: abnormal status 0x78 on port 0xF8802087
 ATA: abnormal status 0x78 on port 0xF8802087
 ATA: abnormal status 0x78 on port 0xF8802087
 ATA: abnormal status 0x78 on port 0xF8802087
 ata3 is slow to respond, please be patient
 ata3 failed to respond (30 secs)
 ATA: abnormal status 0xF8 on port 0xF8802087
 ata3: translated ATA stat/err 0xf8/00 to SCSI SK/ASC/ASCQ 0xb/47/00

 I tried to google around, but with no luck.
 Can anyone here tell me what might be wrong or give me some clues
about where to look for answers?

 please CC me if you reply to the maillist.
 --
 Jonarne
