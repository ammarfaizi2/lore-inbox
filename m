Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131311AbQKQJZC>; Fri, 17 Nov 2000 04:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131263AbQKQJYw>; Fri, 17 Nov 2000 04:24:52 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:1408 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129510AbQKQJYp>; Fri, 17 Nov 2000 04:24:45 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Gnea" <gnea@rochester.rr.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: 240t11p6: NTFS broken (again? :) )
X-Mailer: Pronto v2.2.2
Date: 17 Nov 2000 03:50:42 EST
Reply-To: "Gnea" <gnea@rochester.rr.com>
Message-ID: <20001117084625.AAA13225@mail2.nyroc.rr.com@celery>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling as a module, the following throws a tantrum in my face:

make[2]: Entering directory `/usr/src/linux/fs/ntfs'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
-DNTFS_IN_LINUX_KERNEL -DNTFS_VERSION=\"000607\" -c -o inode.o inode.c
inode.c:1054: conflicting types for `new_inode'
/usr/src/linux/include/linux/fs.h:1153: previous declaration of
`new_inode'
make[2]: *** [inode.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/ntfs'

and proceeds to die.. btw, this is for "make modules".. the kernel
built just fine (tho i haven't booted it yet)

i still suck at C, so this is only a guess (i'll find out if i'm right
or wrong i suppose ;) ), is that you can't static int without a
function prototype for it ... or a static inline can't be a static
int... well whatever the case, i look forward to seeing the fix [and
now it's time for sleep now that i am about to faceplant] ;)

-- 
	.oO gnea at rochester dot rr dot com Oo.
	    .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish" -unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
