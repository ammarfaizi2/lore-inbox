Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTA2GKO>; Wed, 29 Jan 2003 01:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTA2GKO>; Wed, 29 Jan 2003 01:10:14 -0500
Received: from h00609772adf0.ne.client2.attbi.com ([24.61.43.152]:34497 "EHLO
	h00609772adf0.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id <S264853AbTA2GKN>; Wed, 29 Jan 2003 01:10:13 -0500
Date: Wed, 29 Jan 2003 01:19:51 -0500
From: Craig Rodrigues <rodrigc@attbi.com>
To: zwane@commfireservices.com
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.59] sc1200wdt.c, isapnp_find_device -> pnp_find_device
Message-ID: <20030129061951.GA8174@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch renames isapnp_find_device() to pnp_find_device(),
since isapnp_find_device() doesn't exist in the 2.5.59 kernel.

--- drivers/char/watchdog/sc1200wdt.c.orig	Wed Jan 29 00:47:50 2003
+++ drivers/char/watchdog/sc1200wdt.c	Wed Jan 29 00:47:53 2003
@@ -335,7 +335,7 @@
 	int ret;
 
 	/* The WDT is logical device 8 on the main device */
-	wdt_dev = isapnp_find_dev(NULL, ISAPNP_VENDOR('N','S','C'), ISAPNP_FUNCTION(0x08), NULL);
+	wdt_dev = pnp_find_dev(NULL, ISAPNP_VENDOR('N','S','C'), ISAPNP_FUNCTION(0x08), NULL);
 	if (!wdt_dev)
 		return -ENODEV;
 	


-- 
Craig Rodrigues        
http://home.attbi.com/~rodrigc
rodrigc@attbi.com
