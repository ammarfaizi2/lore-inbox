Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRJVO1H>; Mon, 22 Oct 2001 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278830AbRJVO06>; Mon, 22 Oct 2001 10:26:58 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37640 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S278829AbRJVO0v>; Mon, 22 Oct 2001 10:26:51 -0400
Date: Mon, 22 Oct 2001 16:27:24 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: gibbs@scsiguy.com
Subject: Linux 2.4.12-ac3 aic7xxx woes?
Message-ID: <20011022162724.A6109@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	gibbs@scsiguy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup of Linux 2.4.12, I got these messages, and it pretty much
looks like a severely hosed state machine with recovery and synch
troubles. It also pretty much looks like the old dreadful aic7xxx 5.x.
and aha1542-cannot-recover-troubles are close.

Is there a driver bug or is the hardware a pile of dung?

The machine boots from the Seagate Disk (ext3fs) and has the IBM for
additional storage (reiserfs 3.6). It has never been suspicious in the
past.

Apart from the messages, the machine seems to behave:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: SEAGATE   Model: ST34572N          Rev: 0784
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-3801TA  Rev: 0207
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:0:0:0: Tagged Queuing enabled.  Depth 24
scsi0:0:1:0: Tagged Queuing enabled.  Depth 24
DC390: 0 adapters found
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W1610A  Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
SCSI device sda: 8888924 512-byte hdwr sectors (4551 MB)
Partition check:
 sda: sda1 < sda5 > sda2
(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
SCSI device sdb: 4226725 512-byte hdwr sectors (2164 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
...
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 120420k swap-space (priority -1)
Adding Swap: 128516k swap-space (priority -2)
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 16 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
...
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
EXT3 FS 2.4-0.9.12, 10 Oct 2001 on sd(8,2), internal journal
reiserfs: checking transaction log (device 08:14) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII#8 link partner capability of
01e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
...

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
