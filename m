Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVE0MyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVE0MyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVE0MyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:54:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15798 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262457AbVE0MyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:54:01 -0400
Date: Fri, 27 May 2005 14:08:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] swsusp: properly freeze aic79xx thread
Message-ID: <20050527120831.GC2088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in aic79xx. It wants it thread not to be frozen, but does
something stupid instead.

From: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit a871d561998e6791fedb82205884162b2ce69a82
tree f5757852180a2f04f086a68a6b9cb576ea7f70d9
parent 14d95e1b10972d8b5e86daa6845aeb32a1292b60
author <pavel@amd.(none)> Thu, 26 May 2005 11:40:26 +0200
committer <pavel@amd.(none)> Thu, 26 May 2005 11:40:26 +0200

 drivers/scsi/aic7xxx/aic79xx_osm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- e09139415ec5cb347f0ff82bb23825e28f5d7c83/drivers/scsi/aic7xxx/aic79xx_osm.c  (mode:100644)
+++ f5757852180a2f04f086a68a6b9cb576ea7f70d9/drivers/scsi/aic7xxx/aic79xx_osm.c  (mode:100644)
@@ -2488,7 +2488,7 @@
 	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
 #else
 	daemonize("ahd_dv_%d", ahd->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 

