Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbSKQNFn>; Sun, 17 Nov 2002 08:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbSKQNFn>; Sun, 17 Nov 2002 08:05:43 -0500
Received: from mail.broadpark.no ([217.13.4.2]:10396 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S267497AbSKQNFn>;
	Sun, 17 Nov 2002 08:05:43 -0500
Message-ID: <3DD795AA.B7CB569B@broadpark.no>
Date: Sun, 17 Nov 2002 14:12:10 +0100
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-bk6  hugetlbfs didn't compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the compile failure

make -f scripts/Makefile.build obj=fs/hugetlbfs
  gcc -Wp,-MD,fs/hugetlbfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=inode -DKBUILD_MODNAME=hugetlbfs   -c -o
fs/hugetlbfs/inode.o fs/hugetlbfs/inode.c
fs/hugetlbfs/inode.c: In function `hugetlb_zero_setup':
fs/hugetlbfs/inode.c:531: dereferencing pointer to incomplete type
fs/hugetlbfs/inode.c:553: warning: implicit declaration of function
`mntget'
fs/hugetlbfs/inode.c:553: warning: assignment makes pointer from integer
without a cast
fs/hugetlbfs/inode.c:521: warning: `root' might be used uninitialized in
this function
make[2]: *** [fs/hugetlbfs/inode.o] Error 1
make[1]: *** [fs/hugetlbfs] Error 2
make: *** [fs] Error 2

Helge Hafting
