Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJMIyX>; Sun, 13 Oct 2002 04:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJMIyX>; Sun, 13 Oct 2002 04:54:23 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:55306 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261472AbSJMIyW>;
	Sun, 13 Oct 2002 04:54:22 -0400
Date: Sun, 13 Oct 2002 11:00:03 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.5.42 - C99 designated initializers for drivers/char/i810-tco.c
Message-ID: <20021013110003.A13989@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A patch for drivers/char/i810-tco.c so that it uses C99 designated initializers.

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.787   -> 1.788  
#	drivers/char/i810-tco.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/13	wim@iguana.be	1.788
# [PATCH] C99 designated initializers for drivers/char/i810-tco.c
# --------------------------------------------
#
diff -Nru a/drivers/char/i810-tco.c b/drivers/char/i810-tco.c
--- a/drivers/char/i810-tco.c	Sun Oct 13 10:56:03 2002
+++ b/drivers/char/i810-tco.c	Sun Oct 13 10:56:04 2002
@@ -244,9 +244,9 @@
 	int options, retval = -EINVAL;
 
 	static struct watchdog_info ident = {
-		options:		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-		firmware_version:	0,
-		identity:		"i810 TCO timer",
+		.options =		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+		.firmware_version =	0,
+		.identity =		"i810 TCO timer",
 	};
 	switch (cmd) {
 		default:
@@ -371,17 +371,17 @@
 }
 
 static struct file_operations i810tco_fops = {
-	owner:		THIS_MODULE,
-	write:		i810tco_write,
-	ioctl:		i810tco_ioctl,
-	open:		i810tco_open,
-	release:	i810tco_release,
+	.owner =	THIS_MODULE,
+	.write =	i810tco_write,
+	.ioctl =	i810tco_ioctl,
+	.open =		i810tco_open,
+	.release =	i810tco_release,
 };
 
 static struct miscdevice i810tco_miscdev = {
-	minor:		WATCHDOG_MINOR,
-	name:		"watchdog",
-	fops:		&i810tco_fops,
+	.minor =	WATCHDOG_MINOR,
+	.name =		"watchdog",
+	.fops =		&i810tco_fops,
 };
 
 static int __init watchdog_init (void)
