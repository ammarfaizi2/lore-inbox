Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTEGXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTEGXC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56201 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264199AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349388788@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349387433@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1108, 2003/05/07 15:01:12-07:00, hannal@us.ibm.com

[PATCH] hvc_console tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/hvc_console.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c	Wed May  7 16:00:34 2003
+++ b/drivers/char/hvc_console.c	Wed May  7 16:00:34 2003
@@ -257,6 +257,7 @@
 	memset(&hvc_driver, 0, sizeof(struct tty_driver));
 
 	hvc_driver.magic = TTY_DRIVER_MAGIC;
+	hvc_driver.owner = THIS_MODULE;
 	hvc_driver.driver_name = "hvc";
 	hvc_driver.name = "hvc/";
 	hvc_driver.major = HVC_MAJOR;

