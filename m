Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWDQOwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWDQOwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDQOwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:52:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29451 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751060AbWDQOwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:52:15 -0400
Date: Mon, 17 Apr 2006 16:52:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] show Acorn-specific block devices menu only when required
Message-ID: <20060417145214.GD7429@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't show a menu that can't be entered due to lack of contents on arm
(the options are only available on arm26).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig.old	2006-04-17 16:40:13.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig	2006-04-17 16:40:50.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Acorn-specific block devices"
-	depends on ARCH_ACORN
+	depends on ARCH_ARC || ARCH_A5K
 
 config BLK_DEV_FD1772
 	tristate "Old Archimedes floppy (1772) support"

