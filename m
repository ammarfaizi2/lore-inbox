Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129838AbQKFR2z>; Mon, 6 Nov 2000 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129915AbQKFR2p>; Mon, 6 Nov 2000 12:28:45 -0500
Received: from d14144.dtk.chello.nl ([213.46.14.144]:11910 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129838AbQKFR23>;
	Mon, 6 Nov 2000 12:28:29 -0500
Message-Id: <m13sq4H-000OY7C@amadeus.home.nl>
Date: Mon, 6 Nov 2000 18:28:25 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: rob@sysgo.de
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved reference to hd_init (2.4.0-test10, ll_rw_blk.c)
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <00110618154301.11022@rob>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <00110618154301.11022@rob> you wrote:
> Hi,

> I just ran into a small problem trying to build the 2.4.0-test10 kernel with
> only the "Old hard disk (MFM/RLL/IDE) driver" enabled. The following patch
> fixed this for me, (though I'm not sure I haven't broken anything else with it).

The real patch would be:

diff -ur /mnt/raid/1/linux-2.4.0-test10pre6/drivers/ide/Makefile linux/drivers/ide/Makefile
--- /mnt/raid/1/linux-2.4.0-test10pre6/drivers/ide/Makefile	Sun Oct 29 14:14:29 2000
+++ linux/drivers/ide/Makefile	Sat Oct 28 12:00:44 2000
@@ -31,7 +31,7 @@
 ide-obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
 ide-obj-$(CONFIG_BLK_DEV_GAYLE)		+= gayle.o
 ide-obj-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
-ide-obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
+obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
 ide-obj-$(CONFIG_BLK_DEV_HPT34X)	+= hpt34x.o
 ide-obj-$(CONFIG_BLK_DEV_HPT366)	+= hpt366.o
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o


Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
