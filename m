Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbTGHLJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTGHLJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:09:24 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52701 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265889AbTGHLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:09:21 -0400
Date: Tue, 8 Jul 2003 13:23:56 +0200 (MEST)
Message-Id: <200307081123.h68BNuMw011203@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: hans.lambrechts@skynet.be, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre2 and pre3: compile error in aic7xxx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003 11:35:00 +0200, Hans Lambrechts wrote:
>I got following error, gcc is version 3.3.
>
>make -C aic7xxx modules
>make[3]: Entering directory `/usr/src/linux-2.4/drivers/scsi/aic7xxx'
>gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -I/usr/src/linux-2.4/drivers/scsi -Werror -nostdinc -iwithprefix include -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
>In file included from /usr/src/linux-2.4/include/linux/blk.h:4,
>                 from aic7xxx_osm.h:63,
>                 from aic7xxx_osm.c:122:
>/usr/src/linux-2.4/include/linux/blkdev.h: In function `blk_finished_sectors':
>/usr/src/linux-2.4/include/linux/blkdev.h:325: warning: comparison between signed and unsigned

aic7xxx's Makefile adds -Werror to CFLAGS ...
