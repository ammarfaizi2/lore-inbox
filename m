Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTEMF4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTEMF4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:56:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:29156 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262976AbTEMF4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:56:10 -0400
Date: Mon, 12 May 2003 20:51:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Bharata B Rao <bharata@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20570000.1052797864@[10.10.2.4]>
In-Reply-To: <20030512205139.GT1107@fs.tum.de>
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Adrian Bunk <bunk@fs.tum.de> wrote (on Monday, May 12, 2003 22:51:40 +0200):

> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,drivers/dump/.dump_blockdev.o.d -D__KERNEL__ -Iinclude 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
> -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_blockdev 
> \-DKBUILD_MODNAME=dump_blockdev -c -o drivers/dump/dump_blockdev.o 
> drivers/dump/dump_blockdev.c
> drivers/dump/dump_blockdev.c: In function `dump_block_silence':
> drivers/dump/dump_blockdev.c:264: warning: implicit declaration of function `blk_queue_empty'
> ...
> 386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> drivers/built-in.o(.text+0x77edaf): In function `dump_block_silence':
> : undefined reference to `blk_queue_empty'
> ...
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> This is the only occurence of blk_queue_empty in the whole kernel tree.

Thanks Adrian ... this is LKCD stuff, maybe Suparna / Bharata can fix it?
Looks like it disappeared in 2.5.67 or so.

M.

