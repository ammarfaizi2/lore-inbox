Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSKFVmv>; Wed, 6 Nov 2002 16:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbSKFVmv>; Wed, 6 Nov 2002 16:42:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266120AbSKFVmu>;
	Wed, 6 Nov 2002 16:42:50 -0500
Message-Id: <200211062149.gA6LnMJ25728@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Yury Umanets <umka@namesys.com>
cc: Cliff White <cliffw@osdl.org>, reiserfs-dev@namesys.com,
       Linux-Kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: [reiserfs-dev] build failure: reiser4progs-0.1.0 
In-Reply-To: Message from Yury Umanets <umka@namesys.com> 
   of "Wed, 06 Nov 2002 22:58:07 +0300." <3DC9744F.4090702@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 13:49:22 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

./configure --without-readline --enable-Weror=no 
builds successfully
----------------------------
./configure --without-readline
-------------------------------
0.lo -MD -MP -MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
cc1: warnings being treated as errors
alloc40.c: In function `callback_fetch_bitmap':
alloc40.c:50: warning: signed and unsigned type in conditional expression
alloc40.c: In function `callback_flush_bitmap':
alloc40.c:209: warning: signed and unsigned type in conditional expression
alloc40.c: In function `callback_check_bitmap':
alloc40.c:376: warning: signed and unsigned type in conditional expression
make[3]: *** [alloc40.lo] Error 1
make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
oc40'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
make: *** [all] Error 2
---------------------------------
./configure  --enable-Werror=no
------------------------------------
st -f mkfs.c || echo './'`mkfs.c
/bin/sh ../../libtool --mode=link gcc  -g -O2 -D_REENTRANT 
-D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -DPLUGIN_DIR=\"/usr/local/lib/re
iser4\"   -o mkfs.reiser4  mkfs.o ../../libreiser4/libreiser4.la 
../../progs/libmisc/libmisc.la -lreadline  -luuid
mkdir .libs
gcc -g -O2 -D_REENTRANT -D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused 
-DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -o .libs/mkfs.reiser4 mkfs.o  
../../libreiser4/.libs/libreiser4.so ../../progs/libmisc/.libs/libmisc.al 
/root/cgl/kern/reiser/reiser4progs-0.1.0/libaal/.libs/libaal.so -lreadline 
-luuid -Wl,--rpath -Wl,/usr/local/lib
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `tgetnum'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `tgoto'/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadlin
e.so: undefined reference to `tgetflag'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `BC'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `tputs'/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadlin
e.so: undefined reference to `PC'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `tgetent'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `UP'
/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
reference to `tgetstr'
collect2: ld returned 1 exit status
make[3]: *** [mkfs.reiser4] Error 1
make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/progs/mkfs
'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/progs'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
make: *** [all] Error 2
----------------------------------------

