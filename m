Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWGLBn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWGLBn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWGLBn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:43:56 -0400
Received: from mga07.intel.com ([143.182.124.22]:17999 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751206AbWGLBnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:43:55 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="64571415:sNHT34350834"
Subject: Re: [PATCH 2/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
References: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1152668507.28493.180.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 12 Jul 2006 09:41:47 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 2 adds new defines of PCI-Express AER registers
and their bits into file include/linux/pci_regs.h.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/include/linux/pci_regs.h	2006-06-22 16:26:31.000000000 +0800
+++ linux-2.6.17_aer/include/linux/pci_regs.h	2006-06-22 16:46:29.000000000 +0800
@@ -421,7 +421,23 @@
 #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
 #define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
+/* Correctable Err Reporting Enable */
+#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001
+/* Non-fatal Err Reporting Enable */
+#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002
+/* Fatal Err Reporting Enable */
+#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004
 #define PCI_ERR_ROOT_STATUS	48
+#define PCI_ERR_ROOT_COR_RCV		0x00000001	/* ERR_COR Received */
+/* Multi ERR_COR Received */
+#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002
+/* ERR_FATAL/NONFATAL Recevied */
+#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004
+/* Multi ERR_FATAL/NONFATAL Recevied */
+#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008
+#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010	/* First Fatal */
+#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020	/* Non-Fatal Received */
+#define PCI_ERR_ROOT_FATAL_RCV		0x00000040	/* Fatal Received */
 #define PCI_ERR_ROOT_COR_SRC	52
 #define PCI_ERR_ROOT_SRC	54
 
