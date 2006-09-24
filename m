Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWIXWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWIXWnB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWIXWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:43:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51653 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751643AbWIXWm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:42:57 -0400
Date: Sun, 24 Sep 2006 23:42:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NULL noise removal
Message-ID: <20060924224257.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/drivers/mts64.c |    2 +-
 sound/sparc/dbri.c    |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 1699873..ab8d4ef 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -677,7 +677,7 @@ static int __devinit snd_mts64_ctl_creat
 		&mts64_ctl_smpte_time_seconds,
 		&mts64_ctl_smpte_time_frames,
 		&mts64_ctl_smpte_fps,
-	        0  };
+	        NULL  };
 
 	for (i = 0; control[i]; ++i) {
 		err = snd_ctl_add(card, snd_ctl_new1(control[i], mts));
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index e4935fc..8016541 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -669,7 +669,7 @@ static s32 *dbri_cmdlock(struct snd_dbri
 	else
 		printk(KERN_ERR "DBRI: no space for commands.");
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -2037,10 +2037,10 @@ static int snd_dbri_open(struct snd_pcm_
 	spin_unlock_irqrestore(&dbri->lock, flags);
 
 	snd_pcm_hw_rule_add(runtime,0,SNDRV_PCM_HW_PARAM_CHANNELS,
-			    snd_hw_rule_format, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+			    snd_hw_rule_format, NULL, SNDRV_PCM_HW_PARAM_FORMAT,
 			    -1);
 	snd_pcm_hw_rule_add(runtime,0,SNDRV_PCM_HW_PARAM_FORMAT,
-			    snd_hw_rule_channels, 0, 
+			    snd_hw_rule_channels, NULL, 
 			    SNDRV_PCM_HW_PARAM_CHANNELS,
 			    -1);
 				
-- 
1.4.2.GIT
