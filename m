Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272817AbTHKQwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272816AbTHKQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:50:29 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1369 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272817AbTHKQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:31 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AD1848 claims a card it shouldn't.
Message-Id: <E19mFqr-00068Z-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/ad1848.c linux-2.5/sound/oss/ad1848.c
--- bk-linus/sound/oss/ad1848.c	2003-04-22 00:40:44.000000000 +0100
+++ linux-2.5/sound/oss/ad1848.c	2003-04-22 01:23:16.000000000 +0100
@@ -2971,8 +2971,10 @@ static struct isapnp_device_id id_table[
 		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0000), 0 },
         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100), 0 },
+	/* The main driver for this card is opl3sa2
         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021), 0 },
+	*/
 	{	ISAPNP_VENDOR('G','R','V'), ISAPNP_DEVICE(0x0001),
 		ISAPNP_VENDOR('G','R','V'), ISAPNP_FUNCTION(0x0000), 0 },
 	{0}
