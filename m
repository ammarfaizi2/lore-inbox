Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUIEC34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUIEC34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUIEC34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:29:56 -0400
Received: from [61.48.52.95] ([61.48.52.95]:13297 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S265970AbUIEC3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:29:54 -0400
Date: Sun, 5 Sep 2004 10:25:10 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200409051725.i85HPAb03108@freya.yggdrasil.com>
To: janitor@sternwelten.at, minyard@wf-rch.cirr.com, nacc@us.ibm.com
Subject: [Patch 2.6.9-rc1-bk11] cdu31a: fix msleep patch typo
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.6.9-rc1-bk11 integrated the patch "cdu31a: replace
schedule_timeout() with msleep()".  That patch contained a typo,
causing the cdu31a driver to fail to compile.  Here is a fix for
the typo.

	Of course I have tested this patch to verify that it compiles.
I do not, however, have a Sony cdu-31a or cdu-33a drive handy to actually
test that the driver works.  I wonder if anyone out there still has a
Sony cdu-31a or cdu-33a CD-ROM drive on a machine running Linux.

Signed-off-by:	Adam J. Richter <adam@yggdrasil.com>

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


--- linux-2.6.9-rc1-bk11/drivers/cdrom/cdu31a.c	2004-09-05 09:11:23.000000000 -0700
+++ linux/drivers/cdrom/cdu31a.c	2004-09-05 10:09:42.000000000 -0700
@@ -959,7 +959,7 @@
 	if (((result_buffer[0] & 0xf0) == 0x20)
 	    && (num_retries < MAX_CDU31A_RETRIES)) {
 		num_retries++;
-		msleep(100):
+		msleep(100);
 		goto retry_cd_operation;
 	}
 
