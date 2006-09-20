Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWITQuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWITQuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWITQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:49:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46746 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751926AbWITQtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:49:01 -0400
Subject: [PATCH] slim: makefile fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:48:51 -0700
Message-Id: <1158770931.16727.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Stephen Smalley for pointing out that slim was added to the
wrong place in the Makefile.  This patch fixes the problem.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
security/Makefile |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc6-orig/security/Makefile	2006-09-18 16:41:38.000000000 -0500
+++ linux-2.6.18-rc6/security/Makefile	2006-09-19 13:22:25.000000000 -0500
@@ -3,7 +3,6 @@
 #
 
 obj-$(CONFIG_KEYS)			+= keys/
-obj-$(CONFIG_SECURITY_SLIM)		+= slim/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
 
 # if we don't select a security model, use the default capabilities
@@ -15,6 +14,7 @@ endif
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
 obj-$(CONFIG_INTEGRITY)		+= integrity.o integrity_dummy.o
 # Must precede capability.o in order to stack properly.
+obj-$(CONFIG_SECURITY_SLIM)		+= slim/
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o


