Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTBQXR1>; Mon, 17 Feb 2003 18:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTBQXRG>; Mon, 17 Feb 2003 18:17:06 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17313 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267611AbTBQXOP>;
	Mon, 17 Feb 2003 18:14:15 -0500
Date: Mon, 17 Feb 2003 18:23:50 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] pnp - Trivial Card Service Fix (7/13)
Message-ID: <20030217182350.GA31455@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Ruslan for bringing this to my attention.

Please apply,
Adam


--- a/drivers/pnp/card.c	Sun Feb  9 10:57:43 2003
+++ b/drivers/pnp/card.c	Sun Feb  9 11:05:40 2003
@@ -143,7 +143,6 @@
 	list_for_each_safe(pos,temp,&card->devices){
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
 		pnpc_remove_device(dev);
-		__pnp_remove_device(dev);
 	}
 }
