Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSFDJRG>; Tue, 4 Jun 2002 05:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSFDJRF>; Tue, 4 Jun 2002 05:17:05 -0400
Received: from boden.synopsys.com ([204.176.20.19]:58823 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S317424AbSFDJRF>; Tue, 4 Jun 2002 05:17:05 -0400
Date: Tue, 4 Jun 2002 11:16:46 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available
Message-ID: <20020604091646.GB29455@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <27953.1023071705@kao2.melbourne.sgi.com> <11725.1023166408@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this trying to compile 2.5.20 with Debian's gcc 2.95.4.
Why it took the system-wide zlib.h?

$ make -f Makefile-2.5 fs/isofs/compress.o KBUILD_QUIET=
...
scripts/pp_makefile5  --type=CC --target=fs/isofs/compress.o --src=fs/isofs/compress.c --srctree=999 --flags='-Ifs/isofs -I- -D__KERNEL__ -Iinclude/ -I.tmp_include/src_000/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2    -fomit-frame-pointer -march=i686 -nostdinc -iwithprefix include  -DKBUILD_OBJECT=isofs -DKBUILD_BASENAME=compress -DMODULE   '
In file included from /export/home/riesen-pc0/riesen/compile/v2.5/fs/isofs/compress.c:38:
include/linux/zlib.h:34: zconf.h: No such file or directory

On Tue, Jun 04, 2002 at 02:53:28PM +1000, Keith Owens wrote:
> On Mon, 03 Jun 2002 12:35:05 +1000, 
> Keith Owens <kaos@ocs.com.au> wrote:
> >Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> >http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
> >release 3.0.
> 
> New files:
> 
> kbuild-2.5-core-16
>   Changes from core-15.
> 
>     Override some command line variables to ensure that they are changed.
> 
>     Replace -nostdinc with Russell King's version.
> 
>     Print full filename in warning message.
> 
>     Correct lock filename.
> 
>     Correct unmap old db (sparc64 SEGV).
> 
>     Tweak dirty flag checking.
> 
> kbuild-2.5-common-2.5.20-2.
>   Changes from common-2.5.20-1.
> 
>     Correct drivers/acpi/Makefile.in, Arnd Bergmann.
>    
> kbuild-2.5-s390-2.5.20-1.
> kbuild-2.5-s390x-2.5.20-1.
> 
>     Arnd Bergmann.
> 
> -
