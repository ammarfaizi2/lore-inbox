Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTJOSuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbTJOS02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:26:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:49841 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263926AbTJOS0F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:05 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1066242290297@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test7
In-Reply-To: <10662422904150@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:24:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.4, 2003/10/13 11:32:38-07:00, greg@kroah.com

CHAR: Remove unneeded MOD_INC and MOD_DEC calls.


 drivers/char/ite_gpio.c |    9 ---------
 1 files changed, 9 deletions(-)


diff -Nru a/drivers/char/ite_gpio.c b/drivers/char/ite_gpio.c
--- a/drivers/char/ite_gpio.c	Wed Oct 15 11:18:36 2003
+++ b/drivers/char/ite_gpio.c	Wed Oct 15 11:18:36 2003
@@ -242,21 +242,12 @@
 	if (minor != GPIO_MINOR)
 		return -ENODEV;
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	return 0;
 }
 
 
 static int ite_gpio_release(struct inode *inode, struct file *file)
 {
-
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-
 	return 0;
 }
 

