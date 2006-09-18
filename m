Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWIRStc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWIRStc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIRStc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:49:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63882 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751790AbWIRStJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:49:09 -0400
Subject: [PATCH] slim: compilation warning fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 11:49:01 -0700
Message-Id: <1158605341.16727.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a warning when compiling the intergity_dummy.c file about
vfs_getxattr not being defined.  This patch fixes that by adding the
xattr.h include file.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 security/integrity_dummy.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.18-rc6-mm2/security/integrity_dummy.c	2006-09-15 11:13:55.000000000 -0500
+++ linux-2.6.18-rc6-mm2-slim/security/integrity_dummy.c	2006-09-18 13:14:16.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/integrity.h>
+#include <linux/xattr.h>
 
 /*
  *  Return the extended attribute


