Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273021AbTG0XFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273022AbTG0XDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:03:35 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272899AbTG0XBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:16 -0400
Date: Sun, 27 Jul 2003 21:10:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272010.h6RKAShh029654@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more net illegal/invalid typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/skfp/h/cmtdef.h linux-2.6.0-test2-ac1/drivers/net/skfp/h/cmtdef.h
--- linux-2.6.0-test2/drivers/net/skfp/h/cmtdef.h	2003-07-10 21:06:10.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/skfp/h/cmtdef.h	2003-07-15 18:01:29.000000000 +0100
@@ -721,21 +721,21 @@
 #endif
 
 #define	SMT_E0100	SMT_EBASE + 0
-#define	SMT_E0100_MSG	"cfm FSM: illegal ce_type"
+#define	SMT_E0100_MSG	"cfm FSM: invalid ce_type"
 #define	SMT_E0101	SMT_EBASE + 1
 #define	SMT_E0101_MSG	"CEM: case ???"
 #define	SMT_E0102	SMT_EBASE + 2
-#define	SMT_E0102_MSG	"CEM A: illegal state"
+#define	SMT_E0102_MSG	"CEM A: invalid state"
 #define	SMT_E0103	SMT_EBASE + 3
-#define	SMT_E0103_MSG	"CEM B: illegal state"
+#define	SMT_E0103_MSG	"CEM B: invalid state"
 #define	SMT_E0104	SMT_EBASE + 4
-#define	SMT_E0104_MSG	"CEM M: illegal state"
+#define	SMT_E0104_MSG	"CEM M: invalid state"
 #define	SMT_E0105	SMT_EBASE + 5
-#define	SMT_E0105_MSG	"CEM S: illegal state"
+#define	SMT_E0105_MSG	"CEM S: invalid state"
 #define	SMT_E0106	SMT_EBASE + 6
-#define	SMT_E0106_MSG	"CFM : illegal state"
+#define	SMT_E0106_MSG	"CFM : invalid state"
 #define	SMT_E0107	SMT_EBASE + 7
-#define	SMT_E0107_MSG	"ECM : illegal state"
+#define	SMT_E0107_MSG	"ECM : invalid state"
 #define	SMT_E0108	SMT_EBASE + 8
 #define	SMT_E0108_MSG	"prop_actions : NAC in DAS CFM"
 #define	SMT_E0109	SMT_EBASE + 9
@@ -757,21 +757,21 @@
 #define	SMT_E0117	SMT_EBASE + 17
 #define	SMT_E0117_MSG	"E_SMT_001: RxD count for receive queue 1 = 0"
 #define	SMT_E0118	SMT_EBASE + 18
-#define	SMT_E0118_MSG	"PCM : illegal state"
+#define	SMT_E0118_MSG	"PCM : invalid state"
 #define	SMT_E0119	SMT_EBASE + 19
 #define	SMT_E0119_MSG	"smt_add_para"
 #define	SMT_E0120	SMT_EBASE + 20
 #define	SMT_E0120_MSG	"smt_set_para"
 #define	SMT_E0121	SMT_EBASE + 21
-#define	SMT_E0121_MSG	"illegal event in dispatcher"
+#define	SMT_E0121_MSG	"invalid event in dispatcher"
 #define	SMT_E0122	SMT_EBASE + 22
-#define	SMT_E0122_MSG	"RMT : illegal state"
+#define	SMT_E0122_MSG	"RMT : invalid state"
 #define	SMT_E0123	SMT_EBASE + 23
-#define	SMT_E0123_MSG	"SBA: state machine has illegal state"
+#define	SMT_E0123_MSG	"SBA: state machine has invalid state"
 #define	SMT_E0124	SMT_EBASE + 24
 #define	SMT_E0124_MSG	"sba_free_session() called with NULL pointer"
 #define	SMT_E0125	SMT_EBASE + 25
-#define	SMT_E0125_MSG	"SBA : illegal session pointer"
+#define	SMT_E0125_MSG	"SBA : invalid session pointer"
 #define	SMT_E0126	SMT_EBASE + 26
 #define	SMT_E0126_MSG	"smt_free_mbuf() called with NULL pointer\n"
 #define	SMT_E0127	SMT_EBASE + 27
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/skfp/smt.c linux-2.6.0-test2-ac1/drivers/net/skfp/smt.c
--- linux-2.6.0-test2/drivers/net/skfp/smt.c	2003-07-10 21:12:59.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/skfp/smt.c	2003-07-15 18:01:29.000000000 +0100
@@ -817,7 +817,7 @@
 #endif
 	}
 	if (illegal) {
-		DB_SMT("SMT: discarding illegal frame, reason = %d\n",
+		DB_SMT("SMT: discarding invalid frame, reason = %d\n",
 			illegal,0) ;
 	}
 	smt_free_mbuf(smc,mb) ;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/tokenring/3c359.c linux-2.6.0-test2-ac1/drivers/net/tokenring/3c359.c
--- linux-2.6.0-test2/drivers/net/tokenring/3c359.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/tokenring/3c359.c	2003-07-15 18:01:29.000000000 +0100
@@ -1123,7 +1123,7 @@
 				if (macstatus & (1<<3))
 					printk(KERN_WARNING "eint error: Internal watchdog timer expired \n") ;
 				if (macstatus & (1<<2))
-					printk(KERN_WARNING "aint error: Host tried to perform illegal operation \n") ; 
+					printk(KERN_WARNING "aint error: Host tried to perform invalid operation \n") ; 
 				printk(KERN_WARNING "Instatus = %02x, macstatus = %02x\n",intstatus,macstatus) ; 
 				printk(KERN_WARNING "%s: Resetting hardware: \n", dev->name); 
 				netif_stop_queue(dev) ;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/wan/cycx_drv.c linux-2.6.0-test2-ac1/drivers/net/wan/cycx_drv.c
--- linux-2.6.0-test2/drivers/net/wan/cycx_drv.c	2003-07-10 21:10:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/wan/cycx_drv.c	2003-07-15 18:01:29.000000000 +0100
@@ -142,7 +142,7 @@
 
 	/* Verify IRQ configuration options */
 	if (!get_option_index(cycx_2x_irq_options, hw->irq)) {
-		printk(KERN_ERR "%s: IRQ %d is illegal!\n", modname, hw->irq);
+		printk(KERN_ERR "%s: IRQ %d is invalid!\n", modname, hw->irq);
 		return -EINVAL;
 	}
 
@@ -152,7 +152,7 @@
 				modname);
  		return -EINVAL;
 	} else if (!get_option_index(cyc2x_dpmbase_options, hw->dpmbase)) {
-		printk(KERN_ERR "%s: memory address 0x%lX is illegal!\n",
+		printk(KERN_ERR "%s: memory address 0x%lX is invalid!\n",
 				modname, dpmbase);
 		return -EINVAL;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/wan/sdladrv.c linux-2.6.0-test2-ac1/drivers/net/wan/sdladrv.c
--- linux-2.6.0-test2/drivers/net/wan/sdladrv.c	2003-07-27 19:56:24.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/wan/sdladrv.c	2003-07-27 20:19:51.000000000 +0100
@@ -428,7 +428,7 @@
 
                 /* Verify IRQ configuration options */
                 if (!get_option_index(irq_opt, hw->irq)) {
-                        printk(KERN_INFO "%s: IRQ %d is illegal!\n",
+                        printk(KERN_INFO "%s: IRQ %d is invalid!\n",
                         	modname, hw->irq);
                       return -EINVAL;
                 } 
@@ -438,7 +438,7 @@
                         hw->pclk = pclk_opt[1];  /* use default */
         
                 else if (!get_option_index(pclk_opt, hw->pclk)) {
-                        printk(KERN_INFO "%s: CPU clock %u is illegal!\n",
+                        printk(KERN_INFO "%s: CPU clock %u is invalid!\n",
 				modname, hw->pclk);
                         return -EINVAL;
                 } 
@@ -458,7 +458,7 @@
                 else if (!get_option_index(dpmbase_opt,
 			virt_to_phys(hw->dpmbase))) {
                         printk(KERN_INFO
-				"%s: memory address 0x%lX is illegal!\n",
+				"%s: memory address 0x%lX is invalid!\n",
 				modname, virt_to_phys(hw->dpmbase));
                         return -EINVAL;
                 }               
