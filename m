Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRAPLs1>; Tue, 16 Jan 2001 06:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbRAPLsR>; Tue, 16 Jan 2001 06:48:17 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:11525 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130645AbRAPLsH>;
	Tue, 16 Jan 2001 06:48:07 -0500
Date: Tue, 16 Jan 2001 12:47:52 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 2.4.0+aic7xxx doesn't boot, 2.2.17 OK
To: linux-kernel@vger.kernel.org
Reply-to: igor.mozetic@uni-mb.si
Message-id: <14948.13544.776999.735127@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.89 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intel C440GX+ with on-board Adaptec AIC-7896 fails to boot 2.4.0:

SCSI bus is being reset for host 0 channel 0
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
... ad infinitum ...

In contrast, this is what I get from the 2.2.17 boot:

(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 3 hosts.
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 31.
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SONY      Model: CD-R   CDU948S    Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
  Vendor:           Model: ATAPI CDROM       Rev: 120N
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0
scsi : detected 3 SCSI generics 2 SCSI cdroms 1 SCSI disk total.

Any quick hint what to try?

-Igor Mozetic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
