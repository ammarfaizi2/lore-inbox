Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUB2HDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUB2HDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:03:38 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:20876 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261988AbUB2HDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/9] atkbd bad merge
Date: Sun, 29 Feb 2004 01:55:44 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290155.04825.dtor_core@ameritech.net>
In-Reply-To: <200402290155.04825.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290155.46360.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1686, 2004-02-27 23:42:30-05:00, dtor_core@ameritech.net
  Atkbd: Clean up unclean merge (remove old MODULE_PARMs)


 atkbd.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sun Feb 29 01:15:45 2004
+++ b/drivers/input/keyboard/atkbd.c	Sun Feb 29 01:15:45 2004
@@ -30,21 +30,17 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
-MODULE_PARM(atkbd_set, "1i");
-MODULE_PARM(atkbd_reset, "1i");
-MODULE_PARM(atkbd_softrepeat, "1i");
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
 module_param_named(set, atkbd_set, int, 0);
 MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3, 4)");
+
 #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
 static int atkbd_reset;
 #else
 static int atkbd_reset = 1;
 #endif
-static int atkbd_softrepeat;
-
 module_param_named(reset, atkbd_reset, bool, 0);
 MODULE_PARM_DESC(reset, "Reset keyboard during initialization");
 
