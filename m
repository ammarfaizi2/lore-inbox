Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131839AbRAAODz>; Mon, 1 Jan 2001 09:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbRAAODp>; Mon, 1 Jan 2001 09:03:45 -0500
Received: from oracle.clara.net ([195.8.69.94]:22281 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S131751AbRAAODk>;
	Mon, 1 Jan 2001 09:03:40 -0500
Date: Mon, 1 Jan 2001 13:30:08 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prerel-ac1: Looking good on Alpha
Message-ID: <Pine.LNX.4.10.10101011317180.898-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  2.4.0-prerelease with the Alan Cox new-year-special ac1 patches is
looking good for me on Alpha (LX164).

  My standard build went just fine; so I decided to push it; I've built in
IPv6, a load of USB stuff, SCSI stuff, and a load of other stuff; loaded
them all as modules, all loaded OK and unloaded OK - haven't actually
stressed any of it.

Just two (1 and a half?) problems:

   1) When doing make modules_install:

depmod: *** Unresolved symbols in
/lib/modules/2.4.0-prerelease-ac1/kernel/drivers/usb/storage/usb-storage.o
depmod:   init_task_union

   2) When I tried to play an audio CD this morning I got:

Jan  1 12:55:48 tardis kernel: hdb: irq timeout: status=0xd0 { Busy }
Jan  1 12:55:54 tardis kernel: hdb: ATAPI reset complete
Jan  1 12:56:04 tardis kernel: hdb: irq timeout: status=0xc0 { Busy }
Jan  1 12:56:10 tardis kernel: hdb: ATAPI reset complete
Jan  1 12:56:20 tardis kernel: hdb: irq timeout: status=0xc0 { Busy }
Jan  1 12:56:20 tardis kernel: end_request: I/O error, dev 03:40 (hdb),
sector 0
Jan  1 12:56:20 tardis kernel: hdb: status timeout: status=0xc0 { Busy }
Jan  1 12:56:20 tardis kernel: hdb: drive not ready for command
Jan  1 12:56:27 tardis kernel: hdb: ATAPI reset complete

Ejected the CD, put it back in and its fine, so I actually suspect the
drive was just having a bad day but its best just to list there was the
problem. (This on a CMD646 on the motherboard).

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
