Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270047AbTGMAdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 20:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270048AbTGMAdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 20:33:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45760 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270047AbTGMAdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 20:33:14 -0400
Date: Sun, 13 Jul 2003 02:47:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: digilnux@dgii.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] pcxx.c: remove #if for kernel 2.0
Message-ID: <20030713004753.GR12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch below removes an #if for kernel 2.0 from 
drivers/char/pcxx.c .

Please apply
Adrian

--- linux-2.5.75-not-full/drivers/char/pcxx.c.old	2003-07-12 13:17:14.000000000 +0200
+++ linux-2.5.75-not-full/drivers/char/pcxx.c	2003-07-12 13:17:40.000000000 +0200
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
 
