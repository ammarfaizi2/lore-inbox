Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTHNGaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHNGaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:30:17 -0400
Received: from [209.162.198.165] ([209.162.198.165]:1767 "EHLO
	magic.skylab.org") by vger.kernel.org with ESMTP id S272265AbTHNGaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:30:13 -0400
Date: Wed, 13 Aug 2003 23:30:10 -0700 (PDT)
From: Michael Plump <lkml@mathfillsmewithgreatjoy.com>
X-X-Sender: plumpy@localhost.krimedawg.org
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org
Subject: PATCH: Correct DEVPTS config help
Message-ID: <Pine.LNX.4.56.0308132322060.798@localhost.krimedawg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The help for CONFIG_DEVPTS_FS claims that devfs "is a more general
facility".  But that apparently hasn't been true since 2.5.68.  This patch
removes that claim, and adds a warning to the DEVFS_FS help.

--- linux-2.6.0-test3/fs/Kconfig	2003-08-08 21:37:26.000000000 -0700
+++ linux/fs/Kconfig	2003-08-13 23:20:32.000000000 -0700
@@ -777,6 +777,10 @@
 	  the material in <file:Documentation/filesystems/devfs/>, especially
 	  the file README there.

+          Note that devfs no longer manages /dev/pts!  If you are using UNIX98
+          ptys, you will also need to enable (and mount) the /dev/pts
+          filesystem (CONFIG_DEVPTS_FS).
+
 	  If unsure, say N.

 config DEVFS_MOUNT
@@ -824,9 +828,6 @@
 	  API. Please read <file:Documentation/Changes> for more information
 	  about the Unix98 pty devices.

-	  Note that the experimental "/dev file system support"
-	  (CONFIG_DEVFS_FS)  is a more general facility.
-
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
 	depends on DEVPTS_FS
