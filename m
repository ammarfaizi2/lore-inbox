Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVF0UQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVF0UQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVF0UQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:16:48 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:8066 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261570AbVF0UQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:16:38 -0400
Date: Mon, 27 Jun 2005 13:16:33 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH -mm] Documentation/feature-removal-schedule.txt in date
 order
Message-Id: <20050627131633.62af898b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Someone asked for this last week and I haven't seen it patched yet,
so here it is.

a.  arrange feature-removal items in date order
b.  fix a typo
c.  update an email address

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 Documentation/feature-removal-schedule.txt |  111 ++++++++++++++---------------
 1 files changed, 57 insertions(+), 54 deletions(-)

diff -Naurp linux-2612-mm2/Documentation/feature-removal-schedule.txt~date_order linux-2612-mm2/Documentation/feature-removal-schedule.txt
--- linux-2612-mm2/Documentation/feature-removal-schedule.txt~date_order	2005-06-27 12:39:25.000000000 -0700
+++ linux-2612-mm2/Documentation/feature-removal-schedule.txt	2005-06-27 13:11:46.000000000 -0700
@@ -4,16 +4,14 @@ exactly is going away, why it is happeni
 the work.  When the feature is removed from the kernel, it should also
 be removed from this file.
 
+(Please keep this file in order by date of removal.)
 ---------------------------
 
-What:	devfs
-When:	July 2005
-Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
-	function calls throughout the kernel tree
-Why:	It has been unmaintained for a number of years, has unfixable
-	races, contains a naming policy within the kernel that is
-	against the LSB, and can be replaced by using udev.
-Who:	Greg Kroah-Hartman <greg@kroah.com>
+What:	register_ioctl32_conversion() / unregister_ioctl32_conversion()
+When:	April 2005
+Why:	Replaced by ->compat_ioctl in file_operations and other method
+	vectors.
+Who:	Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
 
 ---------------------------
 
@@ -25,6 +23,17 @@ Who:	Pavel Machek <pavel@suse.cz>
 
 ---------------------------
 
+What:	devfs
+When:	July 2005
+Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
+	function calls throughout the kernel tree
+Why:	It has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+Who:	Greg Kroah-Hartman <greg@kroah.com>
+
+---------------------------
+
 What:	PCI Name Database (CONFIG_PCI_NAMES)
 When:	July 2005
 Why:	It bloats the kernel unnecessarily, and is handled by userspace better
@@ -39,46 +48,7 @@ When:	September 2005
 Why:	Replaced by io_remap_pfn_range() which allows more memory space
 	addressabilty (by using a pfn) and supports sparc & sparc64
 	iospace as part of the pfn.
-Who:	Randy Dunlap <rddunlap@osdl.org>
-
----------------------------
-
-What:	RAW driver (CONFIG_RAW_DRIVER)
-When:	December 2005
-Why:	declared obsolete since kernel 2.6.3
-	O_DIRECT can be used instead
-Who:	Adrian Bunk <bunk@stusta.de>
-
----------------------------
-
-What:	register_ioctl32_conversion() / unregister_ioctl32_conversion()
-When:	April 2005
-Why:	Replaced by ->compat_ioctl in file_operations and other method
-	vecors.
-Who:	Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
-
----------------------------
-
-What:	RCU API moves to EXPORT_SYMBOL_GPL
-When:	April 2006
-Files:	include/linux/rcupdate.h, kernel/rcupdate.c
-Why:	Outside of Linux, the only implementations of anything even
-	vaguely resembling RCU that I am aware of are in DYNIX/ptx,
-	VM/XA, Tornado, and K42.  I do not expect anyone to port binary
-	drivers or kernel modules from any of these, since the first two
-	are owned by IBM and the last two are open-source research OSes.
-	So these will move to GPL after a grace period to allow
-	people, who might be using implementations that I am not aware
-	of, to adjust to this upcoming change.
-Who:	Paul E. McKenney <paulmck@us.ibm.com>
-
----------------------------
-
-What:	remove verify_area()
-When:	July 2006
-Files:	Various uaccess.h headers.
-Why:	Deprecated and redundant. access_ok() should be used instead.
-Who:	Jesper Juhl <juhl-lkml@dif.dk>
+Who:	Randy Dunlap <rdunlap@xenotime.net>
 
 ---------------------------
 
@@ -102,6 +72,15 @@ Who:	Jody McIntyre <scjody@steamballoon.
 
 ---------------------------
 
+What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
+When:	November 2005
+Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
+Why:	Match the other drivers' name for the same function, duplicate names
+	will be available until removal of old names.
+Who:	Grant Coady <gcoady@gmail.com>
+
+---------------------------
+
 What:	register_serial/unregister_serial
 When:	December 2005
 Why:	This interface does not allow serial ports to be registered against
@@ -112,12 +91,26 @@ Who:	Russell King <rmk@arm.linux.org.uk>
 
 ---------------------------
 
-What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
-When:	November 2005
-Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
-Why:	Match the other drivers' name for the same function, duplicate names
-	will be available until removal of old names.
-Who:	Grant Coady <gcoady@gmail.com>
+What:	RAW driver (CONFIG_RAW_DRIVER)
+When:	December 2005
+Why:	declared obsolete since kernel 2.6.3
+	O_DIRECT can be used instead
+Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
+What:	RCU API moves to EXPORT_SYMBOL_GPL
+When:	April 2006
+Files:	include/linux/rcupdate.h, kernel/rcupdate.c
+Why:	Outside of Linux, the only implementations of anything even
+	vaguely resembling RCU that I am aware of are in DYNIX/ptx,
+	VM/XA, Tornado, and K42.  I do not expect anyone to port binary
+	drivers or kernel modules from any of these, since the first two
+	are owned by IBM and the last two are open-source research OSes.
+	So these will move to GPL after a grace period to allow
+	people, who might be using implementations that I am not aware
+	of, to adjust to this upcoming change.
+Who:	Paul E. McKenney <paulmck@us.ibm.com>
 
 ---------------------------
 
@@ -134,3 +127,13 @@ When:	April 2006
 Files:	kernel/panic.c
 Why:	No modular usage in the kernel.
 Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
+What:	remove verify_area()
+When:	July 2006
+Files:	Various uaccess.h headers.
+Why:	Deprecated and redundant. access_ok() should be used instead.
+Who:	Jesper Juhl <juhl-lkml@dif.dk>
+
+---------------------------
