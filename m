Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVBQA0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVBQA0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVBQA0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:26:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:6281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262163AbVBQA0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:26:15 -0500
Date: Wed, 16 Feb 2005 16:26:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] isicom: use NULL for ptr.
Message-Id: <20050216162614.3cd6ce47.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use NULL instead of 0 for pointer value:
drivers/char/isicom.c:1274:14: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/isicom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/char/isicom.c~isicom_null ./drivers/char/isicom.c
--- ./drivers/char/isicom.c~isicom_null	2005-02-15 13:48:45.123493232 -0800
+++ ./drivers/char/isicom.c	2005-02-16 10:57:45.934330560 -0800
@@ -1271,7 +1271,7 @@ static void isicom_shutdown_port(struct 
 	}	
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
-	port->tty = 0;
+	port->tty = NULL;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 	
 	/*Fix done by Anil .S on 30-04-2001


---
