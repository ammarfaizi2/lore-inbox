Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbRGQX1E>; Tue, 17 Jul 2001 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267590AbRGQX0p>; Tue, 17 Jul 2001 19:26:45 -0400
Received: from mail.bartnet.net ([12.149.177.6]:30135 "EHLO mail.bartnet.net")
	by vger.kernel.org with ESMTP id <S267592AbRGQX0h>;
	Tue, 17 Jul 2001 19:26:37 -0400
From: "Jorg Pitts \(306170\)" <jorgp@bartnet.net>
To: "James Stevenson" <mistral@stev.org>
Cc: "Linux-Kernel-Owner" <linux-kernel@vger.kernel.org>
Subject: RE: serious cd writer kernel bug 2.4.x
Date: Tue, 17 Jul 2001 18:26:05 -0500
Message-ID: <GBEALFKJGAFHFMBNFHAEGEBFCLAA.jorgp@bartnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.30.0107172247200.1713-100000@cyrix.stev.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experience almost the exact same thing with my cd-rw.
PlexWriter 8/4/32A, does the same thing, and if I compile the modules
ide-scsi and scsi
directly into the kernel, whenever I access the cd-rw at all (try to mount a
valid filesystem) entire system locks and have to hard reboot.. I can access
the cd-rom just fine and both drives work fine in windows 2000 (I dual
boot). I am using stock Mandrake 8.0 with 2.4.6-ac2 kernel. I can run
cdrecord --scanbus and it sees the cd-rw fine
once I try to access the drive at all using mount or otherwise, it just
hangs. When using modules is just hangs the drive and cdrecord --scanbus
hangs when you run it, when compiling ide-scsi and scsi into the kernel, it
hard locks the machine.
Note that I am using AMD 1.3 w/ 512Meg ram with an MSI 6330-K7T PRO A (uses
VIA KT133 chipset) latest kernel I have tried is 2.4.6-ac2 did not help at
all. I also have DMA completely disabled in the BIOS, I seem to have read
that somewhere in LKML, so the drives are using PIO 4 mode, did not help at
all.

hda - disk 1
hdb - disk 2
hdc - cd-rom
hdd - cd-rw

what I have currently have in lilo.conf is
append hdd=ide-scsi in lilo.conf

not sure what to do now.. CD-RW is completely useless right now in linux, so
I just create my iso images and move them to windows to burn them.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of James Stevenson
Sent: Tuesday, July 17, 2001 5:52 PM
To: Linux Kernel
Subject: serious cd writer kernel bug 2.4.x



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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

