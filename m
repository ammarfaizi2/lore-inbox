Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272917AbTG3OjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272920AbTG3OjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:39:12 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:14103 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S272917AbTG3OjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:39:06 -0400
Message-ID: <3F27D963.9040609@terra.com.br>
Date: Wed, 30 Jul 2003 11:42:43 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
CC: gerg@snapgear.com, support@stallion.oz.au
Subject: [PATCH] drivers/char/stallion.c: devfs_mk_cdev fix
Content-Type: multipart/mixed;
 boundary="------------090201070603000902080808"
X-OriginalArrivalTime: 30 Jul 2003 14:44:41.0453 (UTC) FILETIME=[1BEDB1D0:01C356A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201070603000902080808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	devfs_mk_cdev now only takes 3 parameters (dev_t, umode_t, fmt..), so 
update this driver to the new API.

	Please apply,

Felipe

--------------090201070603000902080808
Content-Type: text/plain;
 name="stallion-devfs_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stallion-devfs_fix.patch"

--- linux-2.6.0-test2/drivers/char/stallion.c.orig	Wed Jul 30 11:38:08 2003
+++ linux-2.6.0-test2/drivers/char/stallion.c	Wed Jul 30 11:37:51 2003
@@ -3173,7 +3171,7 @@
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
-				&stl_fsiomem, NULL, "staliomem/%d", i);
+				"staliomem/%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;

--------------090201070603000902080808--

