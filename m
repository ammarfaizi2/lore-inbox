Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVIBHEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVIBHEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 03:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVIBHEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 03:04:23 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:7088 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030497AbVIBHEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 03:04:22 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] remove driverfs references from init/do_mounts.c
Date: Fri, 2 Sep 2005 09:03:09 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200509020856.33213@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509020856.33213@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020903.10389@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.10, but still applies cleanly. It's just 
s/driverfs/sysfs/ in this file.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.10/init/do_mounts.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.10/init/do_mounts.c.fixed	2005-01-07 13:42:02.406392368 +0100
@@ -127,10 +127,10 @@ fail:
  *	   used when disk name of partitioned disk ends on a digit.
  *
  *	If name doesn't have fall into the categories above, we return 0.
- *	Driverfs is used to check if something is a disk name - it has
+ *	Sysfs is used to check if something is a disk name - it has
  *	all known disks under bus/block/devices.  If the disk name
- *	contains slashes, name of driverfs node has them replaced with
- *	bangs.  try_name() does the actual checks, assuming that driverfs
+ *	contains slashes, name of sysfs node has them replaced with
+ *	bangs.  try_name() does the actual checks, assuming that sysfs
  *	is mounted on rootfs /sys.
  */
 
