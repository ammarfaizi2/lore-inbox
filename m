Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWDAP3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWDAP3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 10:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWDAP3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 10:29:42 -0500
Received: from host-84-9-202-240.bulldogdsl.com ([84.9.202.240]:13760 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750701AbWDAP3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 10:29:41 -0500
Date: Sat, 1 Apr 2006 16:29:41 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: rpurdie@rpsys.net, akpm@osdl.org
Subject: [LEDS] fix IDE disk trigger name
Message-ID: <20060401152941.GA11333@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The IDE Disk LED trigger has the same name
as the timer trigger.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="leds-fix-idetrigger.patch"

diff -urpN -X ../dontdiff linux-2.6.16-git20-bjd1/drivers/leds/Kconfig linux-2.6.16-git20-bjd2/drivers/leds/Kconfig
--- linux-2.6.16-git20-bjd1/drivers/leds/Kconfig	2006-04-01 14:09:34.000000000 +0100
+++ linux-2.6.16-git20-bjd2/drivers/leds/Kconfig	2006-04-01 14:49:22.000000000 +0100
@@ -74,7 +74,7 @@ config LEDS_TRIGGER_TIMER
 	  via sysfs. If unsure, say Y.
 
 config LEDS_TRIGGER_IDE_DISK
-	bool "LED Timer Trigger"
+	bool "LED IDE Disk Trigger"
 	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
 	help
 	  This allows LEDs to be controlled by IDE disk activity.

--+QahgC5+KEYLbs62--
