Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRHWWkf>; Thu, 23 Aug 2001 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270646AbRHWWk0>; Thu, 23 Aug 2001 18:40:26 -0400
Received: from mout0.freenet.de ([194.97.50.131]:6092 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S270645AbRHWWkT>;
	Thu, 23 Aug 2001 18:40:19 -0400
Message-ID: <3B8578E8.CFE4C64E@athlon.maya.org>
Date: Thu, 23 Aug 2001 23:43:04 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [Kernel 2.4.9] massive mount-problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm sorry, but this time I found a massive mount-problem with kernel
2.4.9. What have I done?

I tried to mount a cd-rw in my E-IDE cdrecorder with 'mount /cdburn'
(/dev/sr0 with scsi-emulations-modules). Unfortunately the cdrecorder
couldn't read the cd-rw. But mount-program hanged up and the kernel
flooded my messages-file with thousands of the following messages:

Aug 23 23:06:50 athlon kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Aug 23 23:06:50 athlon kernel: SCSI bus is being reset for host 0
channel 0.
Aug 23 23:06:51 athlon kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 10 00 00 01
00
Aug 23 23:06:51 athlon kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Aug 23 23:06:51 athlon kernel: SCSI bus is being reset for host 0
channel 0.
Aug 23 23:06:51 athlon kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 10 00 00 01
00
Aug 23 23:06:51 athlon kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Aug 23 23:06:51 athlon kernel: SCSI bus is being reset for host 0
channel 0.
Aug 23 23:06:52 athlon kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 10 00 00 01
00
[...]


I wasn't able to kill mount (even as root with sig 9). The only way to
stop it, was to reboot :-( .
I tried it with cdrecord -reset. Didn't help.
I tried it with cdrecord -scanbus. Didn't help.


BTW: I could fetch my cd from my cdrecorder though mount has been
hanging. The cdrecorder didn't lock.


Could you please fix this bug?


Regards,
Andreas Hartmann
