Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHIQeB>; Fri, 9 Aug 2002 12:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHIQeA>; Fri, 9 Aug 2002 12:34:00 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:50305 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314548AbSHIQeA>;
	Fri, 9 Aug 2002 12:34:00 -0400
Date: Fri, 9 Aug 2002 20:36:39 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200208091636.g79GadVX007881@bitshadow.namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] reiserfs changeset 3 of 7 to include into 2.4 tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset changes help text of CONFIG_REISERFS_PROC_INFO config
   option and config text for CONFIG_REISERFS_CHECK option
   to hopefully improove their meaning.
   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

   Diffstat:

 Documentation/Configure.help |   13 +++++++------
 fs/Config.in                 |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

  Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683   -> 1.684  
#	        fs/Config.in	1.15    -> 1.16   
#	Documentation/Configure.help	1.116   -> 1.117  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.684
# Configure.help, Config.in:
#   Change reiserfs config options/help to improve understandability
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Aug  6 10:38:11 2002
+++ b/Documentation/Configure.help	Tue Aug  6 10:38:11 2002
@@ -14314,12 +14314,13 @@
 
 Publish some reiserfs-specific info under /proc/fs/reiserfs
 CONFIG_REISERFS_PROC_INFO
-  Create under /proc/fs/reiserfs hierarchy of files, displaying
-  various ReiserFS statistics and internal data on the expense of
-  making your kernel or module slightly larger (+8 KB).  This also
-  increases amount of kernel memory required for each mount.  Almost
-  everyone but ReiserFS developers and people fine-tuning reiserfs or
-  tracing problems should say N.
+  Create under /proc/fs/reiserfs a hierarchy of files, displaying
+  various ReiserFS statistics and internal data at the expense of making
+  your kernel or module slightly larger (+8 KB). This also increases the
+  amount of kernel memory required for each mount by 440 bytes.
+  It isn't useful to average persons, and you probably can't measure the
+  performance cost of it.  If you are fine-tuning reiserfs, say Y,
+  otherwise say N.
 
 Second extended fs support
 CONFIG_EXT2_FS
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Aug  6 10:38:11 2002
+++ b/fs/Config.in	Tue Aug  6 10:38:11 2002
@@ -9,7 +9,7 @@
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
 tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Have reiserfs do extra internal checking' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
 dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
 
 dep_tristate 'ADFS file system support' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL
