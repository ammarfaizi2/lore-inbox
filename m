Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKMVuE>; Wed, 13 Nov 2002 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKMVuE>; Wed, 13 Nov 2002 16:50:04 -0500
Received: from ngw.bvu.edu ([147.92.2.13]:8204 "EHLO ngw.bvu.edu")
	by vger.kernel.org with ESMTP id <S263899AbSKMVuD> convert rfc822-to-8bit;
	Wed, 13 Nov 2002 16:50:03 -0500
Message-Id: <sdd26bdb.016@ngw.bvu.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Wed, 13 Nov 2002 15:12:08 -0600
From: "Anthony Murray" <murrant@bvu.edu>
To: <alan@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [bug] i2o_lan modules fails to build in 2.5.47
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am hvaing trouble building the i2o_lan module for 2.5.47.  I have a 3com 905 net card and built support for it into the kernel. Here is the errors:

[...snip...]
make -f scripts/Makefile.build obj=drivers/message/i2o
  gcc -Wp,-MD,drivers/message/i2o/.i2o_lan.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=i2o_lan   -c -o drivers/message/i2o/i2o_lan.o drivers/message/i2o/i2o_lan.c
drivers/message/i2o/i2o_lan.c:28:2: #error Please convert me to Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_lan.c:120: parse error before "struct"
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_receive_post_reply':
drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared (first use in this function)
drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported only once
drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_register_device':
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
make[3]: *** [drivers/message/i2o/i2o_lan.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make: *** [drivers] Error 2

Thanks,
Tony Murray
