Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314801AbSD2GAL>; Mon, 29 Apr 2002 02:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314802AbSD2GAK>; Mon, 29 Apr 2002 02:00:10 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:26083 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S314801AbSD2GAK>; Mon, 29 Apr 2002 02:00:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.11 framebuffer compilation error 
Date: Sun, 28 Apr 2002 23:53:35 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02042823533500.06684@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll know this kernel is ready for merger with the 2.4 when I can finally 
compile it :) ... must have tried 6-7 versions by now ...

Error:
Note...this is something new that I haven't tried to compile before.
Error might be caused by an earlier kernel.
However, 2.5.11 does contain a lot of screen_base changes. 
________________________________________________
gcc -D__KERNEL__ -I/usr/src/linux-2.5.11/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-DKBUILD_BASENAME=fbcon_cfb8  -DEXPORT_SYMTAB -c fbcon-cfb8.c
fbcon-cfb8.c: In function `fbcon_cfb8_bmove':
fbcon-cfb8.c:55: structure has no member named `screen_base'
fbcon-cfb8.c:56: structure has no member named `screen_base'
fbcon-cfb8.c:66: structure has no member named `screen_base'
fbcon-cfb8.c:67: structure has no member named `screen_base'
fbcon-cfb8.c:74: structure has no member named `screen_base'
fbcon-cfb8.c:75: structure has no member named `screen_base'
fbcon-cfb8.c:52: warning: `src' might be used uninitialized in this function
fbcon-cfb8.c:52: warning: `dst' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_clear':
fbcon-cfb8.c:100: structure has no member named `screen_base'
fbcon-cfb8.c:96: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_putc':
fbcon-cfb8.c:118: structure has no member named `screen_base'
fbcon-cfb8.c:114: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_putcs':
fbcon-cfb8.c:165: structure has no member named `screen_base'
fbcon-cfb8.c:160: warning: `dest0' might be used uninitialized in this 
function
fbcon-cfb8.c: In function `fbcon_cfb8_revc':
fbcon-cfb8.c:222: structure has no member named `screen_base'
fbcon-cfb8.c:219: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_clear_margins':
fbcon-cfb8.c:247: structure has no member named `screen_base'
fbcon-cfb8.c:250: structure has no member named `screen_base'
make[3]: *** [fbcon-cfb8.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.11/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.11/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.11/drivers'
make: *** [_dir_drivers] Error 2
