Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbTDHAPL (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTDHAMz (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:12:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22401
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263814AbTDGXXA (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:23:00 -0400
Date: Tue, 8 Apr 2003 01:41:51 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080041.h380fpov009336@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ite C99 and version/h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ite8172.c linux-2.5.67-ac1/sound/oss/ite8172.c
--- linux-2.5.67/sound/oss/ite8172.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ite8172.c	2003-04-03 23:52:57.000000000 +0100
@@ -51,7 +51,6 @@
  *  Revision history
  *    02.08.2001  0.1   Initial release
  */
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
@@ -863,11 +862,11 @@
 }
 
 static /*const*/ struct file_operations it8172_mixer_fops = {
-    owner:	THIS_MODULE,
-    llseek:	no_llseek,
-    ioctl:	it8172_ioctl_mixdev,
-    open:	it8172_open_mixdev,
-    release:	it8172_release_mixdev,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .ioctl	= it8172_ioctl_mixdev,
+    .open	= it8172_open_mixdev,
+    .release	= it8172_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -1630,15 +1629,15 @@
 }
 
 static /*const*/ struct file_operations it8172_audio_fops = {
-    owner:	THIS_MODULE,
-    llseek:	no_llseek,
-    read:	it8172_read,
-    write:	it8172_write,
-    poll:	it8172_poll,
-    ioctl:	it8172_ioctl,
-    mmap:	it8172_mmap,
-    open:	it8172_open,
-    release:	it8172_release,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .read	= it8172_read,
+    .write	= it8172_write,
+    .poll	= it8172_poll,
+    .ioctl	= it8172_ioctl,
+    .mmap	= it8172_mmap,
+    .open	= it8172_open,
+    .release	= it8172_release,
 };
 
 
