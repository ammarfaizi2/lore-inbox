Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWCTP2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWCTP2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWCTP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:28:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965313AbWCTP12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:28 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 117/141] V4L/DVB (3390): Fix module parameters
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150856.PS602870000117@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>
Date: 1141009772 -0300

Now, root may change parameters while module is running.
Thanks to Edgar Toerning

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 22e96cf..2c3ea8f 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -49,13 +49,13 @@ static int dvb_powerdown_on_sleep = 1;
 
 module_param_named(frontend_debug, dvb_frontend_debug, int, 0644);
 MODULE_PARM_DESC(frontend_debug, "Turn on/off frontend core debugging (default:off).");
-module_param(dvb_shutdown_timeout, int, 0444);
+module_param(dvb_shutdown_timeout, int, 0644);
 MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
-module_param(dvb_force_auto_inversion, int, 0444);
+module_param(dvb_force_auto_inversion, int, 0644);
 MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
-module_param(dvb_override_tune_delay, int, 0444);
+module_param(dvb_override_tune_delay, int, 0644);
 MODULE_PARM_DESC(dvb_override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
-module_param(dvb_powerdown_on_sleep, int, 0444);
+module_param(dvb_powerdown_on_sleep, int, 0644);
 MODULE_PARM_DESC(dvb_powerdown_on_sleep, "0: do not power down, 1: turn LNB volatage off on sleep (default)");
 
 #define dprintk if (dvb_frontend_debug) printk

