Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVEFXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVEFXpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEFX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:26:40 -0400
Received: from mail.dif.dk ([193.138.115.101]:12753 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261330AbVEFXPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:15:17 -0400
Date: Sat, 7 May 2005 01:19:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Ken Pizzini <ken@halcyon.com>, Ron Jeppesen <ronj.an@site007.saic.com>,
       Corey Minyard <minyard@wf-rch.cirr.com>, akpm@osdl.org
Subject: [PATCH] remove pointless NULL check before kfree in sony535.c
Message-ID: <Pine.LNX.4.62.0505070114160.2384@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check for NULL, kfree() can cope.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/cdrom/sonycd535.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.12-rc3-mm3-orig/drivers/cdrom/sonycd535.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/cdrom/sonycd535.c	2005-05-07 01:13:30.000000000 +0200
@@ -1605,7 +1605,6 @@ out7:
 	put_disk(cdu_disk);
 out6:
 	for (i = 0; i < sony_buffer_sectors; i++)
-		if (sony_buffer[i]) 
 			kfree(sony_buffer[i]);
 out5:
 	kfree(sony_buffer);


