Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSKLIpf>; Tue, 12 Nov 2002 03:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSKLIpf>; Tue, 12 Nov 2002 03:45:35 -0500
Received: from pc175.host14.starman.ee ([62.65.206.175]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S266322AbSKLIpd>;
	Tue, 12 Nov 2002 03:45:33 -0500
Date: Tue, 12 Nov 2002 10:43:16 +0200
From: Priit Laes <amd@tt.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 & 2.5.47: Errors in drivers/video/aty128fb.c
Message-ID: <20021112084316.GB8703@amd-laptop.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens in both versions and when doing make modules and make
bzImage:
gcc -Wp,-MD,drivers/video/.fbgen.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefixinclude    -DKBUILD_BASENAME=fbgen -DEXPORT_SYMTAB  -c -o drivers/video/fbgen.o drivers/video/fbgen.c
gcc -Wp,-MD,drivers/video/.aty128fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefixinclude    -DKBUILD_BASENAME=aty128fb   -c -o drivers/video/aty128fb.o drivers/video/aty128fb.c
drivers/video/aty128fb.c:419: unknown field `fb_get_fix' specified in initializer
drivers/video/aty128fb.c:419: warning: initialization from incompatible pointer type
drivers/video/aty128fb.c:420: unknown field `fb_get_var' specified in initializer
drivers/video/aty128fb.c:420: warning: initialization from incompatible pointer type
drivers/video/aty128fb.c: In function `aty128fb_set_var':
drivers/video/aty128fb.c:1379: structure has no member named `visual'
drivers/video/aty128fb.c:1380: structure has no member named `type'
drivers/video/aty128fb.c:1381: structure has no member named `type_aux'
drivers/video/aty128fb.c:1382: structure has no member named `ypanstep'
drivers/video/aty128fb.c:1383: structure has no member named `ywrapstep'
drivers/video/aty128fb.c:1384: structure has no member named `line_length'
make[2]: *** [drivers/video/aty128fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
    
My configuration is following
# Frame-buffer support
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_FB_ATY128=y
when i tried to compile CONFIG_FB_ATY128 as module it also failed with same errors...
PS. This also happened in 2.5.46, but i didn't bother to report :(

