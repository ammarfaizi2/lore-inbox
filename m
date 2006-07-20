Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWGTPOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWGTPOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWGTPOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:14:36 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:65391 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932589AbWGTPOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:14:35 -0400
Message-ID: <44BF9E5A.9010202@oracle.com>
Date: Thu, 20 Jul 2006 08:16:42 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: gregkh@suse.de, akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] kernel-doc fixes for debugfs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc and typos/spellos in fs/debugfs/.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/debugfs/file.c  |   56 +++++++++++++++++++++++------------------------------
 fs/debugfs/inode.c |   15 +++++---------
 2 files changed, 31 insertions(+), 40 deletions(-)

--- linux-2618-rc2.orig/fs/debugfs/file.c
+++ linux-2618-rc2/fs/debugfs/file.c
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
--- linux-2618-rc2.orig/fs/debugfs/inode.c
+++ linux-2618-rc2/fs/debugfs/inode.c
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



