Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSCRX0S>; Mon, 18 Mar 2002 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSCRX0I>; Mon, 18 Mar 2002 18:26:08 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:21645 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S293276AbSCRXZz>; Mon, 18 Mar 2002 18:25:55 -0500
Message-ID: <3C967758.1010102@didntduck.org>
Date: Mon, 18 Mar 2002 18:25:12 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: 2.5.7 hfs modules compil error
In-Reply-To: <20020318215221.GA942@ulima.unil.ch>
Content-Type: multipart/mixed;
 boundary="------------050401040509010909060806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401040509010909060806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gregoire Favre wrote:
> Hello,
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE
> -DKBUILD_BASENAME=super  -c -o super.o super.c
> super.c: In function `hfs_fill_super':
> super.c:536: `sb' undeclared (first use in this function)

Typo fixed.

-- 

						Brian Gerst

--------------050401040509010909060806
Content-Type: text/plain;
 name="sb-hfs-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-hfs-2"

diff -urN linux-2.5.7/fs/hfs/super.c linux/fs/hfs/super.c
--- linux-2.5.7/fs/hfs/super.c	Mon Mar 18 16:14:15 2002
+++ linux/fs/hfs/super.c	Mon Mar 18 17:06:11 2002
@@ -533,7 +533,7 @@
 	set_blocksize(dev, BLOCK_SIZE);
 bail3:
 	kfree(sbi);
-	sb->u.generic_sbp = NULL;
+	s->u.generic_sbp = NULL;
 	return -EINVAL;	
 }
 

--------------050401040509010909060806--

