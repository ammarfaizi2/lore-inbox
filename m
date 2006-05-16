Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWEPLqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWEPLqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWEPLqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:46:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5651 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751795AbWEPLqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:46:43 -0400
Date: Tue, 16 May 2006 13:46:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix the MD_RAID5_RESHAPE dependencies
Message-ID: <20060516114641.GM6931@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a new option gets added whose dependencies can't be fulfilled this 
could be an indication that improvements are possible in the field of 
patch testing...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc4-mm1-full/drivers/md/Kconfig.old	2006-05-16 12:38:44.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/md/Kconfig	2006-05-16 12:39:02.000000000 +0200
@@ -137,7 +137,7 @@
 
 config MD_RAID5_RESHAPE
 	bool "Support adding drives to a raid-5 array (experimental)"
-	depends on MD_RAID5 && EXPERIMENTAL
+	depends on MD_RAID456 && EXPERIMENTAL
 	---help---
 	  A RAID-5 set can be expanded by adding extra drives. This
 	  requires "restriping" the array which means (almost) every

