Return-Path: <linux-kernel-owner+w=401wt.eu-S1762271AbWLJRKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762271AbWLJRKo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762269AbWLJRKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:10:44 -0500
Received: from il.qumranet.com ([62.219.232.206]:33989 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762272AbWLJRKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:10:43 -0500
Subject: [PATCH 2/4] KVM: Put KVM in a new Virtualization menu
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 10 Dec 2006 17:10:42 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457C3F26.2090100@qumranet.com>
In-Reply-To: <457C3F26.2090100@qumranet.com>
Message-Id: <20061210171042.734C62500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of in the main drivers menu.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/Kconfig
===================================================================
--- linux-2.6.orig/drivers/kvm/Kconfig
+++ linux-2.6/drivers/kvm/Kconfig
@@ -1,6 +1,8 @@
 #
 # KVM configuration
 #
+menu "Virtualization"
+
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on X86 && EXPERIMENTAL
@@ -31,3 +33,5 @@ config KVM_AMD
 	---help---
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
+
+endmenu
