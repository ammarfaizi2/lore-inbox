Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSFITQ6>; Sun, 9 Jun 2002 15:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSFITQ5>; Sun, 9 Jun 2002 15:16:57 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:37286 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314690AbSFITQ4>; Sun, 9 Jun 2002 15:16:56 -0400
Date: Sun, 9 Jun 2002 13:16:55 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: About new list commands and emu10k1
Message-ID: <Pine.LNX.4.44.0206091315290.8715-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I couldn't reach the emu10k1 guys for some obscure reason. I had a patch
which sounded like this:

--- linus-2.5/sound/pci/emu10k1/memory.c	Sun Jun  9 04:18:03 2002
+++ thunder-2.5/sound/pci/emu10k1/memory.c	Sun Jun  9 07:47:37 2002
@@ -259,8 +259,7 @@
 	spin_lock_irqsave(&emu->memblk_lock, flags);
 	if (blk->mapped_page >= 0) {
 		/* update order link */
-		list_del(&blk->mapped_order_link);
-		list_add_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
+		list_move_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
 		spin_unlock_irqrestore(&emu->memblk_lock, flags);
 		return 0;
 	}

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

