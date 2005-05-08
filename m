Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVEHTpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVEHTpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVEHTon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:44:43 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:8087 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262946AbVEHTKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:33 -0400
Message-Id: <20050508184345.439232000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:32 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>
Content-Disposition: inline; filename=dvb-core-modparm-fix.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 03/37] dvb_frontend: fix module param
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect "dvb_"-prefix from parameter description.
Error detected with section2text.rb, see autoparam patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/dvb-core/dvb_frontend.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-08 20:24:43.000000000 +0200
@@ -48,7 +48,7 @@ static int dvb_override_tune_delay;
 static int dvb_powerdown_on_sleep = 1;
 
 module_param_named(frontend_debug, dvb_frontend_debug, int, 0644);
-MODULE_PARM_DESC(dvb_frontend_debug, "Turn on/off frontend core debugging (default:off).");
+MODULE_PARM_DESC(frontend_debug, "Turn on/off frontend core debugging (default:off).");
 module_param(dvb_shutdown_timeout, int, 0444);
 MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
 module_param(dvb_force_auto_inversion, int, 0444);

--

