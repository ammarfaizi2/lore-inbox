Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUDHXWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUDHXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:22:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22776 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261689AbUDHXWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:22:38 -0400
Date: Thu, 08 Apr 2004 16:22:03 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: gerg@snapgear.com, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.5] Fix for patch to add class support to stallion.c
Message-ID: <10720000.1081466523@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops. Realized I had a / in the file name in this patch too.

Please apply to correct it:

diff -Nrup -Xdontdiff linux-2.6.5/drivers/char/stallion.c linux-2.6.5p/drivers/char/stallion.c
--- linux-2.6.5/drivers/char/stallion.c	2004-04-08 16:14:33.000000000 -0700
+++ linux-2.6.5p/drivers/char/stallion.c	2004-04-08 16:16:11.000000000 -0700
@@ -3192,7 +3192,7 @@ int __init stl_init(void)
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"staliomem/%d", i);
-		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem/%d", i);
+		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;

