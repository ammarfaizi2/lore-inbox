Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTAKQ5R>; Sat, 11 Jan 2003 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTAKQ5R>; Sat, 11 Jan 2003 11:57:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2517 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267288AbTAKQ5P>; Sat, 11 Jan 2003 11:57:15 -0500
Date: Sat, 11 Jan 2003 18:05:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanup for drivers/scsi/ini9100u.*
Message-ID: <20030111170556.GP10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some no longer needed #define's from 
drivers/scsi/ini9100u.* .

cu
Adrian


--- linux-2.5.56/drivers/scsi/ini9100u.h.old	2003-01-11 17:57:40.000000000 +0100
+++ linux-2.5.56/drivers/scsi/ini9100u.h	2003-01-11 17:59:31.000000000 +0100
@@ -67,13 +67,6 @@
  *		- Added PCI_ID structure
  **************************************************************************/
 
-#ifndef	CVT_LINUX_VERSION
-#define	CVT_LINUX_VERSION(V,P,S)	(((V) * 65536) + ((P) * 256) + (S))
-#endif
-
-#ifndef	LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
 #include <linux/types.h>
 
 extern int i91u_detect(Scsi_Host_Template *);
@@ -130,15 +123,6 @@
 #ifndef NULL
 #define NULL     0		/* zero          */
 #endif
-#ifndef TRUE
-#define TRUE     (1)		/* boolean true  */
-#endif
-#ifndef FALSE
-#define FALSE    (0)		/* boolean false */
-#endif
-#ifndef FAILURE
-#define FAILURE  (-1)
-#endif
 
 #define i91u_MAXQUEUE		2
 #define TOTAL_SG_ENTRY		32
--- linux-2.5.56/drivers/scsi/ini9100u.c.old	2003-01-11 17:57:46.000000000 +0100
+++ linux-2.5.56/drivers/scsi/ini9100u.c	2003-01-11 17:59:57.000000000 +0100
@@ -106,14 +106,8 @@
  *		- Changed the assumption that HZ = 100
  **************************************************************************/
 
-#define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
-
 #error Please convert me to Documentation/DMA-mapping.txt
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
