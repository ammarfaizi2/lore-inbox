Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTEIW7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTEIW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:59:44 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:52116 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263568AbTEIW7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:59:43 -0400
Message-Id: <200305092310.h49NAnGi011053@locutus.cmf.nrl.navy.mil>
To: Patrick McHardy <kaber@trash.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix kfree(skb) in iphase driver 
In-reply-to: Your message of "Thu, 08 May 2003 23:58:09 +0200."
             <3EBAD2F1.9090802@trash.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 09 May 2003 19:10:49 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3EBAD2F1.9090802@trash.net>,Patrick McHardy writes:
>This patch fixes a kfree(skb) in the iphase driver.

what release is this against?

>diff -Nru a/drivers/atm/iphase.c b/drivers/atm/iphase.c
>--- a/drivers/atm/iphase.c	Thu May  8 23:56:27 2003
>+++ b/drivers/atm/iphase.c	Thu May  8 23:56:27 2003
>@@ -2965,7 +2965,7 @@
> 	                 dev_kfree_skb_any(skb);
> 	           return 0;
> 	   }
>-	   kfree(skb);
>+	   dev_kfree_skb_any(skb);
> 	   skb = newskb;
>         }       
> 	/* Get a descriptor number from our free descriptor queue  
>
