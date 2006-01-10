Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWAJQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWAJQov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAJQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:44:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751141AbWAJQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:44:51 -0500
Date: Tue, 10 Jan 2006 17:44:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let SND_SUPPORT_OLD_API depend on SND_PCM
Message-ID: <20060110164449.GN3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SUPPORT_OLD_API only has an effect if SND_PCM is set.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/sound/core/Kconfig.old	2006-01-10 17:35:35.000000000 +0100
+++ linux-2.6.15-mm2-full/sound/core/Kconfig	2006-01-10 17:36:07.000000000 +0100
@@ -124,7 +124,7 @@
 
 config SND_SUPPORT_OLD_API
 	bool "Support old ALSA API"
-	depends on SND
+	depends on SND_PCM
 	default y
 	help
 	  Say Y here to support the obsolete ALSA PCM API (ver.0.9.0 rc3

