Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEYIhv>; Sat, 25 May 2002 04:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSEYIhu>; Sat, 25 May 2002 04:37:50 -0400
Received: from ulima.unil.ch ([130.223.144.143]:19078 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S314138AbSEYIht>;
	Sat, 25 May 2002 04:37:49 -0400
Date: Sat, 25 May 2002 10:37:49 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.18 suspend.c don't compil with gcc 3.1
Message-ID: <20020525083749.GA2025@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just wanted to try this new feature, but :

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -DKBUILD_BASENAME=suspend -DEXPORT_SYMTAB -c -o suspend.o suspend.c
suspend.c: In function `freeze_processes':
suspend.c:240: warning: implicit declaration of function `signal_wake_up'
suspend.c: In function `fill_suspend_header':
suspend.c:292: warning: comparison between pointer and integer
suspend.c: In function `write_suspend_image':
suspend.c:436: warning: passing arg 3 of `get_swaphandle_info' from incompatible pointer type
suspend.c:435: warning: unused variable `dummy2'
suspend.c: In function `suspend_save_image':
suspend.c:729: warning: assignment makes integer from pointer without a cast
suspend.c: In function `bdev_read_page':
suspend.c:1051: warning: implicit declaration of function `__bread'
suspend.c:1051: warning: assignment makes pointer from integer without a cast
suspend.c:1052: dereferencing pointer to incomplete type
suspend.c:1055: dereferencing pointer to incomplete type
suspend.c:1055: dereferencing pointer to incomplete type
suspend.c:1056: warning: implicit declaration of function `buffer_uptodate'
suspend.c:1057: warning: implicit declaration of function `brelse'
suspend.c: In function `resume_try_to_read':
suspend.c:1071: warning: passing arg 1 of `name_to_kdev_t' discards qualifiers from pointer target type
suspend.c:1079: warning: unsigned int format, kdev_t arg (arg 2)
suspend.c:1069: warning: unused variable `blksize'
suspend.c: At top level:
suspend.c:1232: warning: static declaration for `resume_setup' follows non-static
make[1]: *** [suspend.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5/kernel'
make: *** [_dir_kernel] Error 2

Thanks you very much,
 
	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
