Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTI2SaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTI2RoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:44:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57784 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263975AbTI2RnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:43:01 -0400
Subject: [PATCH 3/4] Explicitly set All-Repeat mode in Set3 on AT keyboards.
In-Reply-To: <10648573751690@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 29 Sep 2003 19:42:55 +0200
Message-Id: <10648573751939@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1385, 2003-09-29 12:59:49+02:00, vojtech@suse.cz
  input: Explicitly set All-Repeat mode in Set3 on AT keyboards.


 atkbd.c |    3 +++
 1 files changed, 3 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:36:59 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:36:59 2003
@@ -111,6 +111,7 @@
 #define ATKBD_CMD_SETREP	0x10f3
 #define ATKBD_CMD_ENABLE	0x00f4
 #define ATKBD_CMD_RESET_DIS	0x00f5
+#define ATKBD_CMD_SETALL_MBR    0x00fa
 #define ATKBD_CMD_RESET_BAT	0x02ff
 #define ATKBD_CMD_RESEND	0x00fe
 #define ATKBD_CMD_EX_ENABLE	0x10ea
@@ -519,6 +520,8 @@
 		if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
 		return 2;
 	}
+
+	atkbd_command(atkbd, param, ATKBD_CMD_SETALL_MBR);
 
 	return 3;
 }

