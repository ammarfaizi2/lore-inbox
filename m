Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQKMXFJ>; Mon, 13 Nov 2000 18:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbQKMXE7>; Mon, 13 Nov 2000 18:04:59 -0500
Received: from [209.249.10.20] ([209.249.10.20]:21121 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129609AbQKMXEl>; Mon, 13 Nov 2000 18:04:41 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 13 Nov 2000 14:34:35 -0800
Message-Id: <200011132234.OAA03249@baldur.yggdrasil.com>
To: james@fishsoupo.dhs.org
Subject: toshoboe.c typo in linux-2.4.0-test11-pre4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.0-test11-pre{3,4}/drivers/net/irda/toshoboe.c contains
a reference to the undefined symbol toshoboe_change_speed.  I guess
this should be a reference to toshoboe_setbaud.  Because I am not
positive, I am not sending this message directly to Linus, but I
am cc'ing it to linux-kernel.  If I am right or if you have a better
patch, can you please send it to Linus?  Thank you.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.0-test11-pre4/drivers/net/irda/toshoboe.c	Mon Nov 13 13:36:50 2000
+++ linux/drivers/net/irda/toshoboe.c	Mon Nov 13 13:57:32 2000
@@ -275,7 +275,7 @@
   if ((speed = irda_get_speed(skb)) != self->io.speed) {
 	/* Check for empty frame */
 	if (!skb->len) {
-	    toshoboe_change_speed(self, speed); 
+	    toshoboe_setbaud(self, speed); 
 	    return 0;
 	} else
 	    self->new_speed = speed;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
