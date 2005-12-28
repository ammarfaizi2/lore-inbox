Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVL1RcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVL1RcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVL1RcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:32:17 -0500
Received: from quark.didntduck.org ([69.55.226.66]:63155 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932192AbVL1RcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:32:17 -0500
Message-ID: <43B2CC42.1060801@didntduck.org>
Date: Wed, 28 Dec 2005 12:32:50 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: unexport pci_*_consistent
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are inlines and shouldn't be exported.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit f26d8d02de18c29fdb8f17c1609ac2bfd7c538fe
tree 8c828e6a603a20acd8eecf533b463cb93f99204b
parent 76ea50a4c7617782dc0ee6078c8ac5564ada924c
author Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 12:02:14 -0500
committer Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 12:02:14 -0500

 arch/x86_64/kernel/x8664_ksyms.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index 4a54221..18b84f8 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -98,11 +98,6 @@ EXPORT_SYMBOL(copy_in_user);
 EXPORT_SYMBOL(strnlen_user);
 
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
-#endif
-
-#ifdef CONFIG_PCI
 EXPORT_SYMBOL(pci_mem_start);
 #endif
 


