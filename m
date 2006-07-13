Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWGMHDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWGMHDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGMHDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:03:25 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:59595 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750783AbWGMHDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:03:24 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v2] add function documentation for register_chrdev()
Date: Thu, 13 Jul 2006 09:09:34 +0200
User-Agent: KMail/1.9.3
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
References: <200607120942.23071@bilbo.math.uni-mannheim.de> <200607120946.16501@bilbo.math.uni-mannheim.de>
In-Reply-To: <200607120946.16501@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130909.34562@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for register_chrdev() was missing completely.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 7471539cb5e9cdd7ca7e48a247e15797d0e53708
tree 6ecd75500615ae9a975835596afb820b0fa51786
parent e73ad26773b26c730c49f8ef3b00b10b8bcc0009
author Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 11 Jul 2006 15:29:09 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Tue, 11 Jul 2006 15:29:09 +0200

 fs/char_dev.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a4cbc67..ac28eaa 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -182,6 +182,29 @@ int alloc_chrdev_region(dev_t *dev, unsi
 	return 0;
 }
 
+/*
+ * register_chrdev: register a major number for character devices.
+ *
+ * @major: major device number or 0 for dynamic allocation
+ * @name: name of this range of devices
+ * @fops: file operations associated with this devices
+ *
+ * If major == 0 this functions will dynamically allocate a major and return
+ * its number.
+ *
+ * If major > 0 this function will attempt to reserve a device with the given
+ * major number and will return zero on success.
+ *
+ * Returns negative error code on failure.
+ *
+ * The name of this device has nothing to do with the name of the device in
+ * /dev. It only helps to keep track of the different owners of devices. If
+ * your module name has only one type of devices it's ok to use e.g. the name
+ * of the module here.
+ *
+ * This function registers a range of 256 minor numbers. The first minor number
+ * is 0.
+ */
 int register_chrdev(unsigned int major, const char *name,
 		    const struct file_operations *fops)
 {
