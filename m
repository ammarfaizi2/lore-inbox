Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWCQQRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWCQQRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWCQQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:37 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:51342 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030208AbWCQQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:34 -0500
Subject: [Patch 6 of 8] Implement the CFLAGs side
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:15:29 +0100
Message-Id: <1142612129.3033.112.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the actual compiler options to the CFLAGS

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/Makefile |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.16-rc6-stack-protector/arch/x86_64/Makefile
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/arch/x86_64/Makefile
+++ linux-2.6.16-rc6-stack-protector/arch/x86_64/Makefile
@@ -29,6 +29,8 @@ CHECKFLAGS      += -D__x86_64__ -m64
 
 cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
 cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
+cflags-$(CONFIG_STACK_PROTECTOR) += $(call cc-option, -fstack-protector)
+cflags-$(CONFIG_STACK_PROTECTOR_ALL) += $(call cc-option, -fstack-protector-all)
 CFLAGS += $(cflags-y)
 
 CFLAGS += -m64

