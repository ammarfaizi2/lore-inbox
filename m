Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRDENVB>; Thu, 5 Apr 2001 09:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132896AbRDENUr>; Thu, 5 Apr 2001 09:20:47 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:26638 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132895AbRDENUT>;
	Thu, 5 Apr 2001 09:20:19 -0400
Date: Thu, 05 Apr 2001 15:19:28 +0200
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 2.4.3 + aic7xxx-6.1.9 doesn't boot
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Message-id: <15052.28896.299341.145765@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.90 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest aic7xxx-6.1.9 doesn't boot, I can see something like:

scsi1:0:0:0: Attempting to queue an ABORT message 
scsi1:0:0:0: Command found on device queue 
aic7xxx_abort returns 8194 

2.4.3 + aic7xxx-6.1.8 works fine (ignoring problems with
renaming devices and not beeing able to read from CD RW).
C440GX+ UP, 2G RAM, working dmesg shows:
  
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor:           Model: ATAPI CDROM       Rev: 120N
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 116x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.8
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.8
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Wide Channel B, SCSI Id=7, 32/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
  Vendor: SONY      Model: CD-R   CDU948S    Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 6, lun 0
scsi1:0:0:0: Tagged Queuing enabled.  Depth 8
(scsi1:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
sr1: scsi-1 drive
(scsi1:A:0): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)

-Igor Mozetic
