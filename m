Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274169AbRISUfZ>; Wed, 19 Sep 2001 16:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274176AbRISUfG>; Wed, 19 Sep 2001 16:35:06 -0400
Received: from bambam.amazingmedia.com ([192.245.235.57]:20013 "HELO
	bambam.amazingmedia.com") by vger.kernel.org with SMTP
	id <S274169AbRISUfB>; Wed, 19 Sep 2001 16:35:01 -0400
Date: Wed, 19 Sep 2001 16:35:20 -0400 (EDT)
From: Ward Fenton <ward@amazingmedia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10p12 strange patch for drivers/net/starfire.c
Message-ID: <Pine.LNX.4.21.0109191626190.14038-100000@bambam.amazingmedia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that something went wrong with the starfire.c patch. The first
printk statement in the portion of the patch below is a syntax error.

diff -u --recursive --new-file v2.4.9/linux/drivers/net/starfire.c linux/drivers/net/starfire.c
--- v2.4.9/linux/drivers/net/starfire.c	Sun Aug 12 13:27:59 2001
+++ linux/drivers/net/starfire.c	Fri Sep  7 09:28:38 2001
[skipping about 100 lines]

@@ -768,6 +768,14 @@
 		np->phy_cnt = phy_idx;
 	}
 
+#ifdef ZEROCOPY
+	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming enabled.\n",
+	       dev->name,
+#else  /* not ZEROCOPY */
+	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming disabled.\n",
+	       dev->name);
+#endif /* not ZEROCOPY */
+
 	return 0;
 
 err_out_cleardev:

[patch continues]

