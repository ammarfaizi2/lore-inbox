Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319423AbSH2WFF>; Thu, 29 Aug 2002 18:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319410AbSH2VzY>; Thu, 29 Aug 2002 17:55:24 -0400
Received: from smtpout.mac.com ([204.179.120.85]:58592 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319409AbSH2Vys>;
	Thu, 29 Aug 2002 17:54:48 -0400
Message-Id: <200208292159.g7TLxBKN026834@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 41/41 sound/oss/via82cxxx_audio.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/via82cxxx_audio.c	Sat Aug 10 00:05:11 2002
+++ linux-2.5-cli-oss/sound/oss/via82cxxx_audio.c	Sat Aug 10 19:27:46 2002
@@ -821,7 +821,7 @@
 
 	spin_unlock_irq (&card->lock);
 
-	synchronize_irq();
+	synchronize_irq(card->pdev->irq);
 
 	DPRINTK ("EXIT\n");
 }

