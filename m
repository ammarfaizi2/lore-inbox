Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTEGXhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEGXCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46727 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264188AbTEGXCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493861534@kroah.com>
Subject: [PATCH] TTY changes for 2.5.69
In-Reply-To: <20030507231519.GA4346@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1090, 2003/05/07 14:58:12-07:00, hannal@us.ibm.com

[PATCH] tc_zs tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/tc/zs.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Wed May  7 16:01:53 2003
+++ b/drivers/tc/zs.c	Wed May  7 16:01:53 2003
@@ -1872,6 +1872,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "tts/";
 #else

