Return-Path: <linux-kernel-owner+w=401wt.eu-S932518AbXAQQvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbXAQQvf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAQQve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:51:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33098 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbXAQQvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:51:33 -0500
Subject: [PATCH] Fix missing include of list.h in sysfs.h
From: Frank Haverkamp <haver@vnet.ibm.com>
Reply-To: haver@vnet.ibm.com
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Organization: IBM
Date: Wed, 17 Jan 2007 17:51:18 +0100
Message-Id: <1169052679.21717.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs.h uses definitions (e.g. struct list_head s_sibling) from list.h
but does not include it.

Signed-off-by: Frank Haverkamp <haver@vnet.ibm.com>
---
 include/linux/sysfs.h |    1 +
 1 file changed, 1 insertion(+)

--- ubi-2.6.git.orig/include/linux/sysfs.h
+++ ubi-2.6.git/include/linux/sysfs.h
@@ -11,6 +11,7 @@
 #define _SYSFS_H_
 
 #include <linux/compiler.h>
+#include <linux/list.h>
 #include <asm/atomic.h>
 
 struct kobject;


