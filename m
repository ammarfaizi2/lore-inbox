Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317915AbSFSPed>; Wed, 19 Jun 2002 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317932AbSFSPec>; Wed, 19 Jun 2002 11:34:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:26332 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317915AbSFSPeb>; Wed, 19 Jun 2002 11:34:31 -0400
Date: Wed, 19 Jun 2002 17:34:27 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] Patch to fix all known linux/tqueue.h compile errors
Message-ID: <Pine.NEB.4.44.0206191726470.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below includes all linux/tqueue.h compile errors in 2.5.23 that
were found by Andy Pfiffer, Matthew Harrell, Stelian Pop and me in one
single patch.

cu
Adrian


--- linux-old/drivers/atm/idt77252.h.old	Wed Jun 19 14:13:25 2002
+++ linux/drivers/atm/idt77252.h	Wed Jun 19 14:14:21 2002
@@ -36,6 +36,7 @@

 #include <linux/ptrace.h>
 #include <linux/skbuff.h>
+#include <linux/tqueue.h>


 /*****************************************************************************/

--- linux/fs/smbfs/sock.c-ori	Wed Jun 19 09:52:33 2002
+++ linux/fs/smbfs/sock.c	Wed Jun 19 09:52:53 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>

--- linux/drivers/pcmcia/i82365.c.ori	Wed Jun 19 10:23:07 2002
+++ linux/drivers/pcmcia/i82365.c	Wed Jun 19 10:21:58 2002
@@ -46,6 +46,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
--- linux/drivers/usb/net/usbnet.c.ori	Wed Jun 19 10:27:35 2002
+++ linux/drivers/usb/net/usbnet.c	Wed Jun 19 10:27:50 2002
@@ -116,6 +116,7 @@
 #include <linux/etherdevice.h>
 #include <linux/random.h>
 #include <linux/ethtool.h>
+#include <linux/tqueue.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>

--- linux/net/irda/ircomm/ircomm_param.c.ori	Wed Jun 19 10:44:51 2002
+++ linux/net/irda/ircomm/ircomm_param.c	Wed Jun 19 10:46:38 2002
@@ -29,6 +29,7 @@
  ********************************************************************/

 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/interrupt.h>

 #include <net/irda/irda.h>
--- 1.4/drivers/pcmcia/hd64465_ss.c	Tue Feb  5 16:24:35 2002
+++ edited/drivers/pcmcia/hd64465_ss.c	Wed Jun 19 16:34:38 2002
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <asm/errno.h>
 #include <linux/irq.h>
+#include <linux/tqueue.h>

 #include <asm/io.h>
 #include <asm/hd64465.h>
--- 1.4/drivers/pcmcia/i82092.c	Sat Mar 23 23:55:21 2002
+++ edited/drivers/pcmcia/i82092.c	Wed Jun 19 16:35:04 2002
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>

 #include <pcmcia/cs_types.h>
 #include <pcmcia/ss.h>
===== drivers/pcmcia/tcic.c 1.6 vs edited =====
--- 1.6/drivers/pcmcia/tcic.c	Tue Feb  5 16:23:06 2002
+++ edited/drivers/pcmcia/tcic.c	Wed Jun 19 16:36:04 2002
@@ -49,6 +49,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>

 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>


