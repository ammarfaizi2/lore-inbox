Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161494AbWATE1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161494AbWATE1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWATE1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:27:24 -0500
Received: from xenotime.net ([66.160.160.81]:9663 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161494AbWATE1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:27:23 -0500
Date: Thu, 19 Jan 2006 20:24:58 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, kjhall@us.ibm.com
Subject: [PATCH] tpm_infineon: fix printk format warning
Message-Id: <20060119202458.367279b8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:
drivers/char/tpm/tpm_infineon.c:443: warning: format '%04x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/tpm/tpm_infineon.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc1-secur.orig/drivers/char/tpm/tpm_infineon.c
+++ linux-2616-rc1-secur/drivers/char/tpm/tpm_infineon.c
@@ -441,7 +441,7 @@ static int __devinit tpm_inf_pnp_probe(s
 
 		if ((ioh << 8 | iol) != tpm_inf.base) {
 			dev_err(&dev->dev,
-				"Could not set IO-ports to %04x\n",
+				"Could not set IO-ports to %lx\n",
 				tpm_inf.base);
 			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
 			return -EIO;


---
