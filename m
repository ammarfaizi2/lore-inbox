Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbUKYGbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbUKYGbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUKYGbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:31:37 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:19547 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262982AbUKYGbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:31:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] i8k: fix 'power_status' sysfs permissions
Date: Thu, 25 Nov 2004 01:31:28 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411250131.31624.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that was a stupid mistake on my part.

-- 
Dmitry


===================================================================


ChangeSet@1.1967, 2004-11-25 00:30:50-05:00, dtor_core@ameritech.net
  I8K: Fix power_status parameter sysfs permissions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8k.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/char/i8k.c b/drivers/char/i8k.c
--- a/drivers/char/i8k.c	2004-11-25 01:26:46 -05:00
+++ b/drivers/char/i8k.c	2004-11-25 01:26:46 -05:00
@@ -78,7 +78,7 @@
 MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability set");
 
 static int power_status;
-module_param(power_status, bool, 600);
+module_param(power_status, bool, 0600);
 MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
 
 static ssize_t i8k_read(struct file *, char __user *, size_t, loff_t *);
