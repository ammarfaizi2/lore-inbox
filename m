Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284200AbRLATMW>; Sat, 1 Dec 2001 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284202AbRLATMN>; Sat, 1 Dec 2001 14:12:13 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:30394 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S284200AbRLATMA>;
	Sat, 1 Dec 2001 14:12:00 -0500
Date: Sat, 1 Dec 2001 20:11:54 +0100
From: Francois Romieu <romieu@mail.cogenit.fr>
To: Frank Jacobberger <f1j@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: More problems with 2.5.0-pre5 than pre4
Message-ID: <20011201201154.E32339@se1.cogenit.fr>
In-Reply-To: <3C0860DB.60905@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0860DB.60905@xmission.com>; from f1j@xmission.com on Fri, Nov 30, 2001 at 09:47:23PM -0700
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Jacobberger <f1j@xmission.com> :
> What do you make of this from a attempted compile of 2.5.0-pre5:
[...]

diff -burN -p linux-2.5.1-pre5.orig/drivers/block/rd.c linux-2.5.1-pre5/drivers/block/rd.c
--- linux-2.5.1-pre5.orig/drivers/block/rd.c	Sat Dec  1 18:12:17 2001
+++ linux-2.5.1-pre5/drivers/block/rd.c	Sat Dec  1 18:43:06 2001
@@ -485,7 +485,6 @@ static struct block_device_operations rd
 	ioctl:		rd_ioctl,
 };
 
-#ifdef MODULE
 /* Before freeing the module, invalidate all of the protected buffers! */
 static void __exit rd_cleanup (void)
 {
@@ -503,7 +502,6 @@ static void __exit rd_cleanup (void)
 	unregister_blkdev( MAJOR_NR, "ramdisk" );
 	blk_clear(MAJOR_NR);
 }
-#endif
 
 /* This is the registration and initialization section of the RAM disk driver */
 int __init rd_init (void)

