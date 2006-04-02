Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWDBKhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWDBKhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDBKhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:37:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39116 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932308AbWDBKhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:37:31 -0400
Date: Sun, 2 Apr 2006 12:37:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix LED help text
Message-ID: <20060402103719.GA2475@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TRIGGER_IDE_DISK is not really timer-based LED.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 2c4f20b..c02ef24 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -67,7 +67,7 @@ config LEDS_TRIGGER_TIMER
 	  via sysfs. If unsure, say Y.
 
 config LEDS_TRIGGER_IDE_DISK
-	bool "LED Timer Trigger"
+	bool "LED IDE Disk Trigger"
 	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
 	help
 	  This allows LEDs to be controlled by IDE disk activity.

-- 
Picture of sleeping (Linux) penguin wanted...
