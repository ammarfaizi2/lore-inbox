Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTBKJfz>; Tue, 11 Feb 2003 04:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTBKJfy>; Tue, 11 Feb 2003 04:35:54 -0500
Received: from so133005.bbo133.so-net.com.hk ([203.176.133.5]:6613 "EHLO
	anakin.wychk.org") by vger.kernel.org with ESMTP id <S267348AbTBKJfl>;
	Tue, 11 Feb 2003 04:35:41 -0500
Date: Tue, 11 Feb 2003 17:35:02 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Add missing include for forte.c driver
Message-ID: <20030211093502.GB339@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


The following patch adds a missing include asm/io.h which prevented
the compilation of this driver on alpha.

It compiles, but I don't know if it works as I have no hardware to test
this against.

Patch is against marcelo 2.4.21-pre4, status for 2.5 is unknown.


	- G.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="forte.c.patch"

--- linux-2.4.20/drivers/sound/forte.c.orig	2003-02-08 20:32:08.000000000 +0100
+++ linux-2.4.20/drivers/sound/forte.c	2003-02-08 20:32:21.000000000 +0100
@@ -53,6 +53,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define DRIVER_NAME	"forte"
 #define DRIVER_VERSION 	"$Id: forte.c,v 1.55 2002/10/02 00:01:42 mkp Exp $"

--SkvwRMAIpAhPCcCJ--
