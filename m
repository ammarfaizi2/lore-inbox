Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313715AbSECOiC>; Fri, 3 May 2002 10:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313724AbSECOiB>; Fri, 3 May 2002 10:38:01 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:12296 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313715AbSECOiA>; Fri, 3 May 2002 10:38:00 -0400
Date: Fri, 3 May 2002 16:37:38 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020503143738.GC14121@louise.pinerecords.com>
In-Reply-To: <13468.1020435550@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 11 days, 7:27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Release 2.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
> release 2.4.
>
> kbuild-2.5-core-13-1.

I believe you meant 's/13/10/'.

> kbuild-2.5-common-2.5.13-1.
> kbuild-2.5-i386-2.5.13-1.

hmmm.. doesn't look so good.

kala@nibbler:~$ tar xzf /usr/src/linux-2.5.13.tgz 
kala@nibbler:~$ cd linux-2.5.13 
kala@nibbler:~/linux-2.5.13$ zcat /usr/src/kbuild-2.5-core-10.gz /usr/src/kbuild-2.5-common-2.5.13-1.gz /usr/src/kbuild-2.5-i386-2.5.13-1.gz |patch -sp1
kala@nibbler:~/linux-2.5.13$ cp /lib/modules/2.5.13/.config .
kala@nibbler:~/linux-2.5.13$ make -f Makefile-2.5 oldconfig
Makefile-2.5:251: /no_such_file-arch/i386/Makefile.defs.noconfig: No such file or directory
/home/kala/linux-2.5.13/scripts/Makefile-2.5:473: /no_such_file-arch/i386/Makefile.defs.config: No such file or directory
Makefile-2.5:251: /no_such_file-arch/i386/Makefile.defs.noconfig: No such file or directory
/home/kala/linux-2.5.13/scripts/Makefile-2.5:473: /no_such_file-arch/i386/Makefile.defs.config: No such file or directory
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
...

kala@nibbler:~/linux-2.5.13$ make -f Makefile-2.5 installable
Makefile-2.5:251: /no_such_file-arch/i386/Makefile.defs.noconfig: No such file or directory
spec value %p not found
/home/kala/linux-2.5.13/scripts/Makefile-2.5:473: /no_such_file-arch/i386/Makefile.defs.config: No such file or directory
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
  phase 2 (convert all Makefile.in files)
  phase 3 (evaluate selections)
  phase 4 (integrity checks, write global makefile)
pp_makefile4: arch/i386/lib/lib.a is selected but is not part of vmlinux, missing link_subdirs?
make: *** [phase4] Error 1


T.
