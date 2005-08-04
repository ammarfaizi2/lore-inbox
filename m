Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVHDN2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVHDN2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVHDN2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:28:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:51407 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262527AbVHDN2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:28:54 -0400
Subject: [patch] inotify: update help text
From: Robert Love <rml@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mr Morton <akpm@osdl.org>, The Cutch <ttb@tentacle.dhs.org>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 09:28:55 -0400
Message-Id: <1123162135.30486.16.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inotify help text still refers to the character device.  Update it.

Fixes kernel bug #4993.

Signed-off-by: Robert Love <rml@novell.com>

 fs/Kconfig |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc3-git8/fs/Kconfig	2005-07-27 10:59:32.000000000 -0400
+++ linux/fs/Kconfig	2005-08-04 09:26:46.000000000 -0400
@@ -363,12 +363,15 @@
 	bool "Inotify file change notification support"
 	default y
 	---help---
-	  Say Y here to enable inotify support and the /dev/inotify character
-	  device.  Inotify is a file change notification system and a
+	  Say Y here to enable inotify support and the associated system
+	  calls.  Inotify is a file change notification system and a
 	  replacement for dnotify.  Inotify fixes numerous shortcomings in
 	  dnotify and introduces several new features.  It allows monitoring
-	  of both files and directories via a single open fd.  Multiple file
-	  events are supported.
+	  of both files and directories via a single open fd.  Other features
+	  include multiple file events, one-shot support, and unmount
+	  notification.
+
+	  For more information, see Documentation/filesystems/inotify.txt
 
 	  If unsure, say Y.
 


