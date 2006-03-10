Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752176AbWCJI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbWCJI6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbWCJI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:58:12 -0500
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:13720 "HELO
	smtp103.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752176AbWCJI6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:58:11 -0500
Subject: [PATCH] ext3: Fix debug logging-only compilation error
From: Kirk True <kernel@kirkandsheila.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 10 Mar 2006 00:56:12 -0800
Message-Id: <1141980972.4072.7.camel@itchy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version: 2.6.16-rc5

When EXT3FS_DEBUG is #define-d, the compile breaks due to #include file issues.

        Signed-off-by: Kirk True <kernel@kirkandsheila.com>

--- linux-2.6.16-rc5-orig/fs/ext3/bitmap.c      2006-03-02 23:52:16.000000000 -0800
+++ linux-2.6.16-rc5/fs/ext3/bitmap.c   2006-03-10 00:45:28.000000000 -0800
@@ -7,11 +7,11 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */

-#ifdef EXT3FS_DEBUG
-
 #include <linux/buffer_head.h>
+#include <linux/jbd.h>
+#include <linux/ext3_fs.h>

-#include "ext3_fs.h"
+#ifdef EXT3FS_DEBUG

 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};


