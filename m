Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTK3JTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTK3JTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:19:18 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:49628 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S263137AbTK3JTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:19:10 -0500
Date: Sun, 30 Nov 2003 10:19:07 +0100 (MET)
From: Sebastiaan <S.Breedveld@ewi.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: PowerMac floppy (SWIM-3) doesn't compile
Message-ID: <Pine.GHP.4.44.0311301013160.3052-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to build the 2.6.0-test11 kernel for my PowerMac 7300/166, but
the floppy controller doesn't want to compile. I have:

CONFIG_MAC_FLOPPY=y

After a while 'make all' fails with:

  CC      drivers/block/swim3.o
drivers/block/swim3.c:224: parse error before `*'
drivers/block/swim3.c:224: warning: function declaration isn't a prototype
drivers/block/swim3.c:292: parse error before `*'
drivers/block/swim3.c:293: warning: function declaration isn't a prototype
drivers/block/swim3.c: In function `do_fd_request':
drivers/block/swim3.c:302: warning: implicit declaration of function `sti'
drivers/block/swim3.c: In function `start_request':
drivers/block/swim3.c:315: warning: implicit declaration of function `elv_next_request'
drivers/block/swim3.c:315: warning: assignment makes pointer from integer without a cast
drivers/block/swim3.c:324: dereferencing pointer to incomplete type
drivers/block/swim3.c:324: dereferencing pointer to incomplete type
drivers/block/swim3.c:325: warning: implicit declaration of function `end_request'
drivers/block/swim3.c:328: dereferencing pointer to incomplete type
drivers/block/swim3.c:337: warning: implicit declaration of function `rq_data_dir'
drivers/block/swim3.c:346: dereferencing pointer to incomplete type
drivers/block/swim3.c:347: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `set_timeout':
drivers/block/swim3.c:363: warning: implicit declaration of function `save_flags'
drivers/block/swim3.c:363: warning: implicit declaration of function `cli'
drivers/block/swim3.c:371: warning: implicit declaration of function `restore_flags'
drivers/block/swim3.c: In function `setup_transfer':
drivers/block/swim3.c:422: dereferencing pointer to incomplete type
drivers/block/swim3.c:430: dereferencing pointer to incomplete type
drivers/block/swim3.c:431: dereferencing pointer to incomplete type
drivers/block/swim3.c:443: dereferencing pointer to incomplete type
drivers/block/swim3.c:447: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `xfer_timeout':
drivers/block/swim3.c:598: dereferencing pointer to incomplete type
drivers/block/swim3.c:599: dereferencing pointer to incomplete type
drivers/block/swim3.c:601: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `swim3_interrupt':
drivers/block/swim3.c:623: warning: long unsigned int format, unsigned int arg (arg 3)
drivers/block/swim3.c:695: dereferencing pointer to incomplete type
drivers/block/swim3.c:696: dereferencing pointer to incomplete type
drivers/block/swim3.c:697: dereferencing pointer to incomplete type
drivers/block/swim3.c:706: dereferencing pointer to incomplete type
drivers/block/swim3.c:715: warning: long unsigned int format, unsigned int arg (arg 3)
drivers/block/swim3.c:721: dereferencing pointer to incomplete type
drivers/block/swim3.c:722: dereferencing pointer to incomplete type
drivers/block/swim3.c:723: dereferencing pointer to incomplete type
drivers/block/swim3.c:724: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `floppy_ioctl':
drivers/block/swim3.c:817: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `floppy_open':
drivers/block/swim3.c:843: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `floppy_release':
drivers/block/swim3.c:909: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `floppy_check_change':
drivers/block/swim3.c:920: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `floppy_revalidate':
drivers/block/swim3.c:926: dereferencing pointer to incomplete type
drivers/block/swim3.c: In function `swim3_init':
drivers/block/swim3.c:999: warning: implicit declaration of function `alloc_disk'
drivers/block/swim3.c:999: warning: assignment makes pointer from integer without a cast
drivers/block/swim3.c:1004: `FLOPPY_MAJOR' undeclared (first use in this function)
drivers/block/swim3.c:1004: (Each undeclared identifier is reported only once
drivers/block/swim3.c:1004: for each function it appears in.)
drivers/block/swim3.c:1009: warning: implicit declaration of function `blk_init_queue'
drivers/block/swim3.c:1009: warning: assignment makes pointer from integer without a cast
drivers/block/swim3.c:1017: dereferencing pointer to incomplete type
drivers/block/swim3.c:1018: dereferencing pointer to incomplete type
drivers/block/swim3.c:1019: dereferencing pointer to incomplete type
drivers/block/swim3.c:1020: dereferencing pointer to incomplete type
drivers/block/swim3.c:1021: dereferencing pointer to incomplete type
drivers/block/swim3.c:1022: dereferencing pointer to incomplete type
drivers/block/swim3.c:1023: dereferencing pointer to incomplete type
drivers/block/swim3.c:1024: warning: implicit declaration of function `set_capacity'
drivers/block/swim3.c:1025: warning: implicit declaration of function `add_disk'
drivers/block/swim3.c:1033: warning: implicit declaration of function `put_disk'
drivers/block/swim3.c: In function `swim3_add_device':
drivers/block/swim3.c:1084: warning: implicit declaration of function `request_irq'
drivers/block/swim3.c: At top level:
drivers/block/swim3.c:962: warning: `floppy_off' defined but not used
make[2]: *** [drivers/block/swim3.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


With my limiting knowledge about C and kernel sources I tried to locate
the error, but I haven't succeeded.

Setting CONFIG_MAC_FLOPPY=n will build the whole kernel.

Greetz,
Sebastiaan


--

English written by Dutch people is easily recognized by the improper use of 'In principle ...'

The software box said 'Requires Windows 95 or better', so I installed Linux.

Als Pacman in de jaren '80 de kinderen zo had be?nvloed zouden nu veel jongeren rondrennen
in donkere zalen terwijl ze pillen eten en luisteren naar monotone electronische muziek.
(Kristian Wilson, Nintendo, 1989)


