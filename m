Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTAKRlL>; Sat, 11 Jan 2003 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbTAKRlL>; Sat, 11 Jan 2003 12:41:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40404 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267315AbTAKRlJ>; Sat, 11 Jan 2003 12:41:09 -0500
Date: Sat, 11 Jan 2003 18:49:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: bkaindl@netway.at
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 #if from drivers/char/pcxx.c
Message-ID: <20030111174950.GS10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below removes an #if for kernel 2.0 from drivers/char/pcxx.c.

Please apply
Adrian

--- linux-2.5.56/drivers/char/pcxx.c.old	2003-01-11 18:47:21.000000000 +0100
+++ linux-2.5.56/drivers/char/pcxx.c	2003-01-11 18:47:45.000000000 +0100
@@ -110,7 +110,6 @@
 static int altpin[]       = {0, 0, 0, 0};
 static int numports[]     = {0, 0, 0, 0};
 
-# if (LINUX_VERSION_CODE > 0x020111)
 MODULE_AUTHOR("Bernhard Kaindl");
 MODULE_DESCRIPTION("Digiboard PC/X{i,e,eve} driver");
 MODULE_LICENSE("GPL");
@@ -121,7 +120,6 @@
 MODULE_PARM(memsize,     "1-4i");
 MODULE_PARM(altpin,      "1-4i");
 MODULE_PARM(numports,    "1-4i");
-# endif
 
 #endif MODULE
 

