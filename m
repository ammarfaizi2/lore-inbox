Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTK0KYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTK0KYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:24:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:25527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264470AbTK0KYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:24:23 -0500
X-Authenticated: #1226656
Date: Thu, 27 Nov 2003 11:24:22 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test10: Badness in kobject_get at lib/kobject.c:439
Message-Id: <20031127112422.32757da3.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I get this on every boot, but all things seems to work:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:5): 19.230MB/s transfers (19.230MHz, offset 16)
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
Badness in kobject_get at lib/kobject.c:439
Call Trace:
 [<c01fa168>] kobject_get+0x4c/0x4e
 [<c0238eb4>] get_device+0x18/0x23
 [<c0269894>] scsi_device_get+0x39/0x9d
 [<c026999e>] __scsi_iterate_devices+0x3f/0x85
 [<c026d0c1>] scsi_run_host_queues+0x1b/0x45
 [<c0289b06>] ahc_linux_release_simq+0x9a/0xdf
 [<c0285e98>] ahc_linux_dv_thread+0x22a/0x2c2
 [<c010b1ae>] ret_from_fork+0x6/0x14
 [<c0285c6e>] ahc_linux_dv_thread+0x0/0x2c2
 [<c01092a5>] kernel_thread_helper+0x5/0xb

  Vendor: IBM       Model: DDYS-T18350N      Rev: SA2A
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SONY      Model: CD-RW  CRX140S    Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0

greets

Marc
