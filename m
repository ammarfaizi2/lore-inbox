Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSKCB0J>; Sat, 2 Nov 2002 20:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSKCB0J>; Sat, 2 Nov 2002 20:26:09 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4307 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261544AbSKCB0I>; Sat, 2 Nov 2002 20:26:08 -0500
Message-ID: <3DC47CAE.4040207@nortelnetworks.com>
Date: Sat, 02 Nov 2002 20:32:30 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: riva framebuffer compilation bug in 2.5.45
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/video/riva
   gcc -Wp,-MD,drivers/video/riva/.fbdev.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
  -DKBUILD_BASENAME=fbdev   -c -o drivers/video/riva/fbdev.o 
drivers/video/riva/fbdev.c
drivers/video/riva/fbdev.c: In function `riva_set_dispsw':
drivers/video/riva/fbdev.c:665: structure has no member named `type'
drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
drivers/video/riva/fbdev.c:668: structure has no member named `ywrapstep'
drivers/video/riva/fbdev.c:657: warning: unused variable `accel'
drivers/video/riva/fbdev.c: In function `rivafb_setcolreg':
drivers/video/riva/fbdev.c:1202: warning: unused variable `chip'
drivers/video/riva/fbdev.c: In function `rivafb_get_fix':
drivers/video/riva/fbdev.c:1294: structure has no member named `type'
drivers/video/riva/fbdev.c:1295: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:1296: structure has no member named `visual'
drivers/video/riva/fbdev.c:1302: structure has no member named `line_length'
drivers/video/riva/fbdev.c: In function `rivafb_pan_display':
drivers/video/riva/fbdev.c:1611: structure has no member named `line_length'
drivers/video/riva/fbdev.c: At top level:
drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in 
initializer
drivers/video/riva/fbdev.c:1748: warning: initialization from 
incompatible pointer type
drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in 
initializer
drivers/video/riva/fbdev.c:1749: warning: initialization from 
incompatible pointer type
drivers/video/riva/fbdev.c:732: warning: `riva_wclut' defined but not used
make[3]: *** [drivers/video/riva/fbdev.o] Error 1
make[2]: *** [drivers/video/riva] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

