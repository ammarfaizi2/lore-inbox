Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSH0UoP>; Tue, 27 Aug 2002 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSH0UoP>; Tue, 27 Aug 2002 16:44:15 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:30478 "EHLO debian")
	by vger.kernel.org with ESMTP id <S317257AbSH0UoJ>;
	Tue, 27 Aug 2002 16:44:09 -0400
Date: Tue, 27 Aug 2002 22:48:27 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32
Message-ID: <20020827204827.GC24265@debian>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020827202250.GA24265@debian> <Pine.LNX.4.44.0208271435150.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271435150.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

now, it's not a problem, just a comment.

but i have an other compile error, 

make[2]: Entering directory `/root/linux-2.5.32/fs/intermezzo'
  gcc-3.2 -Wp,-MD,./.vfs.o.d -D__KERNEL__ -I/root/linux-2.5.32/include
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vfs   -c
  -o vfs.o vfs.c
  vfs.c: In function `presto_debug_fail_blkdev':
  vfs.c:134: invalid initializer
  vfs.c:136: warning: implicit declaration of function `is_read_only'
  vfs.c: In function `presto_do_rmdir':
  vfs.c:1244: warning: implicit declaration of function `double_down'
  vfs.c:1260: warning: implicit declaration of function `double_up'
  vfs.c: In function `presto_rename_dir':
  vfs.c:1627: warning: implicit declaration of function `triple_down'
  vfs.c:1644: warning: implicit declaration of function `triple_up'
  vfs.c: In function `lento_do_rename':
  vfs.c:1755: warning: implicit declaration of function `double_lock'
  vfs.c: In function `lento_iopen':
  vfs.c:1935: warning: concatenation of string literals with __FUNCTION__
  is deprecated
  make[2]: *** [vfs.o] Error 1
  make[2]: Leaving directory `/root/linux-2.5.32/fs/intermezzo'
  make[1]: *** [intermezzo] Error 2
  make[1]: Leaving directory `/root/linux-2.5.32/fs'
  make: *** [fs] Error 2
  bash-2.05a# 

i would like to make a patch, but i don't find is_read_only(kdev), and in
Documentation/filesystems/porting, i must to use bdev_read_only(bdev)

---------------- From Documentation/filesystems/porting
[recommended]
    
	    Use bdev_read_only(bdev) instead of is_read_only(kdev).  The latter 
		is still alive, but only because of the mess in drivers/s390/block/dasd.c.
		As soon as it gets fixed is_read_only() will die.
----------------		

	Stephane
On Tue, Aug 27, 2002 at 02:36:26PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Tue, 27 Aug 2002, Stephane Wirtel wrote:
> > a small compile error 
> 
> For a good reason:
> 
> >   i2o_block.c:43:2: #error Please convert me to
> > 	Documentation/DMA-mapping.txt
> 
> Still not done?
> 
> 			Thunder
> -- 
> --./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
> --/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
> .- -/---/--/---/.-./.-./---/.--/.-.-.-
> --./.-/-.../.-./.././.-../.-.-.-
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
