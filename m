Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWDMRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWDMRvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWDMRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:51:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:30115 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964771AbWDMRvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:51:07 -0400
Subject: [PATCH] tpm: tpm-new-12-sysfs-files-fix-fix-fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 12:51:56 -0500
Message-Id: <1144950716.12054.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a buffer size that got set to small for the return size.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-12 16:39:40.191345000 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-13 12:56:32.717377500 -0500
@@ -582,7 +584,7 @@ EXPORT_SYMBOL_GPL(tpm_continue_selftest)
 ssize_t tpm_show_enabled(struct device * dev, struct device_attribute * attr,
 			char *buf)
 {
-	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 30)];
+	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 35)];
 	ssize_t rc;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);


