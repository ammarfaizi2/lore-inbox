Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUAUJdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 04:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAUJdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 04:33:16 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:50049 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S262745AbUAUJdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 04:33:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Strange IDE errors
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 21 Jan 2004 10:33:07 +0100
Message-ID: <yw1xn08hlk8c.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After 13 days uptime without a glitch, my Alpha SX164 running Linux
2.6.0 threw the errors below at me.  The disks are Seagate Barracuda
120 GB disks hooked up to a Highpoint hpt374 with SATA bridges.  The
hdi disk was recently replaced since the old disk would fail randomly
and mysteriously.  Is something in my machine destroying hdi?  Apart
from the lines about hdk below, there has been no trouble with the
other disks.  As usual, SMART doesn't tell me anything useful,
i.e. there are no errors logged and all attributes seem OK.  After a
reboot everything seems to work properly.  The question is for how
long.  Could the controller be faulty?

hdi: dma_intr: status=0x00 { }

hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: DMA disabled
hdi: drive not ready for command
ide4: reset: success
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
ide4: reset: success
hdi: status error: status=0x00 { }

hdi: no DRQ after issuing WRITE
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
ide4: reset: success
hdi: status error: status=0x00 { }

hdi: no DRQ after issuing WRITE
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
ide4: reset: success
hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdi: drive not ready for command
hdi: status error: status=0xd0 { Busy }

hdi: drive not ready for command
ide4: reset: master: error (0x00?)
hdk: dma_timer_expiry: dma status == 0x00
hdk: DMA timeout retry
hdk: timeout waiting for DMA
hdk: status timeout: status=0xd0 { Busy }

hdk: drive not ready for command
ide5: reset: success
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
ide4: reset: success
hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdi: drive not ready for command
hdi: status error: status=0xd0 { Busy }

hdi: drive not ready for command
ide4: reset: success
hdi: lost interrupt
hdi: lost interrupt
hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdi: drive not ready for command
hdi: status error: status=0xd0 { Busy }

hdi: drive not ready for command
ide4: reset: master: error (0x00?)
hdi: lost interrupt
hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdi: drive not ready for command
hdi: status error: status=0xd0 { Busy }

hdi: drive not ready for command
ide4: reset: master: error (0x00?)
end_request: I/O error, dev hdi, sector 11297617
raid1: Disk failure on md3, disabling device. 
        Operation continuing on 1 devices
raid1: md3: rescheduling sector 22049024
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md2
 disk 1, wo:1, o:0, dev:md3
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md2
raid1: md2: redirecting sector 22049024 to another mirror
end_request: I/O error, dev hdi, sector 226111
raid1: Disk failure on md1, disabling device. 
        Operation continuing on 1 devices
raid1: md1: rescheduling sector 452096
end_request: I/O error, dev hdi, sector 226127
raid1: md1: rescheduling sector 452112
end_request: I/O error, dev hdi, sector 226143
raid1: md1: rescheduling sector 452128
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
 disk 1, wo:1, o:0, dev:md1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
raid1: md0: redirecting sector 452096 to another mirror
raid1: md0: redirecting sector 452112 to another mirror
raid1: md0: redirecting sector 452128 to another mirror


-- 
Måns Rullgård
mru@kth.se
