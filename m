Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWGJScE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWGJScE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWGJScD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:32:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:40548 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422749AbWGJScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:32:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cJnLOPLHmBo1lKc4R2u+vhxwfa7xmQKORYQ8+uvJ4kvP8OahR1wIQnEa9G8yDA3cLZt9yh0pwCusEgB4vkzypSw3sF4i4rCW5xj2oQbYpU/gU0DHslvGTgHEWZWNFd3z1/lLFFAaYpVoENJyieO7DyUkOcvo8r3Nz0LGpRSRCnc=
Message-ID: <b637ec0b0607101131r7c908a3dl6f90bd75cd64a4e2@mail.gmail.com>
Date: Mon, 10 Jul 2006 20:31:59 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc1-mm1: PATA detection weirdness
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Jeff Garzik" <jeff@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Using 2.6.17 with Alan PATA patches I get:

-------------------------------------------------------------------------------------------------------
Jul  9 10:30:11 tycho kernel: ata1: PATA max UDMA/133 cmd 0x1F0 ctl
0x3F6 bmdma 0x18C0 irq 14
Jul  9 10:30:11 tycho kernel: ata1: dev 0 ATA-6, max UDMA/100,
156301488 sectors: LBA
Jul  9 10:30:11 tycho kernel: ata1: dev 1 ATAPI, max MWDMA2
Jul  9 10:30:11 tycho kernel: ata1: dev 0 configured for UDMA/100
Jul  9 10:30:11 tycho kernel: ata1: dev 1 configured for MWDMA2
Jul  9 10:30:11 tycho kernel: scsi0 : ata_piix
Jul  9 10:30:11 tycho kernel:   Vendor: ATA       Model: TOSHIBA
MK8025GA  Rev: KA02
Jul  9 10:30:11 tycho kernel:   Type:   Direct-Access
    ANSI SCSI revision: 05
Jul  9 10:30:11 tycho kernel:   Vendor: TSSTcorp  Model: CD/DVDW
TS-L532M  Rev: HR08
Jul  9 10:30:11 tycho kernel:   Type:   CD-ROM
    ANSI SCSI revision: 05
Jul  9 10:30:11 tycho kernel: ata2: PATA max UDMA/133 cmd 0x170 ctl
0x376 bmdma 0x18C8 irq 15
Jul  9 10:30:11 tycho kernel: ata2: port disabled. ignoring.
Jul  9 10:30:11 tycho kernel: scsi1 : ata_piix
Jul  9 10:30:11 tycho kernel: SCSI device sda: 156301488 512-byte hdwr
sectors (80026 MB)
Jul  9 10:30:11 tycho kernel: sda: Write Protect is off
Jul  9 10:30:11 tycho kernel: SCSI device sda: drive cache: write back
Jul  9 10:30:11 tycho kernel: SCSI device sda: 156301488 512-byte hdwr
sectors (80026 MB)
Jul  9 10:30:11 tycho kernel: sda: Write Protect is off
Jul  9 10:30:11 tycho kernel: SCSI device sda: drive cache: write back
Jul  9 10:30:11 tycho kernel:  sda: sda1 sda2 sda3 sda4
Jul  9 10:30:11 tycho kernel: sd 0:0:0:0: Attached scsi disk sda
Jul  9 10:30:11 tycho kernel: sr0: scsi3-mmc drive: 24x/24x writer
cd/rw xa/form2 cdda tray
Jul  9 10:30:11 tycho kernel: Uniform CD-ROM driver Revision: 3.20
----------------------------------------------------------------------------------------------------

With 2.6.18-rc1-mm1 I get:

--------------------------------------------------------------------------------------------------
Jul 10 20:20:02 tycho kernel: ata1: PATA max UDMA/100 cmd 0x1F0 ctl
0x3F6 bmdma 0x18C0 irq 14
Jul 10 20:20:02 tycho kernel: scsi0 : ata_piix
Jul 10 20:20:02 tycho kernel: ata1.00: ATA-6, max UDMA/100, 156301488
sectors: LBA
Jul 10 20:20:02 tycho kernel: ata1.00: ata1: dev 0 multi count 16
Jul 10 20:20:02 tycho kernel: ata1.01: ATAPI, max MWDMA2
Jul 10 20:20:02 tycho kernel: ata1.00: configured for UDMA/33
Jul 10 20:20:02 tycho kernel: ata1.01: configured for MWDMA2
Jul 10 20:20:02 tycho kernel:   Vendor: ATA       Model: TOSHIBA
MK8025GA  Rev: KA02
Jul 10 20:20:02 tycho kernel:   Type:   Direct-Access
    ANSI SCSI revision: 05
Jul 10 20:20:02 tycho kernel:   Vendor: TSSTcorp  Model: CD/DVDW
TS-L532M  Rev: HR08
Jul 10 20:20:02 tycho kernel:   Type:   CD-ROM
    ANSI SCSI revision: 05
Jul 10 20:20:02 tycho kernel: ata2: PATA max UDMA/100 cmd 0x170 ctl
0x376 bmdma 0x18C8 irq 15
Jul 10 20:20:02 tycho kernel: scsi1 : ata_piix
Jul 10 20:20:02 tycho kernel: ata2: port disabled. ignoring.
Jul 10 20:20:02 tycho kernel: ATA: abnormal status 0xFF on port 0x177
Jul 10 20:20:02 tycho kernel: SCSI device sda: 156301488 512-byte hdwr
sectors (80026 MB)
Jul 10 20:20:02 tycho kernel: sda: Write Protect is off
Jul 10 20:20:02 tycho kernel: SCSI device sda: drive cache: write back
Jul 10 20:20:02 tycho kernel: SCSI device sda: 156301488 512-byte hdwr
sectors (80026 MB)
Jul 10 20:20:02 tycho kernel: sda: Write Protect is off
Jul 10 20:20:02 tycho kernel: SCSI device sda: drive cache: write back
Jul 10 20:20:02 tycho kernel:  sda: sda1 sda2 sda3 sda4
Jul 10 20:20:02 tycho kernel: sd 0:0:0:0: Attached scsi disk sda
Jul 10 20:20:02 tycho kernel: sr0: scsi3-mmc drive: 24x/24x writer
cd/rw xa/form2 cdda tray
Jul 10 20:20:02 tycho kernel: Uniform CD-ROM driver Revision: 3.20
-------------------------------------------------------------------------------------------------

However, it seems to be only an "aestethic" issue as there is no
performance regression.

Regards,
Fabio
