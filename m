Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTIUMT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTIUMT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:19:56 -0400
Received: from mta03bw.bigpond.com ([144.135.24.147]:39110 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP id S262375AbTIUMTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:19:51 -0400
Date: Sun, 21 Sep 2003 22:17:51 +1000
From: Ben Peddell <killer.lightspeed@bigpond.com>
Subject: Re: Problem with PIO with ide-scsi in Kernel 2.4.22
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <3F6D96EF.90502@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
References: <fa.clonccb.r5kr2d@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Peddell wrote:
> I've had a problem with the ide-scsi (ATAPI SCSI emulation) module with 
> Linux 2.4.22.
> 
> When I disable DMA and read the CD-ROM, it reads a random amount up to 
> about 1MB, and then has a timeout.
> This never happened with linux-2.4.19-16mdk. I have even tried feeding 
> the old settings into the configurator, but without success.
> Here, I've set the log level to 9:
> 

I just had the problem again (didn't freeze the machine this time - I 
was in X).
I tried to list the contents of a CD-ROM, and the program was frozen, 
not accepting any signals. So, I hdparm'ed the CD-ROM drive, and found 
that DMA had been disabled.
So, I re-enabled DMA, but shortly thereafter, something disabled DMA again.
hdc: DMA disabled
I had to kill ls, and finally was able to re-enable DMA without it being 
disabled again.

cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
scsi : aborting command due to timeout : pid 119, scsi0, channel 0, id 
0, lun 0 Read TOC 00 00 00 00 00 00 00 0c 00
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
scsi : aborting command due to timeout : pid 120, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 120) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 120) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi : aborting command due to timeout : pid 121, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 121) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 121) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi : aborting command due to timeout : pid 122, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 122) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 122) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
sr0: CDROM (ioctl) error, command: Read TOC 00 00 00 00 00 00 00 0c 00
sr00:00: old sense key None
Non-extended sense class 0 code 0x0
scsi : aborting command due to timeout : pid 124, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi : aborting command due to timeout : pid 125, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 125) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 125) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0xb4
scsi : aborting command due to timeout : pid 126, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 126) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 126) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: lost interrupt
scsi : aborting command due to timeout : pid 129, scsi0, channel 0, id 
0, lun 0 Read TOC 00 00 00 00 00 00 00 0c 40
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0xb4
scsi : aborting command due to timeout : pid 130, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 130) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 130) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: lost interrupt
sr0: CDROM (ioctl) error, command: Read TOC 00 00 00 00 00 00 00 0c 40
sr00:00: old sense key None
Non-extended sense class 0 code 0x0
scsi : aborting command due to timeout : pid 134, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0xb4
scsi : aborting command due to timeout : pid 135, scsi0, channel 0, id 
0, lun 0 Request Sense 00 00 00 40 00
SCSI host 0 abort (pid 135) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 135) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: lost interrupt
sr0: CDROM (ioctl) error, command: Read TOC 00 00 00 00 00 00 00 0c 00
sr00:00: old sense key None
Non-extended sense class 0 code 0x0
scsi : aborting command due to timeout : pid 137, scsi0, channel 0, id 
0, lun 0 Read Capacity 00 00 00 00 00 00 00 00 00
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete

