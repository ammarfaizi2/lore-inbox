Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266649AbTGFJVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 05:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbTGFJVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 05:21:15 -0400
Received: from gallantin.skynet.be ([195.238.2.124]:50349 "EHLO
	gallantin.skynet.be") by vger.kernel.org with ESMTP id S266649AbTGFJVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 05:21:13 -0400
From: Hans Lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre2 and pre3: compile error in aic7xxx
Date: Sun, 6 Jul 2003 11:35:00 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061135.00924.hans.lambrechts@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
I got following error, gcc is version 3.3.

make -C aic7xxx modules
make[3]: Entering directory `/usr/src/linux-2.4/drivers/scsi/aic7xxx'
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -I/usr/src/linux-2.4/drivers/scsi -Werror -nostdinc -iwithprefix include -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
In file included from /usr/src/linux-2.4/include/linux/blk.h:4,
                 from aic7xxx_osm.h:63,
                 from aic7xxx_osm.c:122:
/usr/src/linux-2.4/include/linux/blkdev.h: In function `blk_finished_sectors':
/usr/src/linux-2.4/include/linux/blkdev.h:325: warning: comparison between signed and unsigned
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
aic7xxx_osm.c: At top level:
/usr/src/linux-2.4/include/linux/module.h:299: warning: `__module_kernel_version' defined but not used
aic7xxx_osm.c:451: warning: `__module_license' defined but not used
make[3]: *** [aic7xxx_osm.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4/drivers'
make: *** [_mod_drivers] Error 2
