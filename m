Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWIZFwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWIZFwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWIZFiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:27861 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751301AbWIZFiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:24 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/47] Debugfs: kernel-doc fixes for debugfs
Date: Mon, 25 Sep 2006 22:37:27 -0700
Message-Id: <1159249104512-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491023995-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc and typos/spellos in fs/debugfs/.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/file.c  |   56 +++++++++++++++++++++++-----------------------------
 fs/debugfs/inode.c |   15 ++++++--------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 39640fd..e4b4305 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -55,12 +55,11 @@ static u64 debugfs_u8_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
 
 /**
- * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write an unsigned 8 bit value.
- *
+ * debugfs_create_u8 - create a debugfs file that is used to read and write an unsigned 8-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -72,11 +71,11 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_u8(const char *name, mode_t mode,
@@ -97,12 +96,11 @@ static u64 debugfs_u16_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
 
 /**
- * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write an unsigned 16 bit value.
- *
+ * debugfs_create_u16 - create a debugfs file that is used to read and write an unsigned 16-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -114,11 +112,11 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugf
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_u16(const char *name, mode_t mode,
@@ -139,12 +137,11 @@ static u64 debugfs_u32_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
 
 /**
- * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write an unsigned 32 bit value.
- *
+ * debugfs_create_u32 - create a debugfs file that is used to read and write an unsigned 32-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -156,11 +153,11 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugf
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_u32(const char *name, mode_t mode,
@@ -219,12 +216,11 @@ static const struct file_operations fops
 };
 
 /**
- * debugfs_create_bool - create a file in the debugfs filesystem that is used to read and write a boolean value.
- *
+ * debugfs_create_bool - create a debugfs file that is used to read and write a boolean value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -236,11 +232,11 @@ static const struct file_operations fops
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_bool(const char *name, mode_t mode,
@@ -264,13 +260,11 @@ static struct file_operations fops_blob 
 };
 
 /**
- * debugfs_create_blob - create a file in the debugfs filesystem that is
- * used to read and write a binary blob.
- *
+ * debugfs_create_blob - create a debugfs file that is used to read and write a binary blob
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this paramater is NULL, then the
+ *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @blob: a pointer to a struct debugfs_blob_wrapper which contains a pointer
  *        to the blob data and the size of the data.
@@ -282,11 +276,11 @@ static struct file_operations fops_blob 
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_blob(const char *name, mode_t mode,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e8ae304..3ca268d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -162,7 +162,6 @@ static int debugfs_create_by_name(const 
 
 /**
  * debugfs_create_file - create a file in the debugfs filesystem
- *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
@@ -182,11 +181,11 @@ static int debugfs_create_by_name(const 
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
@@ -221,7 +220,6 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
 
 /**
  * debugfs_create_dir - create a directory in the debugfs filesystem
- *
  * @name: a pointer to a string containing the name of the directory to
  *        create.
  * @parent: a pointer to the parent dentry for this file.  This should be a
@@ -233,11 +231,11 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, NULL will be returned.
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
  *
- * If debugfs is not enabled in the kernel, the value -ENODEV will be
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.  It is not wise to check for this value, but rather, check for
- * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
@@ -250,7 +248,6 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
 /**
  * debugfs_remove - removes a file or directory from the debugfs filesystem
- *
  * @dentry: a pointer to a the dentry of the file or directory to be
  *          removed.
  *
-- 
1.4.2.1

