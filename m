Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbULIHxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbULIHxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbULIHxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:53:36 -0500
Received: from [61.48.53.158] ([61.48.53.158]:27133 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261481AbULIHxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:53:35 -0500
Date: Wed, 8 Dec 2004 23:42:34 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412090742.iB97gYv28134@adam.yggdrasil.com>
To: greg@kroah.com, maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patch?] unpin sysfs directories, saving ~0.5MB
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Sorry, I forgot to include a change to a header file
in the patch for unpinning sysfs directories.  Here it is.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


Signed-off-by: Adam J. Richter <adam@yggdrasil.com>

--- linux-2.6.10-rc2-bk16/include/linux/kobject.h	2004-11-17 18:59:17.000000000 +0800
+++ linux/include/linux/kobject.h	2004-12-03 22:03:45.000000000 +0800
@@ -38,7 +38,7 @@
 	struct kobject		* parent;
 	struct kset		* kset;
 	struct kobj_type	* ktype;
-	struct dentry		* dentry;
+	struct sysfs_dir	* sysfs_dir;
 };
 
 extern int kobject_set_name(struct kobject *, const char *, ...)
