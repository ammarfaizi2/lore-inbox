Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJWAzz>; Tue, 22 Oct 2002 20:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJWAzz>; Tue, 22 Oct 2002 20:55:55 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:57031 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262397AbSJWAzy>; Tue, 22 Oct 2002 20:55:54 -0400
Date: Tue, 22 Oct 2002 20:54:29 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/net/wan/ remove STATIC macro
Message-ID: <Pine.LNX.4.44.0210222052180.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patches remove STATIC macro references.

Regards,
Frank

--- linux/drivers/net/wan/sdlamain.c.old	Sat Oct 19 12:05:27 2002
+++ linux/drivers/net/wan/sdlamain.c	Tue Oct 22 20:24:24 2002
@@ -173,12 +173,6 @@
 
 /****** Defines & Macros ****************************************************/
 
-#ifdef	_DEBUG_
-#define	STATIC
-#else
-#define	STATIC		static
-#endif
-
 #define	DRV_VERSION	5		/* version number */
 #define	DRV_RELEASE	0		/* release (minor version) number */
 #define	MAX_CARDS	16		/* max number of adapters */
@@ -209,7 +203,7 @@
 static int ioctl_exec	(sdla_t* card, sdla_exec_t* u_exec, int);
 
 /* Miscellaneous functions */
-STATIC void sdla_isr	(int irq, void* dev_id, struct pt_regs *regs);
+static void sdla_isr	(int irq, void* dev_id, struct pt_regs *regs);
 static void release_hw  (sdla_t *card);
 static void run_wanpipe_tq (unsigned long);
 
@@ -1092,7 +1086,7 @@
  * o acknowledge SDLA hardware interrupt.
  * o call protocol-specific interrupt service routine, if any.
  */
-STATIC void sdla_isr (int irq, void* dev_id, struct pt_regs *regs)
+static void sdla_isr (int irq, void* dev_id, struct pt_regs *regs)
 {
 #define	card	((sdla_t*)dev_id)
 

--- linux/drivers/net/wan/wanpipe_multppp.c.old	Sat Oct 19 12:05:27 2002
+++ linux/drivers/net/wan/wanpipe_multppp.c	Tue Oct 22 20:27:10 2002
@@ -58,12 +58,6 @@
 
 /****** Defines & Macros ****************************************************/
 
-#ifdef	_DEBUG_
-#define	STATIC
-#else
-#define	STATIC		static
-#endif
-
 /* reasons for enabling the timer interrupt on the adapter */
 #define TMR_INT_ENABLED_UDP   	0x01
 #define TMR_INT_ENABLED_UPDATE	0x02
@@ -1347,7 +1341,7 @@
 /*============================================================================
  * Cisco HDLC interrupt service routine.
  */
-STATIC void wsppp_isr (sdla_t* card)
+static void wsppp_isr (sdla_t* card)
 {
 	netdevice_t* dev;
 	SHARED_MEMORY_INFO_STRUCT* flags = NULL;

