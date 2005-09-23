Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVIWOQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVIWOQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVIWOQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:16:08 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:38916 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751004AbVIWOQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:16:07 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fuse: add required version info
Message-Id: <E1EIoLA-0006Qp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 16:15:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds information about required version of the userspace
library/utilities to Documentation/Changes.  Also add pointer to this
and to FUSE documentation from Kconfig.

Thanks to Anton Altaparmakov for the reminder.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/Documentation/Changes
===================================================================
--- linux.orig/Documentation/Changes	2005-09-23 15:03:10.000000000 +0200
+++ linux/Documentation/Changes	2005-09-23 15:45:19.000000000 +0200
@@ -245,6 +245,12 @@ udev
 udev is a userspace application for populating /dev dynamically with
 only entries for devices actually present. udev replaces devfs.
 
+FUSE
+----
+
+Needs libfuse 2.4.0 or later.  Absolute minimum is 2.3.0 but mount
+options 'direct_io' and 'kernel_cache' won't work.
+
 Networking
 ==========
 
@@ -402,6 +408,10 @@ udev
 ----
 o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html>
 
+FUSE
+----
+o <http://sourceforge.net/projects/fuse>
+
 Networking
 **********
 
Index: linux/fs/Kconfig
===================================================================
--- linux.orig/fs/Kconfig	2005-09-23 15:55:07.000000000 +0200
+++ linux/fs/Kconfig	2005-09-23 16:03:00.000000000 +0200
@@ -505,6 +505,9 @@ config FUSE_FS
 	  utilities is available from the FUSE homepage:
 	  <http://fuse.sourceforge.net/>
 
+	  See <file:Documentation/filesystems/fuse.txt> for more information.
+	  See <file:Documentation/Changes> for needed library/utility version.
+
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
