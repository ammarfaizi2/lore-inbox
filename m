Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSELC0a>; Sat, 11 May 2002 22:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSELC03>; Sat, 11 May 2002 22:26:29 -0400
Received: from pD9E2404B.dip.t-dialin.net ([217.226.64.75]:60998 "EHLO
	extern.linux-systeme.org") by vger.kernel.org with ESMTP
	id <S315282AbSELC03>; Sat, 11 May 2002 22:26:29 -0400
Date: Sun, 12 May 2002 04:26:13 +0200 (MET DST)
From: mcp@linux-systeme.de
Reply-To: mcp@linux-systeme.de
To: Pawel Kot <pkot@ziew.org>
cc: mcp@linux-systeme.de, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NTFS 2.0.7a for Linux 2.4.18
Message-ID: <Pine.LNX.3.96.1020512040757.27097A-100000@fps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

>Backported NTFS 2.0.7 from 2.5.x to 2.4.18 is available from linux-ntfs
>project page:
i've tried this, have a look:

cc  -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -Wno-unused -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DNTFS_VERSION=\"2.0.7a\" -DDEBUG -DKBUILD_BASENAME=debug  -c -o debug.o
debug.c
debug.c: In function `__ntfs_warning':
debug.c:58: `current' undeclared (first use in this function)
debug.c:58: (Each undeclared identifier is reported only once
debug.c:58: for each function it appears in.)
debug.c:68: warning: implicit declaration of function `preempt_schedule'
debug.c: In function `__ntfs_error':
debug.c:98: `current' undeclared (first use in this function)
debug.c: In function `__ntfs_debug':
debug.c:126: `current' undeclared (first use in this function)
make[2]: *** [debug.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.4.18/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18/fs'
make: *** [_mod_fs] Error 2

Yes, 2.4.18 + preempt and some other additional stuff.
NTFS is a Module, happs with/without selecting debug feature in kernel
config.

Kind regards,
	Marc


