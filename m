Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVCJBKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVCJBKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCJBGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:06:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:62367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262639AbVCJAmh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:37 -0500
Cc: akpm@osdl.org
Subject: [PATCH] tpm-build-fix
In-Reply-To: <1110415322410@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:42:02 -0800
Message-Id: <1110415322602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2039, 2005/03/09 10:13:34-08:00, akpm@osdl.org

[PATCH] tpm-build-fix

drivers/char/tpm/tpm.c: In function `show_pcrs':
drivers/char/tpm/tpm.c:228: warning: passing arg 1 of `tpm_transmit' from incompatible pointer type
drivers/char/tpm/tpm.c:238: warning: passing arg 1 of `tpm_transmit' from incompatible pointer type


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/char/tpm/tpm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
--- a/drivers/char/tpm/tpm.c	2005-03-09 16:39:58 -08:00
+++ b/drivers/char/tpm/tpm.c	2005-03-09 16:39:58 -08:00
@@ -219,7 +219,7 @@
 	int i, j, index, num_pcrs;
 	char *str = buf;
 
-	struct tpm_chp *chip =
+	struct tpm_chip *chip =
 	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
 	if (chip == NULL)
 		return -ENODEV;

