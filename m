Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVCSNwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVCSNwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCSNwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:52:16 -0500
Received: from coderock.org ([193.77.147.115]:53384 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262563AbVCSNUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:20:02 -0500
Subject: [patch 1/1] printk : drivers/char/watchdog/wdt285.c
To: wim@iguana.be
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, clucas@rotomalug.org
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:19:54 +0100
Message-Id: <20050319131954.B30681F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/watchdog/wdt285.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/watchdog/wdt285.c~printk-drivers_char_watchdog_wdt285 drivers/char/watchdog/wdt285.c
--- kj/drivers/char/watchdog/wdt285.c~printk-drivers_char_watchdog_wdt285	2005-03-18 20:05:42.000000000 +0100
+++ kj-domen/drivers/char/watchdog/wdt285.c	2005-03-18 20:05:42.000000000 +0100
@@ -204,11 +204,11 @@ static int __init footbridge_watchdog_in
 	if (retval < 0)
 		return retval;
 
-	printk("Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n",
+	printk(KERN_INFO "Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n",
 	       soft_margin);
 
 	if (machine_is_cats())
-		printk("Warning: Watchdog reset may not work on this machine.\n");
+		printk(KERN_WARNING "Warning: Watchdog reset may not work on this machine.\n");
 	return 0;
 }
 
_
