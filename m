Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVAWKTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVAWKTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAWKSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:18:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261275AbVAWKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:16:41 -0500
Date: Sun, 23 Jan 2005 11:16:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Michael A. Halcrow" <mike@halcrow.us>, Serge Hallyn <hallyn@cs.wm.edu>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] security/seclvl.c: make some code static
Message-ID: <20050123101640.GG3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 security/seclvl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This patch was already sent on:
- 28 Nov 2004

--- linux-2.6.10-rc2-mm3-full/security/seclvl.c.old	2004-11-28 03:32:23.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/seclvl.c	2004-11-28 03:34:28.000000000 +0100
@@ -170,7 +170,7 @@
 /**
  * Callback function pointers for show and store
  */
-struct sysfs_ops seclvlfs_sysfs_ops = {
+static struct sysfs_ops seclvlfs_sysfs_ops = {
 	.show = seclvl_attr_show,
 	.store = seclvl_attr_store,
 };
@@ -275,7 +275,7 @@
 }
 
 /* Generate sysfs_attr_seclvl */
-struct seclvl_attribute sysfs_attr_seclvl =
+static struct seclvl_attribute sysfs_attr_seclvl =
 __ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
        seclvl_write_file);
 
@@ -386,7 +386,7 @@
 }
 
 /* Generate sysfs_attr_passwd */
-struct seclvl_attribute sysfs_attr_passwd =
+static struct seclvl_attribute sysfs_attr_passwd =
 __ATTR(passwd, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_passwd,
        seclvl_write_passwd);
 

