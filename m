Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317676AbSFLJdz>; Wed, 12 Jun 2002 05:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317677AbSFLJdy>; Wed, 12 Jun 2002 05:33:54 -0400
Received: from ccs.covici.com ([209.249.181.196]:25729 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S317676AbSFLJdx>;
	Wed, 12 Jun 2002 05:33:53 -0400
To: linux-kernel@vger.kernel.org
Subject: bio.h problem in kernel 2.5.21
From: John Covici <covici@ccs.covici.com>
Date: Wed, 12 Jun 2002 05:33:53 -0400
Message-ID: <m3fzzssuwu.fsf@ccs.covici.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc.c seems to have a problem with bio.h -- at least all the
errors are in there in 2.5.21.

Any assistance would be appreciated.

  gcc -Wp,-MD,.vmalloc.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vmalloc   -c -o vmalloc.o vmalloc.c
In file included from /usr/src/linux-2.5.21/include/linux/highmem.h:5,
                 from vmalloc.c:13:
/usr/src/linux-2.5.21/include/linux/bio.h:90: parse error before `atomic_t'
/usr/src/linux-2.5.21/include/linux/bio.h:90: warning: no semicolon at end of struct or union
/usr/src/linux-2.5.21/include/linux/bio.h:95: parse error before `}'
make[2]: *** [vmalloc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.21/mm'
make[1]: *** [mm] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.21'
make: *** [make_with_config] Error 2

-- 
         John Covici
         covici@ccs.covici.com
