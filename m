Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEFLnu>; Mon, 6 May 2002 07:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSEFLnu>; Mon, 6 May 2002 07:43:50 -0400
Received: from postman.arcor-online.net ([151.189.0.87]:530 "EHLO
	postman.arcor-online.net") by vger.kernel.org with ESMTP
	id <S314389AbSEFLns>; Mon, 6 May 2002 07:43:48 -0400
Date: Mon, 6 May 2002 13:41:43 +0200
From: Stefan Frank <sfr@gmx.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8 compile error [in drivers/char/serial.c]
Message-ID: <20020506114143.GA26760@asterix>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

got the following compile error :


make-kpkg --revision=1 kernel_image
.
.
.
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=console
-DEXPORT_SYMTAB -c console.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=selection
-DEXPORT_SYMTAB -c selection.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=serial
-DEXPORT_SYMTAB -c serial.c
In file included from serial.c:186:
/usr/src/linux-2.4/include/linux/serialP.h:27: parse error
serial.c:206: parse error
serial.c:209: parse error
serial.c:230: parse error
serial.c:683: parse error
serial.c:1444: parse error
serial.c:1593: parse error
serial.c:2169: parse error
serial.c:2216: parse error
serial.c:2393: parse error
serial.c:2550: parse error
serial.c:2565: parse error
serial.c:3179: parse error
serial.c:3846: parse error
serial.c:3851: linux/symtab_begin.h: No such file or directory
serial.c:3854: linux/symtab_end.h: No such file or directory
serial.c:5360: parse error
serial.c:5363: parse error
serial.c:5398: parse error
serial.c:5401: parse error
serial.c:5412: parse error
serial.c:5419: parse error
serial.c: In function `receive_chars':
serial.c:686: warning: implicit declaration of function `queue_task_irq_off'
serial.c: In function `rs_write':
serial.c:1888: warning: implicit declaration of function `copy_from_user'
serial.c: In function `get_serial_info':
serial.c:2086: warning: implicit declaration of function `copy_to_user'
serial.c: At top level:
serial.c:3850: variable `serial_syms' has initializer but incomplete type
serial.c:3852: warning: implicit declaration of function `X'
serial.c:3852: warning: excess elements in struct initializer
serial.c:3852: warning: (near initialization for `serial_syms')
serial.c:3853: warning: excess elements in struct initializer
serial.c:3853: warning: (near initialization for `serial_syms')
serial.c:2410: warning: `rs_break' defined but not used
serial.c:3850: warning: `serial_syms' defined but not used
make[4]: *** [serial.o] Fehler 1
make[4]: Leaving directory `/usr/src/linux-2.4/drivers/char'
make[3]: *** [first_rule] Fehler 2
make[3]: Leaving directory `/usr/src/linux-2.4/drivers/char'
make[2]: *** [_subdir_char] Fehler 2
make[2]: Leaving directory `/usr/src/linux-2.4/drivers'
make[1]: *** [_dir_drivers] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.4'
make: *** [stamp-build] Fehler 2

asterix:/usr/src/linux/scripts# ./ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
 Linux asterix 2.4.18-a1 #1 Mon Apr 15 19:53:06 CEST 2002 i686 unknown
  
  Gnu C                  2.95.4
  Gnu make               3.79.1
  util-linux             2.11n
  mount                  2.11n
  modutils               2.4.15
  e2fsprogs              1.27
  PPP                    2.4.1
  Linux C Library        2.2.5
  Dynamic linker (ldd)   2.2.5
  Procps                 2.0.7
  Net-tools              1.60
  Console-tools          0.2.3
  Sh-utils               2.0.11
  Modules Loaded         parport_pc lp parport snd-seq-midi snd-seq-oss
  snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-cs46xx
  snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd
  soundcore 3c59x w83781d i2c-proc i2c-viapro i2c-matroxfb i2c-algo-bit
  i2c-core apm ide-scsi rtc
  

This is on Debian sid using the kernel-package.

Bye, Stefan

-- 
Proboscis:  The rudimentary organ of an elephant which serves him in place
of the knife-and-fork that Evolution has as yet denied him.  For purposes
of humor it is popularly called a trunk.
-- Ambrose Bierce
