Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRDBRPu>; Mon, 2 Apr 2001 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRDBRPj>; Mon, 2 Apr 2001 13:15:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131063AbRDBRPc>; Mon, 2 Apr 2001 13:15:32 -0400
Date: Mon, 2 Apr 2001 17:37:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrejs Dubovskis <andrejs@lmt.lv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can not compile 2.4.3 on alpha
Message-ID: <20010402173739.A1024@inspiron.random>
In-Reply-To: <3AC86511.F3123F6C@lmt.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AC86511.F3123F6C@lmt.lv>; from andrejs@lmt.lv on Mon, Apr 02, 2001 at 02:40:01PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 02:40:01PM +0300, Andrejs Dubovskis wrote:
> [linux] make dep;make clean;make boot
> ...
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -c -o init/main.o
> init/main.c
> In file included from /usr/src/linux-2.4.3/include/linux/highmem.h:6,
>                  from /usr/src/linux-2.4.3/include/linux/pagemap.h:17,
>                  from /usr/src/linux-2.4.3/include/linux/locks.h:9,
>                  from /usr/src/linux-2.4.3/include/linux/raid/md.h:37,
>                  from init/main.c:25:
> /usr/src/linux-2.4.3/include/asm/pgalloc.h:334: conflicting types for
> `pte_alloc'
> /usr/src/linux-2.4.3/include/linux/mm.h:399: previous declaration of
> `pte_alloc'
> /usr/src/linux-2.4.3/include/asm/pgalloc.h:352: conflicting types for
> `pmd_alloc'
> /usr/src/linux-2.4.3/include/linux/mm.h:412: previous declaration of
> `pmd_alloc'
> make: *** [init/main.o] Error 1

can you try this patch?

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.3/alpha-numa-2

Andrea
