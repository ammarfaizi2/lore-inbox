Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273023AbTG0XFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273021AbTG0XEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:04:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272908AbTG0XBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:20 -0400
Date: Sun, 27 Jul 2003 21:31:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272031.h6RKVGSC029872@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: remaining illegal/invalid/separate stuff for scsi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/BusLogic.c linux-2.6.0-test2-ac1/drivers/scsi/BusLogic.c
--- linux-2.6.0-test2/drivers/scsi/BusLogic.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/BusLogic.c	2003-07-27 20:24:26.000000000 +0100
@@ -840,7 +840,7 @@
 	}
       if (IRQ_Channel == 0)
 	{
-	  BusLogic_Error("BusLogic: IRQ Channel %d illegal for "
+	  BusLogic_Error("BusLogic: IRQ Channel %d invalid for "
 			 "MultiMaster Host Adapter\n", NULL, IRQ_Channel);
 	  BusLogic_Error("at PCI Bus %d Device %d I/O Address 0x%X\n",
 			 NULL, Bus, Device, IO_Address);
@@ -1112,7 +1112,7 @@
 	}
       if (IRQ_Channel == 0)
 	{
-	  BusLogic_Error("BusLogic: IRQ Channel %d illegal for "
+	  BusLogic_Error("BusLogic: IRQ Channel %d invalid for "
 			 "FlashPoint Host Adapter\n", NULL, IRQ_Channel);
 	  BusLogic_Error("at PCI Bus %d Device %d I/O Address 0x%X\n",
 			 NULL, Bus, Device, IO_Address);
@@ -4847,7 +4847,7 @@
 		  break;
 		default:
 		  BusLogic_Error("BusLogic: Invalid Driver Options "
-				 "(illegal I/O Address 0x%X)\n",
+				 "(invalid I/O Address 0x%X)\n",
 				 NULL, IO_Address);
 		  return 0;
 		}
@@ -4877,7 +4877,7 @@
 		  if (QueueDepth > BusLogic_MaxTaggedQueueDepth)
 		    {
 		      BusLogic_Error("BusLogic: Invalid Driver Options "
-				     "(illegal Queue Depth %d)\n",
+				     "(invalid Queue Depth %d)\n",
 				     NULL, QueueDepth);
 		      return 0;
 		    }
@@ -4911,7 +4911,7 @@
 	      if (QueueDepth == 0 || QueueDepth > BusLogic_MaxTaggedQueueDepth)
 		{
 		  BusLogic_Error("BusLogic: Invalid Driver Options "
-				 "(illegal Queue Depth %d)\n",
+				 "(invalid Queue Depth %d)\n",
 				 NULL, QueueDepth);
 		  return 0;
 		}
@@ -5029,7 +5029,7 @@
 	      if (BusSettleTime > 5 * 60)
 		{
 		  BusLogic_Error("BusLogic: Invalid Driver Options "
-				 "(illegal Bus Settle Time %d)\n",
+				 "(invalid Bus Settle Time %d)\n",
 				 NULL, BusSettleTime);
 		  return 0;
 		}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/esp.c linux-2.6.0-test2-ac1/drivers/scsi/esp.c
--- linux-2.6.0-test2/drivers/scsi/esp.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/esp.c	2003-07-27 20:25:16.000000000 +0100
@@ -4256,7 +4256,7 @@
 		 * for reselection.  See esp100_reconnect_hwbug()
 		 * to see how we try very hard to avoid this.
 		 */
-		ESPLOG(("esp%d: illegal command\n", esp->esp_id));
+		ESPLOG(("esp%d: invalid command\n", esp->esp_id));
 
 		esp_dump_state(esp);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/gdth.c linux-2.6.0-test2-ac1/drivers/scsi/gdth.c
--- linux-2.6.0-test2/drivers/scsi/gdth.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/gdth.c	2003-07-27 20:25:16.000000000 +0100
@@ -3838,9 +3838,9 @@
 /*31*/  "\007\000\002\012\001\013\001"
         "GDT HA %u, Fault bus %u, ID %u: old disk detected",
 /*32*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: plugging an active disk is illegal",
+        "GDT HA %u, Fault bus %u, ID %u: plugging an active disk is invalid",
 /*33*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: illegal device detected",
+        "GDT HA %u, Fault bus %u, ID %u: invalid device detected",
 /*34*/  "\011\000\002\012\001\013\001\006\004"
         "GDT HA %u, Fault bus %u, ID %u: insufficient disk capacity (%lu MB required)",
 /*35*/  "\007\000\002\012\001\013\001"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/mac53c94.c linux-2.6.0-test2-ac1/drivers/scsi/mac53c94.c
--- linux-2.6.0-test2/drivers/scsi/mac53c94.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/mac53c94.c	2003-07-27 20:26:20.000000000 +0100
@@ -361,7 +361,7 @@
 		return;
 	}
 	if (intr & INTR_ILL_CMD) {
-		printk(KERN_ERR "53c94: illegal cmd, intr=%x stat=%x seq=%x phase=%d\n",
+		printk(KERN_ERR "53c94: invalid cmd, intr=%x stat=%x seq=%x phase=%d\n",
 		       intr, stat, seq, state->phase);
 		cmd_done(state, DID_ERROR << 16);
 		return;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/ncr53c8xx.c linux-2.6.0-test2-ac1/drivers/scsi/ncr53c8xx.c
--- linux-2.6.0-test2/drivers/scsi/ncr53c8xx.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/ncr53c8xx.c	2003-07-27 20:26:20.000000000 +0100
@@ -5166,7 +5166,7 @@
 			printk ("extraneous data discarded.\n");
 			break;
 		case XE_BAD_PHASE:
-			printk ("illegal scsi phase (4/5).\n");
+			printk ("invalid scsi phase (4/5).\n");
 			break;
 		default:
 			printk ("extended error %d.\n", cp->xerr_status);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/NCR53C9x.c linux-2.6.0-test2-ac1/drivers/scsi/NCR53C9x.c
--- linux-2.6.0-test2/drivers/scsi/NCR53C9x.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/NCR53C9x.c	2003-07-27 20:24:27.000000000 +0100
@@ -3470,7 +3470,7 @@
 		 * for reselection.  See esp100_reconnect_hwbug()
 		 * to see how we try very hard to avoid this.
 		 */
-		ESPLOG(("esp%d: illegal command\n", esp->esp_id));
+		ESPLOG(("esp%d: invalid command\n", esp->esp_id));
 
 		esp_dump_state(esp, eregs);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/script_asm.pl linux-2.6.0-test2-ac1/drivers/scsi/script_asm.pl
--- linux-2.6.0-test2/drivers/scsi/script_asm.pl	2003-07-10 21:14:50.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/script_asm.pl	2003-07-15 18:01:30.000000000 +0100
@@ -813,7 +813,7 @@
 	$address = $2;
 	$length = $3;
 	die 
-"$0 : $symbol $i has illegal relative reference at address $address,
+"$0 : $symbol $i has invalid relative reference at address $address,
     size $length\n"
 	if ($type eq 'REL');
 	    
@@ -831,12 +831,12 @@
 	    $length = $3;
 	    
 	    die 
-"$0 : symbol $label is external, has illegal relative reference at $address, 
+"$0 : symbol $label is external, has invalid relative reference at $address,
     size $length\n"
 		if ($type eq 'REL');
 
 	    die 
-"$0 : symbol $label has illegal reference at $address, size $length\n"
+"$0 : symbol $label has invalid reference at $address, size $length\n"
 		if ((($address % 4) !=0) || ($length != 4));
 
 	    $symbol = $symbol_values{$external};
@@ -862,7 +862,7 @@
 	    $length = $3;
 
 	    if ((($address % 4) !=0) || ($length != 4)) {
-		die "$0 : symbol $label has illegal reference at $1, size $2\n";
+		die "$0 : symbol $label has invalid reference at $1, size $2\n";
 	    }
 
 	    if ($type eq 'ABS') {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/st.c linux-2.6.0-test2-ac1/drivers/scsi/st.c
--- linux-2.6.0-test2/drivers/scsi/st.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/st.c	2003-07-27 20:27:22.000000000 +0100
@@ -3659,7 +3659,7 @@
 				}
 			}
 			if (i >= sizeof(parms) / sizeof(struct st_dev_parm))
-				 printk(KERN_WARNING "st: illegal parameter in '%s'\n",
+				 printk(KERN_WARNING "st: invalid parameter in '%s'\n",
 					stp);
 			stp = strchr(stp, ',');
 			if (stp)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/tmscsim.c linux-2.6.0-test2-ac1/drivers/scsi/tmscsim.c
--- linux-2.6.0-test2/drivers/scsi/tmscsim.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/tmscsim.c	2003-07-27 20:28:19.000000000 +0100
@@ -2815,7 +2815,7 @@
    return (length);
 
  einv_dev:
-   printk (KERN_WARNING "DC390: Ignore cmnd to illegal Dev(Idx) %i. Valid range: 0 - %i.\n", 
+   printk (KERN_WARNING "DC390: Ignore cmnd to invalid Dev(Idx) %i. Valid range: 0 - %i.\n", 
 	   dev, pACB->DCBCnt - 1);
    DC390_UNLOCK_ACB;
    DC390_UNLOCK_IO(pACB.pScsiHost);
