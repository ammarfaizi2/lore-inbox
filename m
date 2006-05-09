Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWEIQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWEIQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWEIQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:56:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:705 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750745AbWEIQ4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:56:43 -0400
Subject: [PATCH] tpm: fix constant
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Tue, 09 May 2006 11:55:07 -0500
Message-Id: <1147193707.29414.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the constant used for the base address when it cannot be determined
from ACPI.  It was off by one order of magnitude. 

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc3/drivers/char/tpm/tpm_tis.c	2006-04-26 21:19:25.000000000 -0500
+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/tpm_tis.c	2006-05-09 09:39:20.281741000 -0500
@@ -55,7 +55,7 @@ enum tis_int_flags {
 };
 
 enum tis_defaults {
-	TIS_MEM_BASE = 0xFED4000,
+	TIS_MEM_BASE = 0xFED40000,
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
 	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */


