Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUETTo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUETTo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUETTo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:44:59 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:40103 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265206AbUETTo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:44:57 -0400
Date: Thu, 20 May 2004 21:44:39 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH][2.6] Fix power/shutdown.c comments
Message-ID: <20040520194439.GA22904@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make the comments in drivers/base/power/shutdown.c somewhat less wrong.
There's still room for improvement :-/.

Patch against 2.6.6.

Roger

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shutdown-2.6.6.diff"

--- linux-2.6.6/drivers/base/power/shutdown.c	2004-04-04 05:37:36.000000000 +0200
+++ linux-2.6.6-patch/drivers/base/power/shutdown.c	2004-05-20 16:19:29.988995222 +0200
@@ -34,8 +34,8 @@
 
 
 /**
- * We handle system devices differently - we suspend and shut them 
- * down first and resume them first. That way, we do anything stupid like
+ * We handle system devices differently - we suspend and shut them
+ * down last and resume them first. That way, we don't do anything stupid like
  * shutting down the interrupt controller before any devices..
  *
  * Note that there are not different stages for power management calls - 
@@ -45,7 +45,7 @@
 extern int sysdev_shutdown(void);
 
 /**
- * device_shutdown - call ->remove() on each device to shutdown. 
+ * device_shutdown - call ->shutdown() on each device to shutdown. 
  */
 void device_shutdown(void)
 {

--sdtB3X0nJg68CQEu--
