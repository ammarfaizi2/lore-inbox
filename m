Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUGJLuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUGJLuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUGJLuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:50:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34250 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266217AbUGJLuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:50:17 -0400
Date: Sat, 10 Jul 2004 13:50:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Anton Blanchard <anton@samba.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill IKCONFIG_VERSION
Message-ID: <20040710115012.GI28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below (already ACK'ed by Randy Dunlap) kills the unused 
IKCONFIG_VERSION from kernel/configs.c .

This patch is based on a previous patch by Anton Blanchard and a an idea 
of Bartlomiej Zolnierkiewicz.
(I hope I haven't forgotten anyone who contributed to this patch. ;-)  )


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/kernel/configs.c.old	2004-07-10 13:44:01.000000000 +0200
+++ linux-2.6.7-mm7-full/kernel/configs.c	2004-07-10 13:44:19.000000000 +0200
@@ -58,8 +58,6 @@
 /**************************************************/
 /* globals and useful constants                   */
 
-static const char IKCONFIG_VERSION[] __attribute_used__ __initdata = "0.7";
-
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
 		      size_t len, loff_t * offset)

