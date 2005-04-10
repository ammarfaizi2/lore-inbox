Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDJMMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDJMMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDJMMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:12:42 -0400
Received: from asia.telenet-ops.be ([195.130.132.59]:46259 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S261486AbVDJMMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:12:22 -0400
From: <joram.agten@pandora.be>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: kernel 2.4 pdc202xx and kernel 2.6 pdc202xx_old Broken
Date: Sun, 10 Apr 2005 14:12:03 +0200
Message-ID: <000701c53dc6$8246e3b0$0505a8c0@cheopsturbo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

please put me in CC

I'm using a pdc20262 promise utra66 controller to manage 4 HD's, all 30GB
and I put them in a software /dev/md/0 raid5 configuration

recently I upgraded my kernel to linux-2.6.11-gentoo-r4 and also
linux-2.6.11-gentoo-r5
and the raid array would go offline with dma timeouts when putting load to
it

Apr  9 23:30:15 vennen hde: DMA timeout error
Apr  9 23:30:15 vennen hde: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Apr  9 23:30:15 vennen 
Apr  9 23:30:15 vennen ide: failed opcode was: unknown
Apr  9 23:30:15 vennen hdh: dma_timer_expiry: dma status == 0x62
Apr  9 23:30:15 vennen hdh: DMA timeout error
Apr  9 23:30:15 vennen hdh: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Apr  9 23:30:15 vennen 
Apr  9 23:30:15 vennen ide: failed opcode was: unknown
Apr  9 23:30:15 vennen hdg: status timeout: status=0xd0 { Busy }
Apr  9 23:30:15 vennen 
Apr  9 23:30:15 vennen ide: failed opcode was: unknown
Apr  9 23:30:15 vennen hdg: DMA disabled
Apr  9 23:30:15 vennen PDC202XX: Secondary channel reset.
Apr  9 23:30:15 vennen PDC202XX: Primary channel reset.

in the beginning it was only with hde, so I suspected the disk, put it on
another controller, run a complete diskcheck on it (maxtor dos tool), no
problems found.
I attach it to the onboard motherboard controller and put it back in the
raid array
but again the raid array would fail, this time another disk.

If I boot again, and reinitialize the array, so that it starts building
again, it would fail quite fast
when not putting any load on the array it would just run fine

since I had installed the whole system from scratch I didn't know the exact
version of the previous kernel, so I went back to linux-2.4.20-gentoo-r33,
an here everything works
I also remember trying some more recent 2.4 kernel, but I do not recall the
exact version, there the same problem would manifest.

after some googling I found this thread: PDC202XX_OLD broken
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/1277.html

this is almost the exact same behaviour
but in the thread it does not say if his problem is solved or not
the suggestion of  Bartlomiej Zolnierkiewicz  is present in my 2.6 kernel
images

same info is at http://users.pandora.be/gemma.joram/pdc202xx/pdc202xx.html
I also have sysinfo
http://users.pandora.be/gemma.joram/pdc202xx/pdc202xx_sysinfo.html
and log http://users.pandora.be/gemma.joram/pdc202xx/pdc202xx_log.html

hope this is enough.
I'l happily try more if you need more info.

greetings
joram



