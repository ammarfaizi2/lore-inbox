Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSJLHRS>; Sat, 12 Oct 2002 03:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSJLHRS>; Sat, 12 Oct 2002 03:17:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15049 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261877AbSJLHRR>; Sat, 12 Oct 2002 03:17:17 -0400
Date: Sat, 12 Oct 2002 09:23:03 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: stevef@smfhome1.austin.rr.com, <jfs-discussion@oss.software.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210120918290.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.41 to v2.5.42
> ============================================
>...
> <stevef@smfhome1.austin.rr.com>:
>   o Initial check in of cifs filesystem version 0.54 for Linux 2.5 (to
>     clean tree as one changeset)
>...


Both jfs and cifs ship a function called `dump_mem' causing the following
compile error when both are included:

<--  snip  -->

   ld -m elf_i386  -r -o fs/built-in.o ...
fs/jfs/built-in.o: In function `dump_mem':
fs/jfs/built-in.o(.text+0xe420): multiple definition of `dump_mem'
fs/cifs/built-in.o(.text+0x3af0): first defined here
make[1]: *** [fs/built-in.o] Error 1
make: *** [fs] Error 2

<--  snip  -->

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed

