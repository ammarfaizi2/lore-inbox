Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQKUVzm>; Tue, 21 Nov 2000 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQKUVze>; Tue, 21 Nov 2000 16:55:34 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:15881 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129520AbQKUVz2>; Tue, 21 Nov 2000 16:55:28 -0500
Date: Tue, 21 Nov 2000 22:25:01 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: torvalds@transmeta.com
cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <Pine.LNX.4.21.0011211438490.756-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Quick removal of unnecessary initialization to 0.

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>


diff -uNr linux-240t11/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-240t11/drivers/ide/ali14xx.c	Tue Jun 13 20:32:00 2000
+++ linux/drivers/ide/ali14xx.c	Tue Nov 21 14:35:59 2000
@@ -81,9 +81,9 @@
 	{0x2d, 0x32, 0x2e, 0x33},     /* drive 3 */
 };
 
-static int basePort = 0;	/* base port address */
-static int regPort = 0;		/* port for register number */
-static int dataPort = 0;	/* port for register data */
+static int basePort;	/* base port address */
+static int regPort;	/* port for register number */
+static int dataPort;	/* port for register data */
 static byte regOn;	/* output to base port to access registers */
 static byte regOff;	/* output to base port to close registers */
 
diff -uNr linux-240t11/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-240t11/drivers/ide/alim15x3.c	Wed Nov 15 22:02:55 2000
+++ linux/drivers/ide/alim15x3.c	Tue Nov 21 14:35:59 2000
@@ -233,8 +233,8 @@
 }
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-static byte m5229_revision	= 0;
-static byte chip_is_1543c_e	= 0;
+static byte m5229_revision;
+static byte chip_is_1543c_e;
 
 byte ali_proc = 0;
 static struct pci_dev *isa_dev;
diff -uNr linux-240t11/drivers/ide/buddha.c linux/drivers/ide/buddha.c
--- linux-240t11/drivers/ide/buddha.c	Wed Nov 15 22:02:11 2000
+++ linux/drivers/ide/buddha.c	Tue Nov 21 14:35:59 2000
@@ -87,7 +87,7 @@
      *  Board information
      */
 
-static u_long buddha_board = 0;
+static u_long buddha_board;
 static int buddha_num_hwifs = -1;
 
 
diff -uNr linux-240t11/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-240t11/drivers/ide/hpt366.c	Wed Nov 15 22:02:55 2000
+++ linux/drivers/ide/hpt366.c	Tue Nov 21 14:36:27 2000
@@ -214,8 +214,8 @@
 byte hpt366_proc = 0;
 
 extern char *ide_xfer_verbose (byte xfer_rate);
-byte hpt363_shared_irq = 0;
-byte hpt363_shared_pin = 0;
+byte hpt363_shared_irq;
+byte hpt363_shared_pin;
 
 static unsigned int pci_rev_check_hpt3xx (struct pci_dev *dev)
 {
diff -uNr linux-240t11/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-240t11/drivers/ide/ide-pci.c	Wed Nov 15 22:02:55 2000
+++ linux/drivers/ide/ide-pci.c	Tue Nov 21 14:35:59 2000
@@ -185,8 +185,8 @@
 #define INIT_HPT366	&ide_init_hpt366
 #define DMA_HPT366	&ide_dmacapable_hpt366
 #else
-static byte hpt363_shared_irq = 0;
-static byte hpt363_shared_pin = 0;
+static byte hpt363_shared_irq;
+static byte hpt363_shared_pin;
 #define PCI_HPT366	NULL
 #define ATA66_HPT366	NULL
 #define INIT_HPT366	NULL
diff -uNr linux-240t11/drivers/ide/osb4.c linux/drivers/ide/osb4.c
--- linux-240t11/drivers/ide/osb4.c	Wed Nov 15 22:02:12 2000
+++ linux/drivers/ide/osb4.c	Tue Nov 21 14:35:59 2000
@@ -60,7 +60,7 @@
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
-static byte osb4_revision = 0;
+static byte osb4_revision;
 static struct pci_dev *bmide_dev;
 
 static int osb4_get_info(char *, char **, off_t, int, int);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
