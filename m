Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCSSmz>; Tue, 19 Mar 2002 13:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCSSmp>; Tue, 19 Mar 2002 13:42:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14075 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S290228AbSCSSme>; Tue, 19 Mar 2002 13:42:34 -0500
Date: Tue, 19 Mar 2002 19:42:27 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac2
In-Reply-To: <E16nNPD-0008E3-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.44.0203191938530.3932-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

it seems one call of do_munmap was forgotten:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=shm  -c -o shm.o shm.c
shm.c: In function `sys_shmdt':
shm.c:682: too few arguments to function `do_munmap'
make[2]: *** [shm.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/linux/ipc'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/bunk/linux/linux/ipc'
make: *** [_dir_ipc] Error 2

<--  snip  -->

cu
Adrian




