Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbRCPWlH>; Fri, 16 Mar 2001 17:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCPWks>; Fri, 16 Mar 2001 17:40:48 -0500
Received: from smtp6vepub.gte.net ([206.46.170.27]:29218 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S131402AbRCPWko>; Fri, 16 Mar 2001 17:40:44 -0500
Message-ID: <3AB29636.64C90827@neuronet.pitt.edu>
Date: Fri, 16 Mar 2001 17:39:50 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the first hunk to version 2.4.3-pre4, as by email with Doug.
The output for the scsi devices follows and is identical with and
without the patch. Maybe someone can explain the meaning of the illegal
requests at the end. Nevertheless, I can use the drive fine.

Loading module aic7xxx_old  ...
Using /lib/modules/2.4.3-pre4/kernel/drivers/scsi/aic7xxx_old.o
(scsi0) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/14/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 383 instructions downloaded
(scsi1) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/14/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 383 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: SEAGATE   Model: ST39173LW         Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi1:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST15150N          Rev: 4611
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 2, lun 0
(scsi1:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 4, lun 1
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr2 at scsi1, channel 0, id 4, lun 2
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr3 at scsi1, channel 0, id 4, lun 3
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr4 at scsi1, channel 0, id 4, lun 4
(scsi1:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: TEAC      Model: CD-R56S4          Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr5 at scsi1, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 16x/16x xa/form2 changer
sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
sr1: scsi3-mmc drive: 16x/16x xa/form2 changer
sr1: CDROM (ioctl) reports ILLEGAL REQUEST.
sr2: scsi3-mmc drive: 16x/16x xa/form2 changer
sr2: CDROM (ioctl) reports ILLEGAL REQUEST.
sr3: scsi3-mmc drive: 16x/16x xa/form2 changer
sr3: CDROM (ioctl) reports ILLEGAL REQUEST.
sr4: scsi3-mmc drive: 16x/16x xa/form2 changer
sr4: CDROM (ioctl) reports ILLEGAL REQUEST.
sr5: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
 sdb: sdb1

-- 
     Rafael
