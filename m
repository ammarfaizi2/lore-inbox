Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274188AbRISVGP>; Wed, 19 Sep 2001 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274189AbRISVGF>; Wed, 19 Sep 2001 17:06:05 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:41756 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274188AbRISVF4>; Wed, 19 Sep 2001 17:05:56 -0400
Subject: [PATCH] Re: 2.4.10p12 strange patch for drivers/net/starfire.c
From: Robert Love <rml@ufl.edu>
To: torvalds@transmeta.com, Ward Fenton <ward@amazingmedia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0109191626190.14038-100000@bambam.amazingmedia.com>
In-Reply-To: <Pine.LNX.4.21.0109191626190.14038-100000@bambam.amazingmedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 19 Sep 2001 17:07:15 -0400
Message-Id: <1000933640.2741.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-09-19 at 16:35, Ward Fenton wrote:
> It seems that something went wrong with the starfire.c patch. The first
> printk statement in the portion of the patch below is a syntax error.

Hm, indeed.  A patch is attached... Linus, please apply.


diff -urN linux-2.4.10-pre12/drivers/net/starfire.c linux/drivers/net/starfire.c
--- linux-2.4.10-pre12/drivers/net/starfire.c	Wed Sep 19 02:53:15 2001
+++ linux/drivers/net/starfire.c	Wed Sep 19 17:04:44 2001
@@ -770,7 +770,7 @@
 
 #ifdef ZEROCOPY
 	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming enabled.\n",
-	       dev->name,
+	       dev->name);
 #else  /* not ZEROCOPY */
 	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming disabled.\n",
 	       dev->name);


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

