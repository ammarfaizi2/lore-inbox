Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTBKJxW>; Tue, 11 Feb 2003 04:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267355AbTBKJxW>; Tue, 11 Feb 2003 04:53:22 -0500
Received: from so133005.bbo133.so-net.com.hk ([203.176.133.5]:16341 "EHLO
	anakin.wychk.org") by vger.kernel.org with ESMTP id <S267354AbTBKJxV>;
	Tue, 11 Feb 2003 04:53:21 -0500
Date: Tue, 11 Feb 2003 17:52:42 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] add missing includes for the r8169.c driver
Message-ID: <20030211095242.GA527@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,

The following patch adds two missing includes for the r8169.c driver, which
without, prevented compilation.  The problem was discovered on an alpha.

It compiles, but as I have no hardware to test with I cannot test whether
it works.

The patch is against marcelo's 2.4.21-pre4, status for 2.5 is unknown.


	-- G.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="r8169-2.c.patch"

--- linux-2.4.20/drivers/net/r8169.c.orig	2003-02-09 06:17:54.000000000 +0100
+++ linux-2.4.20/drivers/net/r8169.c	2003-02-09 06:18:35.000000000 +0100
@@ -41,6 +41,8 @@
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
 #include <linux/crc32.h>
+#include <linux/init.h>
+#include <asm/io.h>
 
 #define RTL8169_VERSION "1.2"
 #define MODULENAME "r8169"

--+HP7ph2BbKc20aGI--
