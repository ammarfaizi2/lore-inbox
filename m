Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJASst>; Tue, 1 Oct 2002 14:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbSJASrx>; Tue, 1 Oct 2002 14:47:53 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:6822 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262213AbSJASrG> convert rfc822-to-8bit; Tue, 1 Oct 2002 14:47:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Date: Tue, 1 Oct 2002 20:52:27 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210012048.39981.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> the attached (compressed) patch is the next iteration of the workqueue
> abstraction. There are two major categories of changes:

does not compile on 2.5.40 with XFS. Compiles clean w/o your patch.
(I cannot have a look into your maxi-config.bz2 because it is corrupt)

See:

make[2]: Entering directory `/usr/src/linux-2.5.40/fs/xfs'
  gcc -Wp,-MD,./.xfs_rtalloc.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -I/usr/src/linux-2.5.40/arch/i386/mach-generic   -nostdinc 
-iwithprefix include -DMODULE -I. -funsigned-char  
-DKBUILD_BASENAME=xfs_rtalloc 
  -c -o xfs_rtalloc.o xfs_rtalloc.c
In file included from linux/xfs_linux.h:64,
                 from xfs.h:54,
                 from xfs_rtalloc.c:37:
fs/xfs/pagebuf/page_buf.h:50: linux/tqueue.h: No such file or directory
In file included from linux/xfs_linux.h:64,
                 from xfs.h:54,
                 from xfs_rtalloc.c:37:
fs/xfs/pagebuf/page_buf.h:217: field `pb_iodone_sched' has incomplete type
In file included from xfs.h:106,
                 from xfs_rtalloc.c:37:
fs/xfs/xfs_log_priv.h:441: field `ic_write_sched' has incomplete type
fs/xfs/xfs_log.h:62: warning: `_lsn_cmp' defined but not used
fixdep: ./.xfs_rtalloc.o.d: No such file or directory
make[2]: *** [xfs_rtalloc.o] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.40/fs/xfs'
make[1]: *** [xfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/fs'
make: *** [fs] Error 2


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


