Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTEGXSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTEGXFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20644 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264334AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493861009@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493863583@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1098, 2003/05/07 14:59:32-07:00, hannal@us.ibm.com

[PATCH] sgi/char/sgiserial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/sgi/char/sgiserial.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/sgi/char/sgiserial.c b/drivers/sgi/char/sgiserial.c
--- a/drivers/sgi/char/sgiserial.c	Wed May  7 16:01:18 2003
+++ b/drivers/sgi/char/sgiserial.c	Wed May  7 16:01:18 2003
@@ -1867,6 +1867,7 @@
 	
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;

