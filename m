Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSK0WU7>; Wed, 27 Nov 2002 17:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSK0WU7>; Wed, 27 Nov 2002 17:20:59 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:58640 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S264853AbSK0WU7>; Wed, 27 Nov 2002 17:20:59 -0500
Message-ID: <3DE54702.44D98750@compuserve.com>
Date: Wed, 27 Nov 2002 17:28:18 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: hugetlbpage.c build failure?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following build failure in bk current:

  gcc -Wp,-MD,arch/i386/mm/.hugetlbpage.o.d -D__KERNEL__ -Iinclude -Wall
-Wstric
t-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-po
inter -pipe -g -mpreferred-stack-boundary=2 -march=athlon
-Iarch/i386/mach-gener
ic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=hugetlbpage
-DKBUILD_MODN
AME=hugetlbpage   -c -o arch/i386/mm/hugetlbpage.o
arch/i386/mm/hugetlbpage.c


arch/i386/mm/hugetlbpage.c:610: parse error before '*' token
arch/i386/mm/hugetlbpage.c: In function `hugetlb_sysctl_handler':
arch/i386/mm/hugetlbpage.c:611: number of arguments doesn't match
prototype
include/linux/hugetlb.h:14: prototype declaration
arch/i386/mm/hugetlbpage.c:612: warning: implicit declaration of
function `proc_
dointvec'
arch/i386/mm/hugetlbpage.c:612: `table' undeclared (first use in this
function)
arch/i386/mm/hugetlbpage.c:612: (Each undeclared identifier is reported
only onc
e
arch/i386/mm/hugetlbpage.c:612: for each function it appears in.)
arch/i386/mm/hugetlbpage.c:612: `write' undeclared (first use in this
function)
arch/i386/mm/hugetlbpage.c:612: `file' undeclared (first use in this
function)
arch/i386/mm/hugetlbpage.c:612: `buffer' undeclared (first use in this
function)
arch/i386/mm/hugetlbpage.c:612: `length' undeclared (first use in this
function)
make[1]: *** [arch/i386/mm/hugetlbpage.o] Error 1
make: *** [arch/i386/mm] Error 2


-- 
Kevin
