Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbREFOad>; Sun, 6 May 2001 10:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135695AbREFOaY>; Sun, 6 May 2001 10:30:24 -0400
Received: from f-40-191.frankfurt.ipdial.viaginterkom.de ([62.180.191.40]:772
	"EHLO lara.leun.net") by vger.kernel.org with ESMTP
	id <S130900AbREFOaQ>; Sun, 6 May 2001 10:30:16 -0400
Message-ID: <XFMail.010506162918.ml@newton.leun.net>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sun, 06 May 2001 16:29:18 +0200 (CEST)
Organization: Not Organized
From: Michael Leun <ml@newton.leun.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: SCSI hangs with DVD-RAM 2.4.4 and 2.4.4-ac5, works with 2.2.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I try to write to my DVD-RAM (mke2fs or just dd if=/dev/zero of=/dev/sr0)
SCSI (and I guess the whole IO System) hangs after some time.

May  6 16:09:53 lara cardmgr[275]: initializing socket 0
May  6 16:09:53 lara cardmgr[275]: socket 0: Adaptec APA-1460 SlimSCSI
May  6 16:09:53 lara cardmgr[275]: executing: 'modprobe aha152x_cs'
May  6 16:09:53 lara kernel: SCSI subsystem driver Revision: 1.00
May  6 16:09:54 lara kernel: aha152x: processing commandline: ok
May  6 16:09:54 lara kernel: aha152x: BIOS test: passed, detected 1
controller(s)
May  6 16:09:54 lara kernel: aha152x: resetting bus...
May  6 16:09:54 lara kernel: aha152x0: vital data: rev=1, io=0x340
(0x340/0x340), irq=7, scsiid=7, reconnect=enabled, parity=enabled,
synchronous=disabled, delay=100, extended translation=disabled
May  6 16:09:54 lara kernel: aha152x0: trying software interrupt, ok.
May  6 16:09:55 lara kernel: scsi0 : Adaptec 152x SCSI driver; $Revision: 2.4 $
May  6 16:09:55 lara kernel:   Vendor: TOSHIBA   Model: SD-W1101 DVD-RAM  Rev:
1029
May  6 16:09:55 lara kernel:   Type:   CD-ROM                             ANSI
SCSI revision: 02
May  6 16:09:56 lara kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id
0, lun 0
May  6 16:09:56 lara kernel: sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2
cdda tray
May  6 16:09:56 lara kernel: VFS: Disk change detected on device sr(11,0)
May  6 16:09:56 lara cardmgr[275]: executing: './scsi start scd0'
[issued mke2fs -b 2048 /dev/scd0 here]
May  6 16:11:08 lara kernel: (scsi0:0:0) cannot abort running or disconnected
command
May  6 16:11:08 lara kernel: (scsi0:0:0) cannot reset current device
May  6 16:11:08 lara kernel: aha152x0: scsi reset in
May  6 16:11:13 lara kernel: SCSI cdrom error : host 0 channel 0 id 0 lun 0
return code = 8000000
May  6 16:11:13 lara kernel: [valid=0] Info fld=0x0, Deferred sd0b:00: sense
key Unit Attention
May  6 16:11:13 lara kernel: Additional sense indicates Power on,reset,or bus
device reset occurred
May  6 16:11:13 lara kernel:  I/O error: dev 0b:00, sector 65808


This happens with 2.4.3, 2.4.4, 2.4.4-ac5, but works with 2.2.19.

Any ideas?

If somebody needs more information or wants me to do some tests, please tell me.

Please CC me on replies.


-- 
MfG,


Michael Leun
