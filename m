Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSIBMYo>; Mon, 2 Sep 2002 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSIBMYo>; Mon, 2 Sep 2002 08:24:44 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:3823 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S318211AbSIBMYn>;
	Mon, 2 Sep 2002 08:24:43 -0400
Date: Mon, 02 Sep 2002 14:23:10 +0200
From: CAMTP guest <camtp.guest@uni-mb.si>
Subject: aic7xxx sets CDR offline, how to reset?
To: linux-kernel@vger.kernel.org
Message-id: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.97 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.19, using AIC7XXX 6.2.8.
SCSI devices are 0:0:0 hard disk and 0:6:0 CDR.
During CD burning, errors sometimes occur and aic7xxx driver
sets the CDR offline. Is there a way to reset the device and
set it online again _without_rebooting_ ?

I tried different utilities from "scsitools" and "sg3-utils"
packages (also sg_reset) without any luck. Any suggestion?

Boot:

Aug 31 22:48:51 jerolim kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Aug 31 22:48:51 jerolim kernel:         <Adaptec aic7896/97 Ultra2 SCSI adapter>
Aug 31 22:48:51 jerolim kernel:         aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Aug 31 22:48:51 jerolim kernel:   Vendor: IBM       Model: DNES-309170W      Rev: SA30
Aug 31 22:48:51 jerolim kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Aug 31 22:48:51 jerolim kernel:   Vendor: SONY      Model: CD-R   CDU948S    Rev: 1.0j
Aug 31 22:48:51 jerolim kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 31 22:48:51 jerolim kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 8

SCSI abort, CDR offline:

Sep  2 11:26:26 jerolim kernel: DevQ(0:0:0): 0 waiting
Sep  2 11:26:26 jerolim kernel: DevQ(0:6:0): 0 waiting
Sep  2 11:26:26 jerolim kernel: (scsi0:A:6:0): Queuing a recovery SCB
Sep  2 11:26:26 jerolim kernel: scsi0:0:6:0: Device is disconnected, re-queuing SCB
Sep  2 11:26:26 jerolim kernel: Recovery code sleeping
Sep  2 11:26:26 jerolim kernel: (scsi0:A:6:0): Abort Message Sent
Sep  2 11:26:26 jerolim kernel: Recovery code awake
Sep  2 11:26:26 jerolim kernel: Timer Expired
Sep  2 11:26:26 jerolim kernel: aic7xxx_abort returns 0x2003
Sep  2 11:26:26 jerolim kernel: scsi0:0:6:0: Attempting to queue a TARGET RESET message
Sep  2 11:26:26 jerolim kernel: aic7xxx_dev_reset returns 0x2003
Sep  2 11:26:26 jerolim kernel: Recovery SCB completes
Sep  2 11:26:26 jerolim kernel: scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 6 lun 0
Sep  2 11:26:26 jerolim kernel: SCSI cdrom error : host 0 channel 0 id 6 lun 0 return code = 10000

-Igor Mozetic
