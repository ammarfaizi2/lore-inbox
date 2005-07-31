Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263209AbVGaL0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbVGaL0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGaL0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:26:32 -0400
Received: from coderock.org ([193.77.147.115]:60612 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261727AbVGaLMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:12:19 -0400
Message-Id: <20050731111218.847895000@homer>
Date: Sun, 31 Jul 2005 13:12:10 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Jan Veldeman <Jan.Veldeman@advalvas.be>,
       domen@coderock.org
Subject: [patch 5/5] Driver core: Documentation: use S_IRUSR | ... in stead of 0644
Content-Disposition: inline; filename=fixup3-Documentation_filesystems_sysfs.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Veldeman <jan@mind.be>


Change filemode to use defines in stead of 0644,
based on suggestions by Walter Harms and Domen Puncer.

Signed-off-by: Jan Veldeman <Jan.Veldeman@advalvas.be>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 sysfs.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/Documentation/filesystems/sysfs.txt
===================================================================
--- quilt.orig/Documentation/filesystems/sysfs.txt
+++ quilt/Documentation/filesystems/sysfs.txt
@@ -99,14 +99,14 @@ struct device_attribute dev_attr_##_name
 
 For example, declaring
 
-static DEVICE_ATTR(foo, 0644, show_foo, store_foo);
+static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
 
 is equivalent to doing:
 
 static struct device_attribute dev_attr_foo = {
        .attr	= {
 		.name = "foo",
-		.mode = 0644,
+		.mode = S_IWUSR | S_IRUGO,
 	},
 	.show = show_foo,
 	.store = store_foo,

--
