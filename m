Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287404AbSALUSS>; Sat, 12 Jan 2002 15:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSALUSL>; Sat, 12 Jan 2002 15:18:11 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:62069 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287404AbSALURy>; Sat, 12 Jan 2002 15:17:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Can't compile 2.5.2-pre11: error in fbdev
From: Sebastian Krause <krause@sdbk.de>
Date: Sat, 12 Jan 2002 21:17:50 +0100
Message-ID: <krause.87lmf3pbm9.fsf@sdbk.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile 2.5.2-pre11, I get the following error:

ld -m elf_i386  -r -o sounddrivers.o soundcore.o sound.o sb.o sb_lib.o uart401.o
make[3]: Leaving directory `/usr/src/v2.5/linux/drivers/sound'
make[2]: Leaving directory `/usr/src/v2.5/linux/drivers/sound'
make -C video
make[2]: Entering directory `/usr/src/v2.5/linux/drivers/video'
make -C riva
make[3]: Entering directory `/usr/src/v2.5/linux/drivers/video/riva'
make all_targets
make[4]: Entering directory `/usr/src/v2.5/linux/drivers/video/riva'
gcc -D__KERNEL__ -I/usr/src/v2.5/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_fbinfo':
fbdev.c:1814: incompatible types in assignment
make[4]: *** [fbdev.o] Error 1
make[4]: Leaving directory `/usr/src/v2.5/linux/drivers/video/riva'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/v2.5/linux/drivers/video/riva'
make[2]: *** [_subdir_riva] Error 2
make[2]: Leaving directory `/usr/src/v2.5/linux/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/v2.5/linux/drivers'
make: *** [_dir_drivers] Error 2

I'm using gcc 2.95.4 under Debian Woody. 2.4.17 works without any
problems. What do I make wrong?

Sebastian
