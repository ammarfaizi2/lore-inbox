Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVKQXKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVKQXKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVKQXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:10:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:62677 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964934AbVKQXKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:10:33 -0500
Subject: [PATCH] tpm: remove PCI kconfig dependency
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Thu, 17 Nov 2005 16:07:57 -0600
Message-Id: <1132265277.4873.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver dependencies on PCI have been removed.  This patch clears
that up in the Kconfig file

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 

Note the pci.h file can not be removed from the include list because of
the prom functions used by the ppc64 specific parts of the driver.

--- linux-2.6.14/drivers/char/tpm/Kconfig	2005-10-27 19:02:08.000000000 -0500
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/Kconfig	2005-11-16 16:54:38.000000000 -0600
@@ -6,7 +6,7 @@ menu "TPM devices"
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
-	depends on EXPERIMENTAL && PCI
+	depends on EXPERIMENTAL
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,



