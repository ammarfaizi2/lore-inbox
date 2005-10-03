Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVJCVtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVJCVtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVJCVtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:49:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28071 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964781AbVJCVtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:49:12 -0400
Date: Mon, 3 Oct 2005 23:47:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, vojtech@suse.cz
Subject: [zaurus] Fix dependencies on collie keyboard
Message-ID: <20051003214734.GA7511@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes depenencies of collie keyboard.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -93,7 +93,7 @@ config KEYBOARD_LKKBD
 
 config KEYBOARD_LOCOMO
 	tristate "LoCoMo Keyboard Support"
-	depends on SHARP_LOCOMO
+	depends on SHARP_LOCOMO && INPUT_KEYBOARD
 	help
 	  Say Y here if you are running Linux on a Sharp Zaurus Collie or Poodle based PDA
 

-- 
if you have sharp zaurus hardware you don't need... you know my address
