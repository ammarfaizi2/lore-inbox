Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTBKJnK>; Tue, 11 Feb 2003 04:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTBKJnJ>; Tue, 11 Feb 2003 04:43:09 -0500
Received: from so133005.bbo133.so-net.com.hk ([203.176.133.5]:13013 "EHLO
	anakin.wychk.org") by vger.kernel.org with ESMTP id <S267550AbTBKJnG>;
	Tue, 11 Feb 2003 04:43:06 -0500
Date: Tue, 11 Feb 2003 17:42:28 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] wrap around asm/mtrr.h in #ifdef ... #endif
Message-ID: <20030211094228.GD339@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


The following two patches wrap around asm/mtrr.h with CONFIG_MTRR #ifdef for
the sis video driver.


	-- G.
-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="sis_accel.c.patch"

--- linux-2.4.20/drivers/video/sis/sis_accel.c.orig	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/drivers/video/sis/sis_accel.c	2003-02-11 10:55:41.000000000 +0100
@@ -40,7 +40,9 @@
 #include <linux/sisfb.h>
 
 #include <asm/io.h>
+#ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
+#endif
 
 #include <video/fbcon.h>
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,33)

--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="sis_main.c.patch"

--- linux-2.4.20/drivers/video/sis/sis_main.c.orig	2003-02-11 10:56:48.000000000 +0100
+++ linux-2.4.20/drivers/video/sis/sis_main.c	2003-02-11 10:55:24.000000000 +0100
@@ -52,7 +52,9 @@
 #include <linux/sisfb.h>
 
 #include <asm/io.h>
+#ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
+#endif
 
 #include <video/fbcon.h>
 #include <video/fbcon-cfb8.h>

--qGV0fN9tzfkG3CxV--
