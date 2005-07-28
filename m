Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVG1VsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVG1VsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVG1VsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:48:10 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:32235 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261536AbVG1VsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:48:05 -0400
Message-ID: <42E95266.70702@temple.edu>
Date: Thu, 28 Jul 2005 17:47:18 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com
Subject: [Patch 2.6.13-rc3-mm3]fs/reiser4/plugin/item/static_stat.c fix -Wundef
 errors in two files
Content-Type: multipart/mixed;
 boundary="------------080508040008080506090606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080508040008080506090606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes -Wundef errors in:
fs/reiser4/plugin/item/static_stat.c

Nick Sillik
n.sillik@temple.edu

Signed-off-by: Nick Sillik <n.sillik@temple.edu>



--------------080508040008080506090606
Content-Type: text/plain;
 name="reiser4_wundef.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4_wundef.diff"

diff -urN a/fs/reiser4/plugin/item/static_stat.c b/fs/reiser4/plugin/item/static_stat.c
--- a/fs/reiser4/plugin/item/static_stat.c	2005-07-28 17:36:09.000000000 -0400
+++ b/fs/reiser4/plugin/item/static_stat.c	2005-07-28 17:39:43.000000000 -0400
@@ -36,7 +36,7 @@
 	assert("nikita-617", *length >= 0);
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 /* ->print() method of static sd item. Prints human readable information about
    sd at @coord */
 reiser4_internal void
@@ -415,7 +415,7 @@
 	return 0;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 static void
 print_lw_sd(const char *prefix, char **area /* position in stat-data */ ,
 	    int *len /* remaining length */ )
@@ -505,7 +505,7 @@
 	return 0;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 static void
 print_unix_sd(const char *prefix, char **area /* position in stat-data */ ,
 	      int *len /* remaining length */ )
@@ -569,7 +569,7 @@
 	return 0;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 static void
 print_large_times_sd(const char *prefix, char **area /* position in stat-data */,
 		     int *len /* remaining length */ )
@@ -674,7 +674,7 @@
 	return result;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 static void
 print_symlink_sd(const char *prefix, char **area /* position in stat-data */ ,
 		 int *len /* remaining length */ )
@@ -1049,7 +1049,7 @@
 	return result;
 }
 
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 static void
 print_crypto_sd(const char *prefix, char **area /* position in stat-data */ ,
 		 int *len /* remaining length */ )
@@ -1082,7 +1082,7 @@
 			       .absent = NULL,
 			       .save_len = save_len_lw_sd,
 			       .save = save_lw_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			       .print = print_lw_sd,
 #endif
 			       .alignment = 8
@@ -1100,7 +1100,7 @@
 		       .absent = absent_unix_sd,
 		       .save_len = save_len_unix_sd,
 		       .save = save_unix_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 		       .print = print_unix_sd,
 #endif
 		       .alignment = 8
@@ -1118,7 +1118,7 @@
 		       .absent = NULL,
 		       .save_len = save_len_large_times_sd,
 		       .save = save_large_times_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 		       .print = print_large_times_sd,
 #endif
 		       .alignment = 8
@@ -1137,7 +1137,7 @@
 			  .absent = NULL,
 			  .save_len = save_len_symlink_sd,
 			  .save = save_symlink_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			  .print = print_symlink_sd,
 #endif
 			  .alignment = 8
@@ -1155,7 +1155,7 @@
 			 .absent = absent_plugin_sd,
 			 .save_len = save_len_plugin_sd,
 			 .save = save_plugin_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 			 .print = NULL,
 #endif
 			 .alignment = 8
@@ -1173,7 +1173,7 @@
 				.absent = NULL,
 				.save_len = save_len_flags_sd,
 				.save = save_flags_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 				.print = NULL,
 #endif
 				.alignment = 8
@@ -1191,7 +1191,7 @@
 				.absent = NULL,
 				.save_len = save_len_flags_sd,
 				.save = save_flags_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 				.print = NULL,
 #endif
 				.alignment = 8
@@ -1210,7 +1210,7 @@
 				/* return IO_ERROR if smthng is wrong */
 				.save_len = save_len_crypto_sd,
 				.save = save_crypto_sd,
-#if REISER4_DEBUG_OUTPUT
+#ifdef REISER4_DEBUG_OUTPUT
 				.print = print_crypto_sd,
 #endif
 				.alignment = 8

--------------080508040008080506090606--
