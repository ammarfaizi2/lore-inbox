Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272970AbTGaKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272976AbTGaKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:48:27 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:36114 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272970AbTGaKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:48:23 -0400
Date: Thu, 31 Jul 2003 11:48:23 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 1/6] dm: don't use MODULE_PARM
Message-ID: <20030731104823.GE394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MODULE_PARM is deprecated in 2.6. Use the new module_param() macro.
[Kevin Corry]

--- diff/drivers/md/dm.c	2003-07-28 11:55:33.000000000 +0100
+++ source/drivers/md/dm.c	2003-07-31 11:13:11.000000000 +0100
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/blkpg.h>
 #include <linux/bio.h>
 #include <linux/mempool.h>
@@ -916,7 +917,7 @@
 module_init(dm_init);
 module_exit(dm_exit);
 
-MODULE_PARM(major, "i");
+module_param(major, uint, 0);
 MODULE_PARM_DESC(major, "The major number of the device mapper");
 MODULE_DESCRIPTION(DM_NAME " driver");
 MODULE_AUTHOR("Joe Thornber <thornber@sistina.com>");
