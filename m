Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVEZGyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEZGyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVEZGyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:54:10 -0400
Received: from fmr18.intel.com ([134.134.136.17]:37826 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261203AbVEZGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:54:06 -0400
Subject: swsusp: ahd_dv_0 can't be stopped
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Thu, 26 May 2005 15:00:35 +0800
Message-Id: <1117090835.8059.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I suppose the driver wants to set PF_NOFREEZE? Anyway, setting PF_FREEZE
isn't correct to me.

Thanks,
Shaohua
---

 linux-2.6.11-rc5-mm1-root/drivers/scsi/aic7xxx/aic79xx_osm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/scsi/aic7xxx/aic79xx_osm.c~ahd_dv drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.11-rc5-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c~ahd_dv	2005-05-26 14:42:41.191427928 +0800
+++ linux-2.6.11-rc5-mm1-root/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-05-26 14:43:10.396988008 +0800
@@ -2488,7 +2488,7 @@ ahd_linux_dv_thread(void *data)
 	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
 #else
 	daemonize("ahd_dv_%d", ahd->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 
_


