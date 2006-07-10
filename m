Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWGJWCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWGJWCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWGJWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:02:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47115 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965041AbWGJWCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:02:37 -0400
Date: Tue, 11 Jul 2006 00:02:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make sound/isa/gus/gusextreme.c:devices static
Message-ID: <20060710220236.GI13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"devices" is not a good name for a global variable.

Thankfully, it can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/sound/isa/gus/gusextreme.c.old	2006-07-10 01:15:13.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/sound/isa/gus/gusextreme.c	2006-07-10 01:15:20.000000000 +0200
@@ -87,7 +87,7 @@
 module_param_array(pcm_channels, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for GUS Extreme driver.");
 
-struct platform_device *devices[SNDRV_CARDS];
+static struct platform_device *devices[SNDRV_CARDS];
 
 
 #define PFX	"gusextreme: "

