Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTBKJkY>; Tue, 11 Feb 2003 04:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbTBKJkX>; Tue, 11 Feb 2003 04:40:23 -0500
Received: from so133005.bbo133.so-net.com.hk ([203.176.133.5]:11989 "EHLO
	anakin.wychk.org") by vger.kernel.org with ESMTP id <S267482AbTBKJkV>;
	Tue, 11 Feb 2003 04:40:21 -0500
Date: Tue, 11 Feb 2003 17:39:46 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add missing include for cpqfcTSinit.c
Message-ID: <20030211093946.GC339@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


This patch adds a missing include for the cpqfcTSinit.c file, which will
then allow compilation.  Problem was detected on an alpha.

It compiles but it is not known whether it works as I have no hardware
to test with.

patch is against Marcelo 2.4.21-pre4, status for 2.5 is unknown.


	-- G.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="cpqfcTSinit.c.patch"

--- linux-2.4.20/drivers/scsi/cpqfcTSinit.c.orig	2003-02-07 17:08:49.000000000 +0100
+++ linux-2.4.20/drivers/scsi/cpqfcTSinit.c	2003-02-08 10:09:51.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>	// ioremap()
 #include <linux/completion.h>
+#include <linux/init.h>
 #ifdef __alpha__
 #define __KERNEL_SYSCALLS__
 #endif

--KDt/GgjP6HVcx58l--
