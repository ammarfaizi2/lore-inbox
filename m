Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRCUPIl>; Wed, 21 Mar 2001 10:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131526AbRCUPIb>; Wed, 21 Mar 2001 10:08:31 -0500
Received: from cs.rice.edu ([128.42.1.30]:62392 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id <S131525AbRCUPIR>;
	Wed, 21 Mar 2001 10:08:17 -0500
From: Bradley Broom <broom@rice.edu>
To: linux-kernel@vger.kernel.org
Subject: Bug-report: SCSI related hang doing INQUIRY (DC390 card, 2.4.x kernels)
Date: Wed, 21 Mar 2001 08:44:48 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0103210907340D.13559@dustbin.cs.rice.edu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: My system freezes *completely* when doing an INQUIRY under 2.4.x
kernels. SCSI card is a Tekram DC390. Only inquiries to the DISK device cause a
hang, others succeed.

System details: AMD K63-400MHz, 128 Mb RAM, 1 IDE drive, 1 SCSI controller
(DC390) plus (output of cat /proc/scsi/scsi):
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST4.3S  Rev: 0F0C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1009
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: UMAX     Model: Astra 2200       Rev: V2.3
  Type:   Scanner                          ANSI SCSI revision: 02


Sending an INQUIRY to the first device in the above list causes
the system to hang. No error messages, no oops, nothing.
This occurs with both cdrecord -scanbus and find-scanner (from SANE).
Using find-scanner, I can send INQUIRIES to only the last three devices without
problems. Sending an INQUIRY to just the first will hang the system.

This occurs under 2.4.0-4G (from standard SUSE 7.1 installation) and 2.4.2, the
latter both with and without the SCSI subsystem compiled as modules. There are
no problems under 2.2.18.

Any help would be greatly appreciated. I'm not subscribed to the list, so
please explicitly email me any replies straw_broom@rice.edu (removing straw_
first).

Thanks,

Bradley Broom                              

