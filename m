Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTEGXSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEGXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:04:42 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45038 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264326AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493882505@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349388788@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1109, 2003/05/07 15:01:22-07:00, hannal@us.ibm.com

[PATCH] dz tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/dz.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/dz.c b/drivers/char/dz.c
--- a/drivers/char/dz.c	Wed May  7 16:00:30 2003
+++ b/drivers/char/dz.c	Wed May  7 16:00:30 2003
@@ -1332,6 +1332,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "ttyS";
 #else

