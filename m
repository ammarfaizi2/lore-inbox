Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWCTWMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWCTWMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWCTWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:65465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030548AbWCTWBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:20 -0500
Cc: Tilman Schmidt <tilman@imap.cc>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/23] Driver core: add macros notice(), dev_notice()
In-Reply-To: <11428920382138-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <1142892038430-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both usb.h and device.h have collections of convenience macros for
printk() with the KERN_ERR, KERN_WARNING, and KERN_NOTICE severity
levels. This patch adds macros for the KERN_NOTICE level which was
so far uncatered for.

These macros already exist privately in drivers/isdn/gigaset/gigaset.h
(currently in the process of being submitted for the kernel tree)
but they really belong with their brothers and sisters in
include/linux/{device,usb}.h.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/device.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

4f2928d0a439553f0288d9483faf417430629635
diff --git a/include/linux/device.h b/include/linux/device.h
index 58df18d..5b595fd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -424,6 +424,8 @@ extern void firmware_unregister(struct s
 	dev_printk(KERN_INFO , dev , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
 	dev_printk(KERN_WARNING , dev , format , ## arg)
+#define dev_notice(dev, format, arg...)		\
+	dev_printk(KERN_NOTICE , dev , format , ## arg)
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
1.2.4


