Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTBJVdo>; Mon, 10 Feb 2003 16:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTBJVdo>; Mon, 10 Feb 2003 16:33:44 -0500
Received: from www.amthinking.net ([65.104.119.37]:2771 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP
	id <S265169AbTBJVdn>; Mon, 10 Feb 2003 16:33:43 -0500
From: "James Lamanna" <james.lamanna@appliedminds.com>
To: "'Adrian Bunk'" <bunk@fs.tum.de>,
       "'Linus Torvalds'" <torvalds@transmeta.com>, <shaggy@austin.ibm.com>,
       <jfs-discussion@oss.software.ibm.com>
Cc: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.60: JFS no longer compiles with gcc 2.95
Date: Mon, 10 Feb 2003 13:43:26 -0800
Message-ID: <022f01c2d14d$71b46550$39140b0a@amthinking.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030210204651.GE17128@fs.tum.de>
X-OriginalArrivalTime: 10 Feb 2003 21:43:27.0087 (UTC) FILETIME=[71BFAFF0:01C2D14D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This broke the compilation with gcc 2.95: 
<--  snip  --> 
... 
  gcc -Wp,-MD,fs/jfs/.super.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  
-D_JFS_4K  -DKBUILD_BASENAME=super -DKBUILD_MODNAME=jfs -c -o 
fs/jfs/super.o fs/jfs/super.c 
fs/jfs/super.c: In function `jfs_fill_super': 
fs/jfs/super.c:335: parse error before `)' 
make[2]: *** [fs/jfs/super.o] Error 1 
<--  snip  --> 

Curious as to what gcc 2.95 version you are using.
Seems to compile fine with:
gcc 2.95.4 20011002

--James

