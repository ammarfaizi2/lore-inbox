Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWJIWLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWJIWLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWJIWLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:11:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964848AbWJIWLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:11:37 -0400
Date: Mon, 9 Oct 2006 15:11:35 -0700
From: Judith Lebzelter <judith@osdl.org>
To: tony.luck@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Message-ID: <20061009221135.GB9096@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Judith Lebzelter <judith@osdl.org>

These warnings occur during modpost for ia64/allmodconfig in 2.6.19-rc1
WARNING: "empty_zero_page" [arch/ia64/hp/sim/simscsi.ko] undefined!
WARNING: "ia64_ssc" [arch/ia64/hp/sim/simscsi.ko] undefined!

This patch exports those variables and stops the warnings.

Signed-off-by: Judith Lebzelter <judith@osdl.org>

---

Index: linux/arch/ia64/kernel/ia64_ksyms.c
===================================================================
--- linux.orig/arch/ia64/kernel/ia64_ksyms.c	2006-10-09 10:11:47.000000000 -0700
+++ linux/arch/ia64/kernel/ia64_ksyms.c	2006-10-09 10:15:18.000000000 -0700
@@ -111,3 +111,9 @@
 #endif
 extern char ia64_ivt[];
 EXPORT_SYMBOL(ia64_ivt);
+
+#include "../hp/sim/hpsim_ssc.h"
+EXPORT_SYMBOL(ia64_ssc);
+#include <asm/pgtable.h>
+EXPORT_SYMBOL(empty_zero_page);
+
