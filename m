Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLEQYJ>; Tue, 5 Dec 2000 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLEQYB>; Tue, 5 Dec 2000 11:24:01 -0500
Received: from web.sajt.cz ([212.71.160.9]:32528 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129324AbQLEQXo>;
	Tue, 5 Dec 2000 11:23:44 -0500
Date: Tue, 5 Dec 2000 16:51:37 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sim710.c compiler warning
Message-ID: <Pine.LNX.4.21.0012051648050.10673-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sim710.c: In function `sim710_detect':
sim710.c:1452: warning: comparison between pointer and integer


--- drivers/scsi/sim710.c.old	Tue Dec  5 15:34:00 2000
+++ drivers/scsi/sim710.c	Tue Dec  5 15:37:18 2000
@@ -1449,7 +1449,7 @@
 
     for(indx = 0; indx < no_of_boards; indx++) {
         unsigned long page = __get_free_pages(GFP_ATOMIC, order);
-        if(page == NULL)
+        if( !page )
         {
         	printk(KERN_WARNING "sim710: out of memory registering board %d.\n", indx);
         	break;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
