Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVCXI2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVCXI2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVCXI2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:28:03 -0500
Received: from apate.telenet-ops.be ([195.130.132.57]:45011 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262713AbVCXI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:27:58 -0500
Date: Thu, 24 Mar 2005 09:27:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, clucas@rotomalug.org, domen@coderock.org
Subject: [WATCHDOG] wdt285.c-printk-patch
Message-ID: <20050324082743.GF4909@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/wdt285.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/03/24 1.2191)
   [WATCHDOG] wdt285.c-printk-patch
   
   printk() calls should include appropriate KERN_* constant.
                                                                                                    
   Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/wdt285.c b/drivers/char/watchdog/wdt285.c
--- a/drivers/char/watchdog/wdt285.c	2005-03-24 09:23:57 +01:00
+++ b/drivers/char/watchdog/wdt285.c	2005-03-24 09:23:57 +01:00
@@ -204,11 +204,11 @@
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
 
