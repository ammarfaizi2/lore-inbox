Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVCJBP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVCJBP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVCJBMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:12:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:40607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262603AbVCJAmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:21 -0500
Cc: akpm@osdl.org
Subject: [PATCH] tpm_msc-build-fix
In-Reply-To: <11104153213727@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:42:02 -0800
Message-Id: <11104153223250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2037, 2005/03/09 10:12:56-08:00, akpm@osdl.org

[PATCH] tpm_msc-build-fix

With older gcc's:

drivers/char/tpm/tpm_nsc.c:238: unknown field `fops' specified in initializer
drivers/char/tpm/tpm_nsc.c:238: warning: missing braces around initializer


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/tpm/tpm_nsc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
--- a/drivers/char/tpm/tpm_nsc.c	2005-03-09 16:40:12 -08:00
+++ b/drivers/char/tpm/tpm_nsc.c	2005-03-09 16:40:12 -08:00
@@ -235,7 +235,8 @@
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.base = TPM_NSC_BASE,
-	.miscdev.fops = &nsc_ops,
+	.miscdev = { .fops = &nsc_ops, },
+	
 };
 
 static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,

