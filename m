Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTELUjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTELUjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:39:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:971 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262598AbTELUjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:39:02 -0400
Date: Mon, 12 May 2003 22:51:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030512205139.GT1107@fs.tum.de>
References: <9380000.1052624649@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9380000.1052624649@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  gcc -Wp,-MD,drivers/dump/.dump_blockdev.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_blockdev 
\-DKBUILD_MODNAME=dump_blockdev -c -o drivers/dump/dump_blockdev.o 
drivers/dump/dump_blockdev.c
drivers/dump/dump_blockdev.c: In function `dump_block_silence':
drivers/dump/dump_blockdev.c:264: warning: implicit declaration of function `blk_queue_empty'
...
386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.text+0x77edaf): In function `dump_block_silence':
: undefined reference to `blk_queue_empty'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

This is the only occurence of blk_queue_empty in the whole kernel tree.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

