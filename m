Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbQKMXC3>; Mon, 13 Nov 2000 18:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129979AbQKMXCT>; Mon, 13 Nov 2000 18:02:19 -0500
Received: from [209.249.10.20] ([209.249.10.20]:9088 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S129962AbQKMXCG>;
	Mon, 13 Nov 2000 18:02:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 13 Nov 2000 14:31:49 -0800
Message-Id: <200011132231.OAA03240@baldur.yggdrasil.com>
To: tdavis@jps.net
Subject: smc-ircc.c typo in linux-2.4.0-test11-pre4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	linux-2.4.0-test11-pre{3,4}/drivers/net/irda/smc-ircc.c contains
a reference to the undefined symbol smcc_ircc_change_speed.  I guess
this should be a reference to ircc_change_speed.  Because I am not
positive, I am not sending this message directly to Linus, but I
am cc'ing it to linux-kernel.  If I am right or if you have a better
patch, can you please send it to Linus?  Thank you.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.4.0-test11-pre4/drivers/net/irda/smc-ircc.c	Mon Nov 13 13:36:50 2000
+++ linux/drivers/net/irda/smc-ircc.c	Mon Nov 13 13:58:31 2000
@@ -620,7 +620,7 @@
 	if ((speed = irda_get_speed(skb)) != self->io.speed) {
 		/* Check for empty frame */
 		if (!skb->len) {
-			smc_ircc_change_speed(self, speed); 
+			ircc_change_speed(self, speed); 
 			return 0;
 		} else
 			self->new_speed = speed;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
