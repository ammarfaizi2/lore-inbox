Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTDQAgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTDQAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:36:51 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:59437 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261968AbTDQAgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:36:50 -0400
Date: Wed, 16 Apr 2003 20:42:04 -0400
From: Chris Heath <chris@heathens.co.nz>
Subject: [PATCH][2.5] keyboard.c Fix SAK in raw mode
To: linux-kernel@vger.kernel.org
Message-id: <20030416191012.0331.CHRIS@heathens.co.nz>
MIME-version: 1.0
X-Mailer: Becky! ver. 2.05.10
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Antirelay: Good relay from local net2 68.61.227.91/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to get the SAK key working in raw and medium raw modes. 
Patch is against kernel 2.5.67.

Chris



--- a/drivers/char/keyboard.c	2003-04-12 09:50:18.000000000 -0400
+++ b/drivers/char/keyboard.c	2003-04-13 20:52:42.000000000 -0400
@@ -601,7 +601,7 @@
 		return;
 	if ((kbd->kbdmode == VC_RAW || 
 	     kbd->kbdmode == VC_MEDIUMRAW) && 
-	     value != K_SAK)
+	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc, regs);
 }


