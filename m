Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTBKQ2a>; Tue, 11 Feb 2003 11:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTBKQ2a>; Tue, 11 Feb 2003 11:28:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:4044 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261996AbTBKQ22>; Tue, 11 Feb 2003 11:28:28 -0500
Date: Tue, 11 Feb 2003 08:38:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 340] New: compile failure in drivers/media/video/saa5249.c
Message-ID: <92690000.1044981489@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=340

           Summary: compile failure in drivers/media/video/saa5249.c
    Kernel Version: 2.5.60-bk1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc2
Hardware Environment:  Abit KG7-RAID, AMD Athlon TBird 1.4, 512MB DDR,
Geforce 3 Software Environment:  gcc 3.2.1, glibc 2.3.1, ld 2.13.90.0.16
Problem Description:

  gcc -Wp,-MD,drivers/media/video/.saa5249.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=saa5249
-DKBUILD_MODNAME=saa5249 -c -o drivers/media/video/saa5249.o
drivers/media/video/saa5249.c
drivers/media/video/saa5249.c:257: warning: initialization from incompatible
pointer type
drivers/media/video/saa5249.c:258: warning: missing braces around
initializer drivers/media/video/saa5249.c:258: warning: (near
initialization for `i2c_driver_videotext.name')
drivers/media/video/saa5249.c:260: warning: initialization makes integer
from pointer without a cast
drivers/media/video/saa5249.c:260: initializer element is not computable at
load time
drivers/media/video/saa5249.c:260: (near initialization for
`i2c_driver_videotext.name[2]')
drivers/media/video/saa5249.c:261: warning: initialization makes integer
from pointer without a cast
drivers/media/video/saa5249.c:261: initializer element is not computable at
load time
drivers/media/video/saa5249.c:261: (near initialization for
`i2c_driver_videotext.name[3]')
drivers/media/video/saa5249.c:263: warning: initialization makes integer
from pointer without a cast
drivers/media/video/saa5249.c:263: initializer element is not computable at
load time
drivers/media/video/saa5249.c:263: (near initialization for
`i2c_driver_videotext.name[4]')
drivers/media/video/saa5249.c:263: initializer element is not constant
drivers/media/video/saa5249.c:263: (near initialization for
`i2c_driver_videotext.name')
make[3]: *** [drivers/media/video/saa5249.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Multimedia devices  --->
Video For Linux  --->
<*> SAA5249 Teletext processor

CONFIG_VIDEO_SAA5249=y


