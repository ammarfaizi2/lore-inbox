Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbTBIQ7I>; Sun, 9 Feb 2003 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTBIQ4E>; Sun, 9 Feb 2003 11:56:04 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:42892 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267300AbTBIQyL>;
	Sun, 9 Feb 2003 11:54:11 -0500
Date: Sun, 9 Feb 2003 12:04:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - Trivial Card Service Fix (7/12) 2.5.59-bk3
Message-ID: <20030209120451.GA20018@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
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
 
