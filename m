Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSD2PVx>; Mon, 29 Apr 2002 11:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSD2PVx>; Mon, 29 Apr 2002 11:21:53 -0400
Received: from www.microgate.com ([216.30.46.105]:1032 "EHLO sol.microgate.com")
	by vger.kernel.org with ESMTP id <S312526AbSD2PVw>;
	Mon, 29 Apr 2002 11:21:52 -0400
Subject: [PATCH] 2.5.11 synclink.h
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@transmeta.com" <torvalds@transmeta.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 29 Apr 2002 10:19:41 -0500
Message-Id: <1020093582.2721.10.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch to synclink.h against 2.5.11 is required
for the synclink_cs.c driver to compile.

Please apply.

Paul Fulghum
paulkf@microgate.com

--- linux-2.5.11/include/linux/synclink.h	Tue Apr 23 10:30:31 2002
+++ linux-2.5.11-mg/include/linux/synclink.h	Thu Apr 18 14:15:37 2002
@@ -1,17 +1,17 @@
 /*
  * SyncLink Multiprotocol Serial Adapter Driver
  *
- * $Id: synclink.h,v 3.5 2001/03/26 17:04:36 ez Exp $
+ * $Id: synclink.h,v 3.6 2002/02/20 21:58:20 paulkf Exp $
  *
  * Copyright (C) 1998-2000 by Microgate Corporation
- * 
- * Redistribution of this file is permitted under 
+ *
+ * Redistribution of this file is permitted under
  * the terms of the GNU Public License (GPL)
  */
 
 #ifndef _SYNCLINK_H_
 #define _SYNCLINK_H_
-#define SYNCLINK_H_VERSION 3.5
+#define SYNCLINK_H_VERSION 3.6
 
 #define BOOLEAN int
 #define TRUE 1
@@ -128,13 +128,18 @@
 #define MGSL_BUS_TYPE_EISA	2
 #define MGSL_BUS_TYPE_PCI	5
 
+#define MGSL_INTERFACE_DISABLE  0
+#define MGSL_INTERFACE_RS232    1
+#define MGSL_INTERFACE_V35      2
+#define MGSL_INTERFACE_RS422    3
+
 typedef struct _MGSL_PARAMS
 {
 	/* Common */
 
 	unsigned long	mode;		/* Asynchronous or HDLC */
 	unsigned char	loopback;	/* internal loopback mode */
-	
+
 	/* HDLC Only */
 
 	unsigned short	flags;
@@ -247,6 +252,8 @@
  * MGSL_IOCGSTATS	return current statistics
  * MGSL_IOCWAITEVENT	wait for specified event to occur
  * MGSL_LOOPTXDONE	transmit in HDLC LoopMode done
+ * MGSL_IOCSIF          set the serial interface type
+ * MGSL_IOCGIF          get the serial interface type
  */
 #define MGSL_MAGIC_IOC	'm'
 #define MGSL_IOCSPARAMS		_IOW(MGSL_MAGIC_IOC,0,struct _MGSL_PARAMS)
@@ -260,5 +267,7 @@
 #define MGSL_IOCWAITEVENT	_IOWR(MGSL_MAGIC_IOC,8,int)
 #define MGSL_IOCCLRMODCOUNT	_IO(MGSL_MAGIC_IOC,15)
 #define MGSL_IOCLOOPTXDONE	_IO(MGSL_MAGIC_IOC,9)
+#define MGSL_IOCSIF		_IO(MGSL_MAGIC_IOC,10)
+#define MGSL_IOCGIF		_IO(MGSL_MAGIC_IOC,11)
 
 #endif /* _SYNCLINK_H_ */

