Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbSLKBRV>; Tue, 10 Dec 2002 20:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbSLKBRV>; Tue, 10 Dec 2002 20:17:21 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:31843 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S266940AbSLKBRS>; Tue, 10 Dec 2002 20:17:18 -0500
Date: Tue, 10 Dec 2002 20:24:47 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre1] compile failure on drivers/ide/legacy/hd.c
Message-ID: <Pine.LNX.4.50L0.0212102014270.32067-100000@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enabling "Use old disk-only driver on primary interface" option under IDE, 
ATA and ATAPI Block devices section sets CONFIG_BLK_DEV_HD_IDE=y and
CONFIG_BLK_DEV_HD=y causing compile to fail.

John Kim


make[4]: Entering directory `/usr/src/linux-2.4.21-pre1/drivers/ide/legacy'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre1/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict
-aliasing -fno-common -fomit-frame-pointer -pipe 
-mpreferred-stack-boundary=2 -march=athlon   -I../ -nostdinc
-iwithprefix include -DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c:78: conflicting types for `recal_intr'
/usr/src/linux-2.4.21-pre1/include/linux/ide.h:1487: previous declaration 
of `recal_intr'
hd.c: In function `dump_status':
hd.c:171: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:171: (Each undeclared identifier is reported only once
hd.c:171: for each function it appears in.)
hd.c:171: `CURRENT' undeclared (first use in this function)
hd.c: In function `hd_out':
hd.c:284: `DEVICE_INTR' undeclared (first use in this function)
hd.c:284: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `do_reset_hd':
hd.c:352: `DEVICE_INTR' undeclared (first use in this function)
hd.c: In function `unexpected_hd_interrupt':
hd.c:372: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `bad_rw_intr':
hd.c:385: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:387: `CURRENT' undeclared (first use in this function)
hd.c:389: warning: implicit declaration of function `end_request'
hd.c: In function `read_intr':
hd.c:427: `CURRENT' undeclared (first use in this function)
hd.c:441: `DEVICE_INTR' undeclared (first use in this function)
hd.c:441: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c:448: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c: In function `write_intr':
hd.c:464: `CURRENT' undeclared (first use in this function)
hd.c:479: `DEVICE_INTR' undeclared (first use in this function)
hd.c:479: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `hd_times_out':
hd.c:508: `DEVICE_INTR' undeclared (first use in this function)
hd.c:509: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:514: `CURRENT' undeclared (first use in this function)
hd.c: In function `hd_request':
hd.c:556: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:556: `CURRENT' undeclared (first use in this function)
hd.c:557: `DEVICE_INTR' undeclared (first use in this function)
hd.c:562: `INIT_REQUEST' undeclared (first use in this function)
hd.c: In function `hd_interrupt':
hd.c:712: `DEVICE_INTR' undeclared (first use in this function)
hd.c: In function `hd_init':
hd.c:850: `DEVICE_REQUEST' undeclared (first use in this function)
hd.c: At top level:
hd.c:620: warning: `do_hd_request' defined but not used
make[4]: *** [hd.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.21-pre1/drivers/ide/legacy'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.21-pre1/drivers/ide/legacy'
make[2]: *** [_subdir_legacy] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-pre1/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre1/drivers'
make: *** [_dir_drivers] Error 2
