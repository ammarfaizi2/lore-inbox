Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJLXFN>; Sat, 12 Oct 2002 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSJLXFN>; Sat, 12 Oct 2002 19:05:13 -0400
Received: from web1.elbnet.com ([65.209.12.165]:51130 "EHLO web1.elbnet.com")
	by vger.kernel.org with ESMTP id <S261368AbSJLXFM>;
	Sat, 12 Oct 2002 19:05:12 -0400
Date: Sat, 12 Oct 2002 19:01:45 -0400
From: Bob Billson <reb@bhive.dhs.org>
To: linux-kernel@vger.kernel.org
Cc: James Simmons <jsimmons@transvirtual.com>
Subject: 2.5.42 compiler error in video/vga16fb.c
Message-ID: <20021012230145.GA3508@etain.bhive.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Hopeless... my honeybees are more organized.
X-Moon: The Moon is Waxing Crescent (46% of Full)
X-Uptime: 16:29:48 up 18:05,  5 users,  load average: 1.18, 1.24, 1.20
X-GPG-Key: http://bhive.dhs.org/gpgkey.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/video/vga16fb.c gcc (2.95.4 and 3.2) gives:

gcc -Wp,-MD,drivers/video/.vga16fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vga16fb   -c -o drivers/video/vga16fb.o drivers/video/vga16fb.c
drivers/video/vga16fb.c: In function `vga16fb_set_disp':
drivers/video/vga16fb.c:177: structure has no member named `visual'
drivers/video/vga16fb.c:178: structure has no member named `type'
drivers/video/vga16fb.c:179: structure has no member named `type_aux'
drivers/video/vga16fb.c:180: structure has no member named `ypanstep'
drivers/video/vga16fb.c:181: structure has no member named `ywrapstep'
drivers/video/vga16fb.c:182: structure has no member named `line_length'
drivers/video/vga16fb.c: In function `vga_vesa_blank':
drivers/video/vga16fb.c:664: warning: implicit declaration of function`cli'
drivers/video/vga16fb.c:671: warning: implicit declaration of function`sti'
drivers/video/vga16fb.c: At top level:
drivers/video/vga16fb.c:814: unknown field `fb_get_fix' specified in initializer
drivers/video/vga16fb.c:814: warning: initialization from incompatible pointer type
drivers/video/vga16fb.c:815: unknown field `fb_get_var' specified in initializer
drivers/video/vga16fb.c:815: warning: initialization from incompatible pointer type
make[2]: *** [drivers/video/vga16fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


       bob
-- 
 bob billson        email: reb@bhive.dhs.org          ham: kc2wz    /)
                           reb@elbnet.com             beekeeper  -8|||}
 "Níl aon tinteán mar do thinteán féin." --Dorothy    Linux geek    \)
 [ GPG key--> http://bhive.dhs.org/gpgkey.html ]
