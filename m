Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbUKYGfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUKYGfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUKYGfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:35:25 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:50600 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262984AbUKYGdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:33:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] i8042: fix "debug" parameter sysfs permissions.
Date: Thu, 25 Nov 2004 01:33:16 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411250133.18409.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The permission bits for the new debug parameter were set incorrectly,
please pull.

-- 
Dmitry


===================================================================


ChangeSet@1.1968, 2004-11-25 00:33:20-05:00, dtor_core@ameritech.net
  Input: i8042 - fix "debug" parameter sysfs permissions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
+++ b/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
@@ -68,7 +68,7 @@
 #define DEBUG
 #ifdef DEBUG
 static int i8042_debug;
-module_param_named(debug, i8042_debug, bool, 600);
+module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
