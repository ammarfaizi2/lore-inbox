Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVCJDYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVCJDYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVCJBKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:10:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:39839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262581AbVCJAmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:21 -0500
Cc: akpm@osdl.org
Subject: [PATCH] tpm_atmel build fix
In-Reply-To: <11104153223250@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:42:02 -0800
Message-Id: <1110415322410@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2038, 2005/03/09 10:13:15-08:00, akpm@osdl.org

[PATCH] tpm_atmel build fix

drivers/char/tpm/tpm_atmel.c:131: unknown field `fops' specified in initializer
drivers/char/tpm/tpm_atmel.c:131: warning: missing braces around initializer


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/tpm/tpm_atmel.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
--- a/drivers/char/tpm/tpm_atmel.c	2005-03-09 16:40:05 -08:00
+++ b/drivers/char/tpm/tpm_atmel.c	2005-03-09 16:40:05 -08:00
@@ -128,7 +128,7 @@
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.base = TPM_ATML_BASE,
-	.miscdev.fops = &atmel_ops,
+	.miscdev = { .fops = &atmel_ops, },
 };
 
 static int __devinit tpm_atml_init(struct pci_dev *pci_dev,

