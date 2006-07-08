Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWGHRB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWGHRB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGHRB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:01:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964885AbWGHRB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:01:28 -0400
Date: Sat, 8 Jul 2006 19:01:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [2.6 patch] i386 defconfig: set CONFIG_PM_STD_PARTITION=""
Message-ID: <20060708170128.GI26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox notified me that CONFIG_PM_STD_PARTITION="/dev/hda2" in 
the i386 defconfig wasn't a good idea (especially since it prevented 
booting for him due to another bug).

This patch sets CONFIG_PM_STD_PARTITION="" in the i386 defconfig.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm6-full/arch/i386/defconfig.old	2006-07-08 18:52:13.000000000 +0200
+++ linux-2.6.17-mm6-full/arch/i386/defconfig	2006-07-08 18:52:36.000000000 +0200
@@ -197,7 +197,7 @@
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 CONFIG_SOFTWARE_SUSPEND=y
-CONFIG_PM_STD_PARTITION="/dev/hda2"
+CONFIG_PM_STD_PARTITION=""
 
 #
 # ACPI (Advanced Configuration and Power Interface) Support

