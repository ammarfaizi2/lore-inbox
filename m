Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTARQt0>; Sat, 18 Jan 2003 11:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTARQtZ>; Sat, 18 Jan 2003 11:49:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5609 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264940AbTARQtP>; Sat, 18 Jan 2003 11:49:15 -0500
Date: Sat, 18 Jan 2003 17:58:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanup in drivers/scsi/i91uscsi.h
Message-ID: <20030118165809.GH10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the follwojng small updates in 
drivers/scsi/i91uscsi.h:
- remove #if for kernel 2.0
- remove unused #define TRUE/FALSE

cu
Adrian

--- linux-2.5.59-full/drivers/scsi/i91uscsi.h.old	2003-01-18 17:53:01.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/i91uscsi.h	2003-01-18 17:53:55.000000000 +0100
@@ -70,12 +70,6 @@
 #ifndef NULL
 #define NULL     0		/* zero          */
 #endif
-#ifndef TRUE
-#define TRUE     (1)		/* boolean true  */
-#endif
-#ifndef FALSE
-#define FALSE    (0)		/* boolean false */
-#endif
 #ifndef FAILURE
 #define FAILURE  (-1)
 #endif
@@ -597,11 +591,9 @@
 	TCS HCS_Tcs[MAX_TARGETS];	/* 78 */
 	ULONG pSRB_head;	/* SRB save queue header     */
 	ULONG pSRB_tail;	/* SRB save queue tail       */
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spinlock_t HCS_AvailLock;
 	spinlock_t HCS_SemaphLock;
 	spinlock_t pSRB_lock;	/* SRB queue lock            */
-#endif
 } HCS;
 
 /* Bit Definition for HCB_Config */

