Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbULXA4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbULXA4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULXA4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:56:04 -0500
Received: from mail.dif.dk ([193.138.115.101]:16069 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261349AbULXA4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:56:00 -0500
Date: Fri, 24 Dec 2004 02:06:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Carsten Paeth <calle@calle.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove unused variable in b1pcmcia.c::b1pcmcia_init()
Message-ID: <Pine.LNX.4.61.0412240203320.3504@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Tiny patch below to remove an unused variable in b1pcmcia.c::b1pcmcia_init()

drivers/isdn/hardware/avm/b1pcmcia.c:203: warning: unused variable `err'


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk16-orig/drivers/isdn/hardware/avm/b1pcmcia.c linux-2.6.10-rc3-bk16/drivers/isdn/hardware/avm/b1pcmcia.c
--- linux-2.6.10-rc3-bk16-orig/drivers/isdn/hardware/avm/b1pcmcia.c	2004-10-18 23:53:05.000000000 +0200
+++ linux-2.6.10-rc3-bk16/drivers/isdn/hardware/avm/b1pcmcia.c	2004-12-24 02:03:23.000000000 +0100
@@ -200,7 +200,6 @@ static int __init b1pcmcia_init(void)
 {
 	char *p;
 	char rev[32];
-	int err;
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
 		strlcpy(rev, p + 2, 32);


