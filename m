Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTASXa4>; Sun, 19 Jan 2003 18:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTASXa4>; Sun, 19 Jan 2003 18:30:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47572 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267720AbTASXax>; Sun, 19 Jan 2003 18:30:53 -0500
Date: Mon, 20 Jan 2003 00:39:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] rio: remove #include <linux/compatmac.h>
Message-ID: <20030119233950.GD12601@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes #include <linux/compatmac.h> from 
drivers/char/rio/*. The only file that actually used it was rio_linux.c 
and I've expanded the #define's there.

I've tested the compilation with 2.5.59.


diffstat output:
 rio_linux.c |   25 +++++++++++--------------
 rioboot.c   |    1 -
 riocmd.c    |    1 -
 rioctrl.c   |    1 -
 rioinit.c   |    1 -
 riointr.c   |    1 -
 rioparam.c  |    1 -
 rioroute.c  |    1 -
 riotable.c  |    1 -
 riotty.c    |    1 -
 10 files changed, 11 insertions(+), 23 deletions(-)


cu
Adrian

--- linux-2.5.59-full/drivers/char/rio/riointr.c.old	2003-01-20 00:12:34.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/riointr.c	2003-01-20 00:12:54.000000000 +0100
@@ -48,7 +48,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 #include <linux/delay.h>
--- linux-2.5.59-full/drivers/char/rio/rioboot.c.old	2003-01-20 00:12:55.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rioboot.c	2003-01-20 00:13:03.000000000 +0100
@@ -48,7 +48,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/rioinit.c.old	2003-01-20 00:13:05.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rioinit.c	2003-01-20 00:13:16.000000000 +0100
@@ -47,7 +47,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/riocmd.c.old	2003-01-20 00:13:16.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/riocmd.c	2003-01-20 00:13:36.000000000 +0100
@@ -47,7 +47,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 #include "linux_compat.h"
--- linux-2.5.59-full/drivers/char/rio/riotty.c.old	2003-01-20 00:13:36.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/riotty.c	2003-01-20 00:13:44.000000000 +0100
@@ -51,7 +51,6 @@
 
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/rioctrl.c.old	2003-01-20 00:13:45.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rioctrl.c	2003-01-20 00:13:53.000000000 +0100
@@ -47,7 +47,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/rioroute.c.old	2003-01-20 00:13:53.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rioroute.c	2003-01-20 00:14:01.000000000 +0100
@@ -46,7 +46,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/riotable.c.old	2003-01-20 00:14:01.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/riotable.c	2003-01-20 00:14:09.000000000 +0100
@@ -48,7 +48,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/rioparam.c.old	2003-01-20 00:14:09.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rioparam.c	2003-01-20 00:14:17.000000000 +0100
@@ -48,7 +48,6 @@
 #include <linux/termios.h>
 #include <linux/serial.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 
--- linux-2.5.59-full/drivers/char/rio/rio_linux.c.old	2003-01-20 00:33:15.000000000 +0100
+++ linux-2.5.59-full/drivers/char/rio/rio_linux.c	2003-01-20 00:31:35.000000000 +0100
@@ -59,7 +59,6 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 
-#include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
 #if BITS_PER_LONG != 32
@@ -725,14 +724,14 @@
   switch (cmd) {
 #if 0
   case TIOCGSOFTCAR:
-    rc = Put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
+    rc = put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
                   (unsigned int *) arg);
     break;
 #endif
   case TIOCSSOFTCAR:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
                           sizeof(int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
+      get_user(ival, (unsigned int *) arg);
       tty->termios->c_cflag =
         (tty->termios->c_cflag & ~CLOCAL) |
         (ival ? CLOCAL : 0);
@@ -784,7 +783,7 @@
   case TIOCMBIS:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
                           sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
+      get_user(ival, (unsigned int *) arg);
       rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
                            ((ival & TIOCM_RTS) ? 1 : -1));
     }
@@ -792,7 +791,7 @@
   case TIOCMBIC:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
                           sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
+      get_user(ival, (unsigned int *) arg);
       rio_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
                            ((ival & TIOCM_RTS) ? 0 : -1));
     }
@@ -800,7 +799,7 @@
   case TIOCMSET:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
                           sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
+      get_user(ival, (unsigned int *) arg);
       rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
                            ((ival & TIOCM_RTS) ? 1 : 0));
     }
@@ -1126,7 +1125,7 @@
             t, CNTRL_REG_GOODVALUE); 
     writel (CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);  
   }
-  my_iounmap (hwbase, rebase);
+  iounmap((char*) rebase);
 }
 #endif
 
@@ -1201,7 +1200,7 @@
 
       hp = &p->RIOHosts[p->RIONumHosts];
       hp->PaddrP =  tint & PCI_BASE_ADDRESS_MEM_MASK;
-      hp->Ivec = get_irq (pdev);
+      hp->Ivec = pdev->irq;
       if (((1 << hp->Ivec) & rio_irqmask) == 0)
               hp->Ivec = 0;
       hp->CardP	= (struct DpRam *)
@@ -1234,8 +1233,7 @@
               p->RIONumHosts++;
               found++;
       } else {
-              my_iounmap (p->RIOHosts[p->RIONumHosts].PaddrP, 
-                          p->RIOHosts[p->RIONumHosts].Caddr);
+              iounmap((char*) (p->RIOHosts[p->RIONumHosts].Caddr));
       }
       
 #ifdef TWO_ZERO
@@ -1272,7 +1270,7 @@
 
       hp = &p->RIOHosts[p->RIONumHosts];
       hp->PaddrP =  tint & PCI_BASE_ADDRESS_MEM_MASK;
-      hp->Ivec = get_irq (pdev);
+      hp->Ivec = pdev->irq;
       if (((1 << hp->Ivec) & rio_irqmask) == 0) 
       	hp->Ivec = 0;
       hp->Ivec |= 0x8000; /* Mark as non-sharable */
@@ -1307,8 +1305,7 @@
         p->RIONumHosts++;
         found++;
       } else {
-        my_iounmap (p->RIOHosts[p->RIONumHosts].PaddrP, 
-                    p->RIOHosts[p->RIONumHosts].Caddr);
+        iounmap((char*) (p->RIOHosts[p->RIONumHosts].Caddr));
       }
 #else
       printk (KERN_ERR "Found an older RIO PCI card, but the driver is not "
@@ -1361,7 +1358,7 @@
       }
 
     if (!okboard)
-      my_iounmap (hp->PaddrP, hp->Caddr);
+      iounmap ((char*) (hp->Caddr));
     }
   }
 
