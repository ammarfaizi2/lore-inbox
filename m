Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSELGkh>; Sun, 12 May 2002 02:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSELGkg>; Sun, 12 May 2002 02:40:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42236 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315334AbSELGkf>; Sun, 12 May 2002 02:40:35 -0400
Date: Sun, 12 May 2002 08:40:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac2
In-Reply-To: <200205112347.g4BNlUw17368@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0205120837500.1235-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

it seems that the changes to sched.c in -ac2 require a corresponding
change to sched.h?

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-modular/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=sched
-fno-omit-frame-pointer -O2 -c -o sched.o sched.c
sched.c: In function `migration_thread':
sched.c:1595: structure has no member named `thread_info'
sched.c:1600: structure has no member named `thread_info'
sched.c:1606: structure has no member named `thread_info'
sched.c:1574: warning: `cpu_src' might be used uninitialized in this
function
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-modular/kernel'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

