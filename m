Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290075AbSBKS5j>; Mon, 11 Feb 2002 13:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290080AbSBKS53>; Mon, 11 Feb 2002 13:57:29 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:46762 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S290075AbSBKS5Q>;
	Mon, 11 Feb 2002 13:57:16 -0500
Date: Mon, 11 Feb 2002 19:57:11 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
Message-ID: <20020211195710.A12859@fafner.intra.cogenit.fr>
In-Reply-To: <20020209205734.A17825@fafner.intra.cogenit.fr> <Pine.LNX.3.96.1020211131230.32755D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020211131230.32755D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Feb 11, 2002 at 01:16:57PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> :
[hdparm]
> NOTE: wrong options will hose your data! WHich is why I don't tell you
> what to use, just look at -m -c (I use 3), -d and -X34. Again, it may bite
> you, have backups.

The kernel did itself the job through the "autotune" option of ide.
/proc/ide/{hda/hdg}/settings differ only in:
@@ -11,7 +11,7 @@
 failures                0               0               65535           rw
 file_readahead          124             0               16384           rw
 ide_scsi                0               0               1               rw
-init_speed              69              0               69              rw
+init_speed              12              0               69              rw
 io_32bit                3               0               3               rw
 keepsettings            0               0               1               rw
 lun                     0               0               7               rw
@@ -20,7 +20,7 @@
 multcount               0               0               16              rw
 nice1                   1               0               1               rw
 nowerr                  0               0               1               rw
-number                  0               0               3               rw
+number                  2               0               3               rw
 pio_mode                write-only      0               255             w
 slow                    0               0               1               rw
 unmaskirq               1               0               1               rw

It can be fast: it does during raid rebuild.
May be the machine simply dislikes me.

-- 
Ueimor
