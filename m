Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUFIBj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUFIBj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 21:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUFIBj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 21:39:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:25766 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265361AbUFIBj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 21:39:26 -0400
Date: Wed, 9 Jun 2004 03:38:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
Message-ID: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To kill this warning :

drivers/ide/ide.c: In function `ide_unregister_subdriver':
drivers/ide/ide.c:2216: warning: implicit declaration of function `pnpide_init'

I added a simple declaration of pnpide_init to drivers/ide/ide.c

Here's a patch against 2.6.7-rc3 - please consider including it (or if
that's not the way to do it, then don't) :)


--- linux-2.6.7-rc3-orig/drivers/ide/ide.c	2004-06-09 03:34:49.000000000 +0200
+++ linux-2.6.7-rc3/drivers/ide/ide.c	2004-06-09 03:31:29.000000000 +0200
@@ -198,6 +198,7 @@ EXPORT_SYMBOL(ide_hwifs);

 extern ide_driver_t idedefault_driver;
 static void setup_driver_defaults(ide_driver_t *driver);
+void pnpide_init(int enable);

 /*
  * Do not even *think* about calling this!


--
Jesper Juhl <juhl-lkml@dif.dk>

