Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbREQHzI>; Thu, 17 May 2001 03:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbREQHy5>; Thu, 17 May 2001 03:54:57 -0400
Received: from mx5.port.ru ([194.67.23.40]:23306 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S261334AbREQHyw>;
	Thu, 17 May 2001 03:54:52 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] missing adlib release region
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.8]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E150IcL-0003v5-00@f4.mail.ru>
Date: Thu, 17 May 2001 11:54:41 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    i know, adlib_card is just a stupid interface, but
 i once was hit by this problem ;).

--- linux-2.4.4.orig/drivers/sound/adlib_card.c Fri May 11 22:42:55 2001
+++ linux-2.4.4/drivers/sound/adlib_card.c      Thu May 17 11:39:04 2001
@@ -50,6 +50,7 @@

 static void __exit cleanup_adlib(void)
 {
+       release_region(cfg.io_base,4);
        sound_unload_synthdev(cfg.slots[0]);

 }

