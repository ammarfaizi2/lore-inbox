Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTHRSpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTHRSpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:45:51 -0400
Received: from verein.lst.de ([212.34.189.10]:44718 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S272234AbTHRSpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:45:47 -0400
Date: Mon, 18 Aug 2003 20:40:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark devfs obsolete
Message-ID: <20030818184041.GA7165@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The person listed as maintainer hasn't touched it for alomost a year
and after that only some odd fixes and my interface fixes went it.

With udev we also have a proper replacement.

This time with various spelling fixes pointed out by all the nice
people on lkml.


--- 1.166/MAINTAINERS	Thu Aug 14 21:17:45 2003
+++ edited/MAINTAINERS	Sun Aug 17 21:36:11 2003
@@ -558,10 +558,7 @@
 S:	Maintained
 
 DEVICE FILESYSTEM
-P:	Richard Gooch
-M:	rgooch@atnf.csiro.au
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
+S:	Obsolete
 
 DIGI INTL. EPCA DRIVER
 P:	Digi International, Inc
--- 1.28/fs/Kconfig	Thu Aug 14 02:20:32 2003
+++ edited/fs/Kconfig	Sun Aug 17 21:36:11 2003
@@ -762,7 +762,7 @@
 	  programs depend on this, so everyone should say Y here.
 
 config DEVFS_FS
-	bool "/dev file system support (EXPERIMENTAL)"
+	bool "/dev file system support (OBSOLETE)"
 	depends on EXPERIMENTAL
 	help
 	  This is support for devfs, a virtual file system (like /proc) which
@@ -780,6 +780,13 @@
 	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
 	  ptys, you will also need to enable (and mount) the /dev/pts
 	  filesystem (CONFIG_DEVPTS_FS).
+
+	  Note that devfs has been obsoleted by udev,
+	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
+	  It has been stripped down to a bare minimum and is only provided for
+	  legacy installations that use its naming scheme which is
+	  unfortunately different from the names normal Linux installations
+	  use.
 
 	  If unsure, say N.
 
