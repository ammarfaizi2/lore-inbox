Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTK1C0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTK1C0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:26:39 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:42448 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261930AbTK1CZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:25:58 -0500
Message-Id: <6.0.0.22.2.20031128132414.01b15568@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Fri, 28 Nov 2003 13:26:17 +1100
To: linux-kernel@vger.kernel.org
From: Peter Lieverdink <linux@cafuego.net>
Subject: include/linux/skbuff.h Typo
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.0-test11 (PPC) errors out on line 844 of skbuff.h. I'm 
guessing the following patch makes it do what it should.

- Peter.


--- linux-2.6.0-test11/include/linux/skbuff_orig.h      2003-11-28 
13:22:47.892405000 +1100
+++ linux-2.6.0-test11/include/linux/skbuff.h   2003-11-28 
13:20:02.142405000 +1100
@@ -841,7 +841,7 @@
         SKB_LINEAR_ASSERT(skb);
         skb->tail += len;
         skb->len  += len;
-       if (unlikely(skb=>tail>skb->end))
+       if (unlikely(skb->tail > skb->end))
                 skb_over_panic(skb, len, current_text_addr());
         return tmp;
  }

