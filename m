Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVCUQKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVCUQKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVCUQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 11:10:35 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:2521 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261854AbVCUQK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 11:10:29 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321154226.19053.36781.35540@clementine.local>
Subject: [PATCH] dvb_frontend: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 17:10:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "dvb_"-prefix from parameters. Without the patch all parameters except
the declaration of parameter "frontend_debug" have a "dvb_"-prefix.

Error detected with section2text.rb, see autoparam patch. 

--- linux-2.6.12-rc1/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-03-21 16:00:15.000000000 +0100
@@ -48,15 +48,15 @@
 static int dvb_powerdown_on_sleep = 1;
 
 module_param_named(frontend_debug, dvb_frontend_debug, int, 0644);
-MODULE_PARM_DESC(dvb_frontend_debug, "Turn on/off frontend core debugging (default:off).");
-module_param(dvb_shutdown_timeout, int, 0444);
-MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
-module_param(dvb_force_auto_inversion, int, 0444);
-MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
-module_param(dvb_override_tune_delay, int, 0444);
-MODULE_PARM_DESC(dvb_override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
-module_param(dvb_powerdown_on_sleep, int, 0444);
-MODULE_PARM_DESC(dvb_powerdown_on_sleep, "0: do not power down, 1: turn LNB volatage off on sleep (default)");
+MODULE_PARM_DESC(frontend_debug, "Turn on/off frontend core debugging (default:off).");
+module_param_named(shutdown_timeout, dvb_shutdown_timeout, int, 0444);
+MODULE_PARM_DESC(shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
+module_param_named(force_auto_inversion, dvb_force_auto_inversion, int, 0444);
+MODULE_PARM_DESC(force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
+module_param_named(override_tune_delay, dvb_override_tune_delay, int, 0444);
+MODULE_PARM_DESC(override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
+module_param_named(powerdown_on_sleep, dvb_powerdown_on_sleep, int, 0444);
+MODULE_PARM_DESC(powerdown_on_sleep, "0: do not power down, 1: turn LNB volatage off on sleep (default)");
 
 #define dprintk if (dvb_frontend_debug) printk
 
