Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVAWHEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVAWHEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVAWHEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:04:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:29874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261237AbVAWHEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:04:20 -0500
Date: Sat, 22 Jan 2005 22:51:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] isicom: use NULL for pointer
Message-Id: <20050122225113.3d992b5c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use NULL instead of 0 for pointer:

drivers/char/isicom.c:1274:14: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/isicom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/char/isicom.c~isicom_null ./drivers/char/isicom.c
--- ./drivers/char/isicom.c~isicom_null	2005-01-22 19:06:30.382664240 -0800
+++ ./drivers/char/isicom.c	2005-01-22 21:49:50.077884120 -0800
@@ -1271,7 +1271,7 @@ static void isicom_shutdown_port(struct 
 	}	
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
-	port->tty = 0;
+	port->tty = NULL;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 	
 	/*Fix done by Anil .S on 30-04-2001


--
