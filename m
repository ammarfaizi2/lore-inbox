Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUL2Hld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUL2Hld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUL2Hl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:41:29 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:16303 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261427AbUL2Hd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 9/16] i8042: fix sysfs permissiions for 'debug' parameter
Date: Wed, 29 Dec 2004 02:26:35 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290224.14315.dtor_core@ameritech.net> <200412290225.17324.dtor_core@ameritech.net>
In-Reply-To: <200412290225.17324.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290226.37664.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1968, 2004-11-25 01:24:31-05:00, dtor_core@ameritech.net
  Input: i8042 - fix "debug" parameter sysfs permissions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-12-29 01:49:41 -05:00
+++ b/drivers/input/serio/i8042.c	2004-12-29 01:49:41 -05:00
@@ -68,7 +68,7 @@
 #define DEBUG
 #ifdef DEBUG
 static int i8042_debug;
-module_param_named(debug, i8042_debug, bool, 600);
+module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
