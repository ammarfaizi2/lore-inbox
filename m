Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264707AbSKFKRc>; Wed, 6 Nov 2002 05:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264747AbSKFKR3>; Wed, 6 Nov 2002 05:17:29 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:4342 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264707AbSKFKRY>; Wed, 6 Nov 2002 05:17:24 -0500
Date: Wed, 6 Nov 2002 21:23:40 +1100
From: Michael Still <mikal@stillhq.com>
To: <linux-kernel@vger.kernel.org>
Subject: Stradis compile failure with 2.5.46
Message-ID: <Pine.LNX.4.30.0211062121390.6609-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey all.

The stradis driver doesn't compile. I don't need it, and don't have time
to look into it, so I thought I would just report and move on. Hope this
isn't a duplicate, I couldn't find it already reported...

  gcc -Wp,-MD,drivers/media/video/.stradis.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include include/linux/mo
dversions.h   -DKBUILD_BASENAME=stradis   -c -o drivers/media/video/stradis.o drivers/media/video/stradis.c
drivers/media/video/stradis.c: In function `saa_open':
drivers/media/video/stradis.c:1949: structure has no member named `busy'
drivers/media/video/stradis.c: In function `saa_close':
drivers/media/video/stradis.c:1961: structure has no member named `busy'
drivers/media/video/stradis.c: At top level:
drivers/media/video/stradis.c:1974: unknown field `open' specified in initializer
drivers/media/video/stradis.c:1974: warning: initialization makes integer from pointer without a cast
drivers/media/video/stradis.c:1975: unknown field `close' specified in initializer
drivers/media/video/stradis.c:1975: warning: initialization from incompatible pointer type
drivers/media/video/stradis.c:1976: unknown field `read' specified in initializer
drivers/media/video/stradis.c:1977: unknown field `write' specified in initializer
drivers/media/video/stradis.c:1977: warning: initialization makes integer from pointer without a cast
drivers/media/video/stradis.c:1978: unknown field `ioctl' specified in initializer
drivers/media/video/stradis.c:1978: warning: missing braces around initializer
drivers/media/video/stradis.c:1978: warning: (near initialization for `saa_template.lock')
drivers/media/video/stradis.c:1978: warning: initialization makes integer from pointer without a cast
drivers/media/video/stradis.c:1979: unknown field `mmap' specified in initializer
drivers/media/video/stradis.c:1979: warning: initialization makes integer from pointer without a cast
drivers/media/video/stradis.c:245: warning: `detach_inform' defined but not used
make[3]: *** [drivers/media/video/stradis.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2
[root@localhost linux-2.5.46-build]#

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com)     UTC +11 hours

