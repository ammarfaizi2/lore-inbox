Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTEGXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTEGXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:18084 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264200AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493861812@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493863606@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1096, 2003/05/07 14:59:12-07:00, hannal@us.ibm.com

[PATCH] serial167 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/serial167.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/serial167.c b/drivers/char/serial167.c
--- a/drivers/char/serial167.c	Wed May  7 16:01:27 2003
+++ b/drivers/char/serial167.c	Wed May  7 16:01:27 2003
@@ -2395,6 +2395,7 @@
     
     memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
     cy_serial_driver.magic = TTY_DRIVER_MAGIC;
+    cy_serial_driver.owner = THIS_MODULE;
 #ifdef CONFIG_DEVFS_FS
     cy_serial_driver.name = "tts/";
 #else

