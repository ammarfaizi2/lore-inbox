Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbSJAQOi>; Tue, 1 Oct 2002 12:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbSJAQOi>; Tue, 1 Oct 2002 12:14:38 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:16589 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262133AbSJAQOg>; Tue, 1 Oct 2002 12:14:36 -0400
Date: Tue, 1 Oct 2002 18:20:17 +0200 (CEST)
From: Michael De Nil <michael@aerythmic.be>
X-X-Sender: linux@lisa.flex-it.be
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Request -> dblspace-support
Message-ID: <Pine.LNX.4.44.0210011804060.32546-100000@lisa.flex-it.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

I have here an old doublespace-partition on my 486.
I copied all the files from the partition to another machine with more
power & hd:

-rw-r--r--    1 flecxie  flecxie   8192000 Sep 29 20:05 386spart.par
-rw-r--r--    1 flecxie  flecxie  109890048 Sep 29 20:18 dblspace.000
-rw-r--r--    1 flecxie  flecxie     51214 Sep 29 20:21 dblspace.bin
-rw-r--r--    1 flecxie  flecxie        91 Sep 29 20:21 dblspace.ini
-rw-r--r--    1 flecxie  flecxie     40470 Sep 29 20:21 io.sys
-rw-r--r--    1 flecxie  flecxie     38138 Sep 29 20:21 msdos.sys


Now I need to extract the doublespace-file, but I can only find 2 modules:
-> DmsDOS, which was made for 2.1 & 2.2
-> thsfs, which was made for 1.1

Like expectyed, non of both wouldn't compile on my machine here, :/

DmsDOS
-------
Now I'm trying to find out whether your kernel needs some patches for
dmsdos.
If something is patched, a log file '*.log' will be written to /tmp.
Scanning for *.rej files... not found, ok.
Kernel has already CVF-FAT support.
Scanning for *.rej files... not found, ok.
sh conf.sh
This really looks like you have already configured and compiled your
kernel correctly for CVF-FAT. I hope I'm not wrong here :-)
make -C src
make[1]: Entering directory `/home/flecxie/dmsdos-0.9.2.1/src'
gcc -Wall -Wstrict-prototypes -O3 -fomit-frame-pointer -D__KERNEL__
-DMODULE  -D__SMP__   -c -o dblspace_tables.o dblspace_tables.c
In file included from dblspace_tables.c:39:
/usr/include/linux/malloc.h:4: warning: #warning linux/malloc.h is
deprecated, use linux/slab.h instead.
dblspace_tables.c:79: `MUTEX' undeclared here (not in a function)
dblspace_tables.c:83: `MUTEX' undeclared here (not in a function)
dblspace_tables.c:87: `MUTEX' undeclared here (not in a function)
make[1]: *** [dblspace_tables.o] Error 1
make[1]: Leaving directory `/home/flecxie/dmsdos-0.9.2.1/src'
make: *** [compile] Error 2


thsfs
------
flecxie@furby:~/thsfs$ make
echo 'char kernel_version[]="'`uname -r`'";' >version.h
gcc -D__KERNEL__ -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe
-m486
-c super.c
In file included from super.c:18:
/usr/include/linux/malloc.h:4: warning: #warning linux/malloc.h is
deprecated, use linux/slab.h instead.
In file included from super.c:24:
ths.h:54: warning: `struct dirent' declared inside parameter list
ths.h:54: warning: its scope is only this definition or declaration, which
is probably not what you want.
super.c:32: warning: initialization from incompatible pointer type
super.c:34: warning: initialization from incompatible pointer type
super.c: In function `ths_read_super_dblspace':
super.c:168: structure has no member named `s_mounted'
super.c: In function `ths_read_super_normal':
super.c:225: structure has no member named `s_mounted'
super.c: In function `ths_put_super':
super.c:329: warning: implicit declaration of function `kfree_s'
super.c: In function `ths_statfs':
super.c:348: warning: implicit declaration of function `put_fs_long'
make: *** [super.o] Error 1


Is there any kernel-developer willing to port this to the 2.4-thread ?
I can give you a secure shell here on my local machine, so you don't have
to find a doublespace-partition somewhere.

Sry that I'm not as smart as you people :)

Thanks
	Michael

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
 Linux lisa.flex-it.be 2.4.19-rc2 #1 vr jul 19 22:10:00 CEST 2002 i686
  18:04:01 up 60 days,  1:40, 12 users,  load average: 0.70, 0.63, 0.40
-----------------------------------------------------------------------



