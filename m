Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316828AbSEVCFA>; Tue, 21 May 2002 22:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316829AbSEVCE7>; Tue, 21 May 2002 22:04:59 -0400
Received: from tomts21.bellnexxia.net ([209.226.175.183]:3829 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316828AbSEVCEz>; Tue, 21 May 2002 22:04:55 -0400
Subject: Problematic CD-RW device (2.4.18, 2.4.19-pre8-ac5, maybe others)
From: Nicolas Laplante <nicolas.laplante@sympatico.ca>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 May 2002 22:04:53 -0400
Message-Id: <1022033093.1016.10.camel@madtux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lately I upgraded my CD writer (a generic 6x4x32x) to a LiteOn
LTR-32123S 32x12x40x.

When I booted into the 2.4.18 kernel, which was configured with ide-scsi
and its prerequisites, I got some strange error during the IDE
autodetection stage:

...
hda: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
hdc: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error
}
hdc: set_drive_speed_status: error=0x04
ide1: Drive 0 didn't accept speed setting. Oh, well.
...
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LG        Model: CD-ROM CRD-8522B  Rev: 2.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi : aborting command due to timeout : pid 1, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
hdc: drive not ready for command
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 1,
lun 
0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 52x/52x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
...

The old cd-writer was working without any problems and was loaded as
/dev/sr1.

Recently I tried 2.4.19-pre8-ac5 and enabled ATA Works in Progress and
enabled CONFIG_IDEDMA_NEWDRIVE_LISTINGS.

The result: I get fewer of these errors, and the writer is loaded
succesfully as /dev/sr1. Those messages still annoy me and I want to
know if this device is known to be problematic and it not, is there a
way to erradicate those messages at boot time?


Thanks for your help/support.

Later,
Nicolas

