Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271728AbRICPlG>; Mon, 3 Sep 2001 11:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271733AbRICPks>; Mon, 3 Sep 2001 11:40:48 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:10910 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S271728AbRICPkm>;
	Mon, 3 Sep 2001 11:40:42 -0400
Message-Id: <5.1.0.14.2.20010903163857.00a31ca0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Sep 2001 16:40:46 +0100
To: Ben LaHaise <bcrl@redhat.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109031119400.1610-100000@toomuch.toronto.re
 dhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:21 03/09/01, Ben LaHaise wrote:
>Is there any problem with the patch below for reserving a 64 bit get block
>device size ioctl?

Aren't you making a define and then redefining the same define on the next 
line? Perhaps you meant to write "#define BLKBSZGET64 ..."?

Anton

>diff -urN v2.4.10-pre4/include/linux/fs.h work/include/linux/fs.h
>--- v2.4.10-pre4/include/linux/fs.h     Mon Sep  3 11:04:39 2001
>+++ work/include/linux/fs.h     Mon Sep  3 11:18:44 2001
>@@ -182,7 +182,8 @@
>  /* This was here just to show that the number is taken -
>     probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
>  #endif
>-/* A jump here: 108-111 have been used for various private purposes. */
>+/* A jump here: 108,109,111 have been used for various private purposes. */
>+#define BLKBSZGET  _IOR(0x12,110,sizeof(u64))
>  #define BLKBSZGET  _IOR(0x12,112,sizeof(int))
>  #define BLKBSZSET  _IOW(0x12,113,sizeof(int))
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

