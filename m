Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJUVp>; Wed, 10 Jan 2001 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131948AbRAJUVf>; Wed, 10 Jan 2001 15:21:35 -0500
Received: from [200.199.222.5] ([200.199.222.5]:22546 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S129431AbRAJUVV>; Wed, 10 Jan 2001 15:21:21 -0500
Date: Wed, 10 Jan 2001 16:24:21 -0200 (BRST)
From: Thiago Rondon <maluco@mileniumnet.com.br>
To: dahinds@users.sourceforge.net
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <Pine.LNX.4.21.0101101623150.4170-100000@freak.mileniumnet.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check kmalloc().

-Thiago Rondon

--- linux-2.4.0-ac5/drivers/pcmcia/ds.c	Sat Sep  2 04:13:49 2000
+++ linux-2.4.0-ac5.maluco/drivers/pcmcia/ds.c	Wed Jan 10 16:20:53 2001
@@ -414,6 +414,8 @@
     /* Add binding to list for this socket */
     driver->use_count++;
     b = kmalloc(sizeof(socket_bind_t), GFP_KERNEL);
+    if (!b) 
+      return -ENOMEM;    
     b->driver = driver;
     b->function = bind_info->function;
     b->instance = NULL;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
