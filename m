Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSE2Ldr>; Wed, 29 May 2002 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSE2Ldq>; Wed, 29 May 2002 07:33:46 -0400
Received: from cm16094.red.mundo-r.com ([213.60.16.94]:42625 "EHLO demo.mitica")
	by vger.kernel.org with ESMTP id <S315091AbSE2Ldp>;
	Wed, 29 May 2002 07:33:45 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, ncorbic@sangoma.com
Subject: fix to sdla_fr.c
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 29 May 2002 13:39:56 +0200
Message-ID: <m2wutntc6r.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        this has been broken since -pre8.
        Could you apply, it appears to be a MIME thing, or similar.

For some reason, there was some s/%u/%U/.

Please, apply.

Later, Juan.

diff -u linux/drivers/net/wan/sdla_fr.c.orig linux/drivers/net/wan/sdla_fr.c
--- linux/drivers/net/wan/sdla_fr.c.orig	2002-05-07 15:14:29.000000000 +0200
+++ linux/drivers/net/wan/sdla_fr.c	2002-05-07 15:17:52.000000000 +0200
@@ -2815,7 +2815,7 @@
 				chan->name, NIPQUAD(chan->ip_remote));
 
 		}else {
-			printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%U\n",
+			printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%u\n",
 				card->devname,NIPQUAD(chan->ip_remote));
 			chan->route_flag = ROUTE_ADDED;
 		}
@@ -4348,9 +4348,9 @@
 					card->devname,NIPQUAD(arphdr->ar_sip));
 
 			printk(KERN_INFO "%s: mask %u.%u.%u.%u\n", 
-				card->devname, NIPQUAD(in_dev->ida_list->ifa_mask));
+				card->devname, NIPQUAD(in_dev->ifa_list->ifa_mask));
 				printk(KERN_INFO "%s: local %u.%u.%u.%u\n", 
-				card->devname,NIPQUAD(in_dev->ida_list->ifa_local));
+				card->devname,NIPQUAD(in_dev->ifa_list->ifa_local));
 			return -1;
 		}
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
