Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267502AbSKQNoB>; Sun, 17 Nov 2002 08:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbSKQNoB>; Sun, 17 Nov 2002 08:44:01 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:23309 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267502AbSKQNoA>; Sun, 17 Nov 2002 08:44:00 -0500
Date: Sun, 17 Nov 2002 11:50:47 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Helge Hafting <helge.hafting@broadpark.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-bk6  hugetlbfs didn't compile
Message-ID: <20021117135047.GH28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Helge Hafting <helge.hafting@broadpark.no>,
	linux-kernel@vger.kernel.org
References: <3DD795AA.B7CB569B@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD795AA.B7CB569B@broadpark.no>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 17, 2002 at 02:12:10PM +0100, Helge Hafting escreveu:
> Here's the compile failure

Hi posted a fix for this one, its just a matter of adding

#include <linux/mount.h> 

in this file.

- Arnaldo
 
> make -f scripts/Makefile.build obj=fs/hugetlbfs
>   gcc -Wp,-MD,fs/hugetlbfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
> -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=hugetlbfs   -c -o
> fs/hugetlbfs/inode.o fs/hugetlbfs/inode.c
> fs/hugetlbfs/inode.c: In function `hugetlb_zero_setup':
> fs/hugetlbfs/inode.c:531: dereferencing pointer to incomplete type
> fs/hugetlbfs/inode.c:553: warning: implicit declaration of function
> `mntget'
> fs/hugetlbfs/inode.c:553: warning: assignment makes pointer from integer
> without a cast
> fs/hugetlbfs/inode.c:521: warning: `root' might be used uninitialized in
> this function
> make[2]: *** [fs/hugetlbfs/inode.o] Error 1
> make[1]: *** [fs/hugetlbfs] Error 2
> make: *** [fs] Error 2
> 
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
