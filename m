Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268859AbRHKVgo>; Sat, 11 Aug 2001 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268858AbRHKVgZ>; Sat, 11 Aug 2001 17:36:25 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9101 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268857AbRHKVgW>; Sat, 11 Aug 2001 17:36:22 -0400
Date: Sat, 11 Aug 2001 14:35:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010811143559.E4657@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <1904.997542180@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1904.997542180@ocs3.ocs-net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:

> Release 1.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
> release 1.1.

Okay, I think I found some wierd problem.
$ make -f Makefile-2.5 ARCH=i386
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar'
Generating global Makefile
phase 1 (find all inputs)
phase 2 (evaluate selections)
pp_makefile2: drivers/char/defkeymap.o is selected but is not part of vmlinux, missing link_subdirs?
pp_makefile2: drivers/char/pc_keyb.o is selected but is not part of vmlinux, missing link_subdirs?
make: *** [/home/trini/work/kernel/kbuild/linux-2.4.8/.tmp_targets] Error 2

Prior to this i did make -f Makefile-2.5 ARCH=i386 oldconfig and said 'n' to
all new questions.
    
-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
