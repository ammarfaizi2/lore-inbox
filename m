Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136242AbRAGSEw>; Sun, 7 Jan 2001 13:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136281AbRAGSEm>; Sun, 7 Jan 2001 13:04:42 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:26710 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S136242AbRAGSEZ>; Sun, 7 Jan 2001 13:04:25 -0500
Date: Sun, 7 Jan 2001 13:06:18 -0500 (EST)
From: stewart@neuron.com
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] typo in vesafb.c (against 2.4.0-ac3)
Message-ID: <Pine.LNX.4.10.10101071302450.1961-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this looks like a typo and fixes a compile error in
2.4.0-ac3.


--- drivers/video/vesafb.c.old	Sun Jan  7 12:18:13 2001
+++ drivers/video/vesafb.c	Sun Jan  7 12:18:23 2001
@@ -637,7 +637,7 @@
 		int temp_size = video_size;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
-                	temp_sze &= (temp_size - 1);
+                	temp_size &= (temp_size - 1);
                         
                 /* Try and find a power of two to add */
 		while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
