Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJWAnk>; Tue, 22 Oct 2002 20:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJWAnk>; Tue, 22 Oct 2002 20:43:40 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:7868 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262410AbSJWAne>; Tue, 22 Oct 2002 20:43:34 -0400
Date: Tue, 22 Oct 2002 20:42:07 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/net/irda/donauboe.c
Message-ID: <Pine.LNX.4.44.0210222039371.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch removes an outdated macro STATIC.
Regards,
Frank

--- linux/drivers/net/irda/donauboe.c.old	Sat Oct 19 12:05:14 2002
+++ linux/drivers/net/irda/donauboe.c	Tue Oct 22 19:34:58 2002
@@ -145,8 +145,6 @@
 
 /* No user servicable parts below here */
 
-#define STATIC static
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -245,7 +243,7 @@
 };
 #endif
 
-STATIC int
+static int
 toshoboe_checkfcs (unsigned char *buf, int len)
 {
   int i;
@@ -268,7 +266,7 @@
 /* Generic chip handling code */
 #ifdef DUMP_PACKETS
 static unsigned char dump[50];
-STATIC void 
+static void 
 _dumpbufs (unsigned char *data, int len, char tete)
 {
 int i,j;
@@ -283,7 +281,7 @@
 #endif
 
 /* Dump the registers */
-STATIC void
+static void
 toshoboe_dumpregs (struct toshoboe_cb *self)
 {
   __u32 ringbase;
@@ -331,7 +329,7 @@
 }
 
 /*Don't let the chip look at memory */
-STATIC void
+static void
 toshoboe_disablebm (struct toshoboe_cb *self)
 {
   __u8 command;
@@ -344,7 +342,7 @@
 }
 
 /* Shutdown the chip and point the taskfile reg somewhere else */
-STATIC void
+static void
 toshoboe_stopchip (struct toshoboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -376,7 +374,7 @@
 }
 
 /* Transmitter initialization */
-STATIC void
+static void
 toshoboe_start_DMA (struct toshoboe_cb *self, int opts)
 {
   OUTB (0x0, OBOE_ENABLEH);
@@ -386,7 +384,7 @@
 }
 
 /*Set the baud rate */
-STATIC void
+static void
 toshoboe_setbaud (struct toshoboe_cb *self)
 {
   __u16 pconfig = 0;
@@ -521,7 +519,7 @@
 }
 
 /*Let the chip look at memory */
-STATIC void
+static void
 toshoboe_enablebm (struct toshoboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -529,7 +527,7 @@
 }
 
 /*setup the ring */
-STATIC void
+static void
 toshoboe_initring (struct toshoboe_cb *self)
 {
   int i;
@@ -552,7 +550,7 @@
     }
 }
 
-STATIC void
+static void
 toshoboe_resetptrs (struct toshoboe_cb *self)
 {
   /* Can reset pointers by twidling DMA */
@@ -565,7 +563,7 @@
 }
 
 /* Called in locked state */
-STATIC void
+static void
 toshoboe_initptrs (struct toshoboe_cb *self)
 {
 
@@ -587,7 +585,7 @@
 
 /* Wake the chip up and get it looking at the rings */
 /* Called in locked state */
-STATIC void
+static void
 toshoboe_startchip (struct toshoboe_cb *self)
 {
   __u32 physaddr;
@@ -645,12 +643,12 @@
   toshoboe_initptrs (self);
 }
 
-STATIC void
+static void
 toshoboe_isntstuck (struct toshoboe_cb *self)
 {
 }
 
-STATIC void
+static void
 toshoboe_checkstuck (struct toshoboe_cb *self)
 {
   unsigned long flags;
@@ -669,7 +667,7 @@
 }
 
 /*Generate packet of about mtt us long */
-STATIC int
+static int
 toshoboe_makemttpacket (struct toshoboe_cb *self, void *buf, int mtt)
 {
   int xbofs;
@@ -698,7 +696,7 @@
 /***********************************************************************/
 /* Probe code */
 
-STATIC void
+static void
 toshoboe_dumptx (struct toshoboe_cb *self)
 {
   int i;
@@ -708,7 +706,7 @@
   PROBE_DEBUG(" [%d]\n",self->speed);
 }
 
-STATIC void
+static void
 toshoboe_dumprx (struct toshoboe_cb *self, int score)
 {
   int i;
@@ -739,13 +737,13 @@
     }
 }
 
-STATIC int toshoboe_invalid_dev(int irq) 
+static int toshoboe_invalid_dev(int irq) 
 {
   printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
   return 1;
 }
 
-STATIC void
+static void
 toshoboe_probeinterrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
@@ -793,7 +791,7 @@
     PROBE_DEBUG("I"); }
 }
 
-STATIC int
+static int
 toshoboe_maketestpacket (unsigned char *buf, int badcrc, int fir)
 {
   int i;
@@ -830,7 +828,7 @@
   return len;
 }
 
-STATIC int
+static int
 toshoboe_probefail (struct toshoboe_cb *self, char *msg)
 {
   printk (KERN_ERR DRIVER_NAME "probe(%d) failed %s\n",self-> speed, msg);
@@ -840,7 +838,7 @@
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_numvalidrcvs (struct toshoboe_cb *self)
 {
   int i, ret = 0;
@@ -851,7 +849,7 @@
   return ret;
 }
 
-STATIC int
+static int
 toshoboe_numrcvs (struct toshoboe_cb *self)
 {
   int i, ret = 0;
@@ -862,7 +860,7 @@
   return ret;
 }
 
-STATIC int
+static int
 toshoboe_probe (struct toshoboe_cb *self)
 {
   int i, j, n;
@@ -1018,7 +1016,7 @@
 /* Netdev style code */
 
 /* Transmit something */
-STATIC int
+static int
 toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1193,7 +1191,7 @@
 }
 
 /*interrupt handler */
-STATIC void
+static void
 toshoboe_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
@@ -1383,7 +1381,7 @@
     }
 }
 
-STATIC int
+static int
 toshoboe_net_init (struct net_device *dev)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -1395,7 +1393,7 @@
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_net_open (struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1440,7 +1438,7 @@
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_net_close (struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1478,7 +1476,7 @@
  *    Process IOCTL commands for this device
  *
  */
-STATIC int
+static int
 toshoboe_net_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
   struct if_irda_req *irq = (struct if_irda_req *) rq;
@@ -1546,7 +1544,7 @@
 MODULE_PARM (do_probe, "i");
 MODULE_PARM_DESC(do_probe, "Enable/disable chip probing and self-test");
 
-STATIC void
+static void
 toshoboe_close (struct pci_dev *pci_dev)
 {
   int i;
@@ -1590,7 +1588,7 @@
   return;
 }
 
-STATIC int
+static int
 toshoboe_open (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
 {
   struct toshoboe_cb *self;
@@ -1772,7 +1770,7 @@
   return err;
 }
 
-STATIC int
+static int
 toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
@@ -1801,7 +1799,7 @@
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_wakeup (struct pci_dev *pci_dev)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
@@ -1840,7 +1838,7 @@
   return pci_module_init(&toshoboe_pci_driver);
 }
 
-STATIC void __exit
+static void __exit
 toshoboe_cleanup (void)
 {
   pci_unregister_driver(&toshoboe_pci_driver);

