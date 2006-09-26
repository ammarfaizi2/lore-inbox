Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWIZFwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWIZFwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIZFis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:44001 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751297AbWIZFiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:14 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/47] device_create(): make fmt argument 'const char *'
Date: Mon, 25 Sep 2006 22:37:24 -0700
Message-Id: <1159249096460-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592490933346-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |    2 +-
 include/linux/device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04d089f..5d4b7e0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -583,7 +583,7 @@ static void device_create_release(struct
  * been created with a call to class_create().
  */
 struct device *device_create(struct class *class, struct device *parent,
-			     dev_t devt, char *fmt, ...)
+			     dev_t devt, const char *fmt, ...)
 {
 	va_list args;
 	struct device *dev = NULL;
diff --git a/include/linux/device.h b/include/linux/device.h
index 1fec285..8d92013 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -384,7 +384,7 @@ extern void device_reprobe(struct device
  * Easy functions for dynamically creating devices on the fly
  */
 extern struct device *device_create(struct class *cls, struct device *parent,
-				    dev_t devt, char *fmt, ...)
+				    dev_t devt, const char *fmt, ...)
 				    __attribute__((format(printf,4,5)));
 extern void device_destroy(struct class *cls, dev_t devt);
 
-- 
1.4.2.1

