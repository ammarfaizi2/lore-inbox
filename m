Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbRGQXEl>; Tue, 17 Jul 2001 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbRGQXEV>; Tue, 17 Jul 2001 19:04:21 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:37627 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S267338AbRGQXEP>;
	Tue, 17 Jul 2001 19:04:15 -0400
Date: Tue, 17 Jul 2001 22:51:44 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: serious cd writer kernel bug 2.4.x
Message-ID: <Pine.LNX.4.30.0107172247200.1713-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

basically i am having serious problems with a cd writer since i moved to
2.4.x it works fine under 2.2.x though this seems to happen on access to
the writer at any time have not even tried to write to it yet.

if a program trys to access the device i get the logs below followed
by an opps (no opps output yet my serial logged is messing up)


Jul 17 22:31:04 beast kernel: scsi : aborting command due to timeout : pid
0, scsi0, channel 0, id 0, lun 0 0x1b 01 00 00 00 00
Jul 17 22:31:04 beast kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 17 22:31:04 beast kernel: hdc: DMA disabled
Jul 17 22:31:06 beast kernel: hdc: ATAPI reset complete
Jul 17 22:31:06 beast kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 17 22:31:10 beast kernel: hdc: ATAPI reset complete
Jul 17 22:31:10 beast kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 17 22:31:10 beast kernel: scsi0 channel 0 : resetting for second half
of retries.
Jul 17 22:31:10 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:11 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:11 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:12 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:12 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:13 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:13 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:14 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:14 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:15 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:15 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:17 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:17 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:19 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:19 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:20 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:20 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:21 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:21 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:22 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:22 beast kernel: SCSI bus is being reset for host 0 channel
0.
Jul 17 22:31:23 beast kernel: scsi0 : channel 0 target 0 lun 0 request
sense failed, performing reset.
Jul 17 22:31:23 beast kernel: SCSI bus is being reset for host 0 channel
0.


the devices are as follows the 44x drive works fine. the other one does
not.

hdc: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: CD-Writer+ 7200   Rev: 3.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ATAPI     Model: CD-ROM 44X        Rev: T4C2
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0

i will try to get the info on the opps but it most of it scolls off the
top of the screen. i have been able to reproduce this 100% so far
any help would be usefull.


thanks
	James

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
 10:30pm  up 26 min,  3 users,  load average: 0.15, 0.03, 0.06

