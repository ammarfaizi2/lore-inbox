Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264999AbSIQXLV>; Tue, 17 Sep 2002 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSIQXLV>; Tue, 17 Sep 2002 19:11:21 -0400
Received: from 217-13-8-30.dd.nextgentel.com ([217.13.8.30]:64517 "EHLO
	cluster-A.davidkarlsen.com") by vger.kernel.org with ESMTP
	id <S264999AbSIQXLU>; Tue, 17 Sep 2002 19:11:20 -0400
Message-ID: <3D87B7C2.40401@davidkarlsen.com>
Date: Wed, 18 Sep 2002 01:16:18 +0200
From: "David J. M. Karlsen" <david@davidkarlsen.com>
Organization: davidkarlsen.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: nb, no, nn, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sanatize kdev_t?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
lvm.c:381: unknown field `sizes' specified in initializer
lvm.c:381: warning: initialization from incompatible pointer type
lvm.c:382: unknown field `nr_real' specified in initializer
lvm.c:382: warning: initialization makes pointer from integer without a cast
lvm.c: In function `lvm_user_bmap':
lvm.c:1010: structure has no member named `bi_dev'
lvm.c:1011: structure has no member named `bi_dev'
lvm.c:1019: structure has no member named `bi_dev'
lvm.c:1019: structure has no member named `bi_dev'
lvm.c:1019: structure has no member named `bi_dev'
lvm.c:1019: structure has no member named `bi_dev'
lvm.c: In function `lvm_map':
lvm.c:1089: structure has no member named `bi_dev'
lvm.c:1213: structure has no member named `bi_dev'
lvm.c: In function `lvm_do_pe_lock_unlock':
lvm.c:1319: warning: implicit declaration of function `fsync_dev'
lvm.c: In function `__update_hardsectsize':
lvm.c:1787: warning: implicit declaration of function `get_hardsect_size'
lvm.c: In function `lvm_do_lv_remove':
lvm.c:2125: warning: implicit declaration of function `invalidate_buffers'
lvm.c: In function `lvm_geninit':
lvm.c:2658: `blksize_size' undeclared (first use in this function)
lvm.c:2658: (Each undeclared identifier is reported only once
lvm.c:2658: for each function it appears in.)
make[3]: *** [lvm.o] Error 1
make[3]: Leaving directory `/tmp/linux-2.5.35/drivers/md'
make[2]: *** [md] Error 2
make[2]: Leaving directory `/tmp/linux-2.5.35/drivers'
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/tmp/linux-2.5.35'
make: *** [stamp-build] Error 2

so - is sanatizing far away? whats changed - and why. I'd love to 
experiment a little with 2.5.x - but I really need the md and lvm stuff.


-- 
David J. M. Karlsen
http://www.davidkarlsen.com - http://mp3.davidkarlsen.com
+47 90 68 22 43


