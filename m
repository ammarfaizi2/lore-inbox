Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTH1NQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTH1NQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:16:21 -0400
Received: from bellini.kjist.ac.kr ([203.237.42.6]:14604 "EHLO
	bellini.kjist.ac.kr") by vger.kernel.org with ESMTP id S264026AbTH1NQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:16:19 -0400
From: ghugh Song <ghugh@kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx_osm.c compilation failure in linux-2.4.22
Message-Id: <20030828131615.A83F17497B@bellini.kjist.ac.kr>
Date: Thu, 28 Aug 2003 22:16:15 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile failure as follows:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=pentium4
-I/usr/src/linux-2.4.22/drivers/scsi -Werror -nostdinc -iwithprefix include
-DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
In file included from /usr/src/linux-2.4.22/include/linux/blk.h:4,
                 from aic7xxx_osm.h:63,
                 from aic7xxx_osm.c:122:
/usr/src/linux-2.4.22/include/linux/blkdev.h: In function `blk_queue_bounce':
/usr/src/linux-2.4.22/include/linux/blkdev.h:194: warning: comparison between
signed and unsigned
/usr/src/linux-2.4.22/include/linux/blkdev.h: In function
`blk_finished_sectors':
/usr/src/linux-2.4.22/include/linux/blkdev.h:335: warning: comparison between
signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_setup_tag_info_global':
aic7xxx_osm.c:1610: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_setup_tag_info':
aic7xxx_osm.c:1622: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_setup_dv':
aic7xxx_osm.c:1635: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `aic7xxx_setup':
aic7xxx_osm.c:1687: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_platform_abort_scbs':
aic7xxx_osm.c:2164: warning: comparison between signed and unsigned
aic7xxx_osm.c:2171: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_user_tagdepth':
aic7xxx_osm.c:3556: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_user_dv_setting':
aic7xxx_osm.c:3585: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_send_async':
aic7xxx_osm.c:4088: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_done':
aic7xxx_osm.c:4209: warning: comparison between signed and unsigned
aic7xxx_osm.c: In function `ahc_linux_handle_scsi_status':
aic7xxx_osm.c:4334: warning: comparison between signed and unsigned
make[4]: *** [aic7xxx_osm.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22/drivers'
make: *** [_dir_drivers] Error 2


=======================================================


However, I can't find the actual error message.  Strange.


I have an off-topic question:

What happened to sym-53c8xxx driver?  It appears that nobody is
actively maintaining it.  Yet, there is not much complain traffic over 
any malfunction for this LSI's SCSI card driver.  Does it mean
that the latter is much more stable than aic7xxx driver for 
Adaptec cards?

Regards,

Hugh
