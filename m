Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAJUUp>; Wed, 10 Jan 2001 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJUU1>; Wed, 10 Jan 2001 15:20:27 -0500
Received: from [200.199.222.5] ([200.199.222.5]:20498 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S129903AbRAJUUW>; Wed, 10 Jan 2001 15:20:22 -0500
Date: Wed, 10 Jan 2001 16:23:14 -0200 (BRST)
From: Thiago Rondon <maluco@mileniumnet.com.br>
To: dahinds@users.sourceforge.net
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] drivers/pcmcia/cs.c
Message-ID: <Pine.LNX.4.21.0101101622210.4170-100000@freak.mileniumnet.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check kmalloc().

-Thiago Rondon

--- linux-2.4.0-ac5/drivers/pcmcia/cs.c	Fri Dec 29 20:35:47 2000
+++ linux-2.4.0-ac5.maluco/drivers/pcmcia/cs.c	Wed Jan 10 16:18:11 2001
@@ -1458,6 +1458,8 @@
 	    s->functions = 1;
 	s->config = kmalloc(sizeof(config_t) * s->functions,
 			    GFP_KERNEL);
+	if (!s->config) 
+		return CS_OUT_OF_RESOURCE;
 	memset(s->config, 0, sizeof(config_t) * s->functions);
     }
     


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
