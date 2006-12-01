Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936458AbWLAOii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936458AbWLAOii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936476AbWLAOih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:38:37 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:39440 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936458AbWLAOih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:38:37 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] message fusion parenthesis fix
Date: Fri, 1 Dec 2006 15:38:11 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011538.11737.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes an extra parenthesis in mptscsih_abort() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/message/fusion/mptscsih.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.4.34-pre6-a/drivers/message/fusion/mptscsih.c	2004-08-08 01:26:04.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/message/fusion/mptscsih.c	2006-12-01 12:47:50.000000000 +0100
@@ -3018,7 +3018,7 @@ mptscsih_abort(Scsi_Cmnd * SCpnt)
 		return FAILED;
 
 	printk(KERN_WARNING MYNAM ": %s: >> Attempting task abort! (sc=%p)\n",
-	       hd->ioc->name, SCpnt));
+	       hd->ioc->name, SCpnt);
 
 	if (hd->timeouts < -1)
 		hd->timeouts++;
@@ -3156,7 +3156,7 @@ mptscsih_bus_reset(Scsi_Cmnd * SCpnt)
 	}
 
 	printk(KERN_WARNING MYNAM ": %s: >> Attempting bus reset! (sc=%p)\n",
-	       hd->ioc->name, SCpnt));
+	       hd->ioc->name, SCpnt);
 
 	if (hd->timeouts < -1)
 		hd->timeouts++;


-- 
Regards,

	Mariusz Kozlowski
