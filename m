Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTBJUhN>; Mon, 10 Feb 2003 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBJUhN>; Mon, 10 Feb 2003 15:37:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12245 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265095AbTBJUhM>; Mon, 10 Feb 2003 15:37:12 -0500
Date: Mon, 10 Feb 2003 21:46:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>, shaggy@austin.ibm.com,
       jfs-discussion@oss.software.ibm.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.60: JFS no longer compiles with gcc 2.95
Message-ID: <20030210204651.GE17128@fs.tum.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.59 to v2.5.60
> ============================================
>...
> Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
>...
>   o JFS: replace ugly JFS debug macros with simpler ones
>...

This broke the compilation with gcc 2.95:

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

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

