Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWEHU4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWEHU4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWEHU4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:56:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56277 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750816AbWEHU4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:56:24 -0400
Subject: [PATCH] tpm: update module dependencies
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Mon, 08 May 2006 15:54:48 -0500
Message-Id: <1147121688.29414.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TIS driver is dependent upon information from the ACPI table for
device discovery thus it compiles but does no actual work with out this
dependency.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 21:19:25.000000000 -0500
+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	2006-05-08 16:11:03.707961750 -0500
@@ -22,7 +22,7 @@ config TCG_TPM
 
 config TCG_TIS
 	tristate "TPM Interface Specification 1.2 Interface"
-	depends on TCG_TPM
+	depends on TCG_TPM && PNPACPI
 	---help---
 	  If you have a TPM security chip that is compliant with the
 	  TCG TIS 1.2 TPM specification say Yes and it will be accessible


