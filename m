Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315572AbSECGgZ>; Fri, 3 May 2002 02:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315573AbSECGgY>; Fri, 3 May 2002 02:36:24 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:5835 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP
	id <S315572AbSECGgV>; Fri, 3 May 2002 02:36:21 -0400
Date: Fri, 3 May 2002 02:39:00 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 -- UFS compile error in fs/ufs/super.c:661: In function `ufs_fill_super': parse error before "uspi"
Mail-Followup-To: Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD22590.5010906@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020503063614.TFZE1257.out010.verizon.net@pool-141-150-238-63.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -DKBUILD_BASENAME=super  -c -o super.o super.c
> super.c: In function `ufs_fill_super':
> super.c:661: parse error before "uspi"
> super.c:666: parse error before "uspi"
> super.c:676: parse error before "uspi"
> super.c:681: parse error before "uspi"
> make[3]: *** [super.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/fs/ufs'

Sorry Miles.  I think the first one was for 2.4.  This one's for 2.5.

--- fs/ufs/super.c.old	Fri May  3 02:34:37 2002
+++ fs/ufs/super.c	Fri May  3 02:35:08 2002
@@ -657,12 +657,12 @@
 			goto failed;
 	}
 	if (uspi->s_fsize < 512) {
-		printk("ufs_read_super: fragment size %u is too small\n"
+		printk("ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_fsize > 4096) {
-		printk("ufs_read_super: fragment size %u is too large\n"
+		printk("ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
 	}
@@ -672,12 +672,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 4096) {
-		printk("ufs_read_super: block size %u is too small\n"
+		printk("ufs_read_super: block size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
-		printk("ufs_read_super: too many fragments per block (%u)\n"
+		printk("ufs_read_super: too many fragments per block (%u)\n",
 			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}

-- 
Skip
