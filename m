Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVA3Qwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVA3Qwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVA3Qwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:52:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:10940 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261728AbVA3Qvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:51:54 -0500
Date: Sun, 30 Jan 2005 17:55:17 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] tiny warning fix in drivers/cdrom/mcd.c
Message-ID: <Pine.LNX.4.62.0501301750060.2731@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small patch to fix this warning : 
drivers/cdrom/mcd.c:268: warning: passing arg 1 of `mcd_setup' discards qualifiers from pointer target type

Yes, the driver is ancient, but that's no reason to not fix warnings :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc2-bk7-orig/drivers/cdrom/mcd.c	2005-01-22 21:59:31.000000000 +0100
+++ linux-2.6.11-rc2-bk7/drivers/cdrom/mcd.c	2005-01-30 17:47:33.000000000 +0100
@@ -244,7 +244,7 @@ static struct block_device_operations mc
 
 static struct gendisk *mcd_gendisk;
 
-static int __init mcd_setup(char *str)
+static int __init mcd_setup(const char *str)
 {
 	int ints[9];
 



