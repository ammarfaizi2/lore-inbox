Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbVIZRfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbVIZRfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbVIZRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:35:03 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:38668 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751699AbVIZRfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:35:02 -0400
Date: Mon, 26 Sep 2005 19:35:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Typo fix: dot after newline in printk strings
Message-Id: <20050926193503.4b545023.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Andrew,

Typo fix: dots appearing after a newline in printk strings.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/char/ser_a2232.c                  |    2 +-
 drivers/i2c/busses/i2c-amd8111.c          |    2 +-
 drivers/i2c/busses/i2c-nforce2.c          |    2 +-
 drivers/message/i2o/debug.c               |    2 +-
 drivers/net/wireless/prism54/islpci_mgt.c |    2 +-
 drivers/pci/hotplug/ibmphp_core.c         |    2 +-
 drivers/usb/input/pid.c                   |    2 +-
 net/ipv4/netfilter/ipt_addrtype.c         |    2 +-
 sound/oss/awe_wave.c                      |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/char/ser_a2232.c	2004-12-24 22:34:29.000000000 +0100
+++ linux-2.6.14-rc2/drivers/char/ser_a2232.c	2005-09-26 19:31:40.000000000 +0200
@@ -790,7 +790,7 @@
 
 	}	
 
-	printk("Total: %d A2232 boards initialized.\n.", nr_a2232); /* Some status report if no card was found */
+	printk("Total: %d A2232 boards initialized.\n", nr_a2232); /* Some status report if no card was found */
 
 	a2232_init_portstructs();
 
--- linux-2.6.14-rc2.orig/drivers/i2c/busses/i2c-amd8111.c	2005-09-25 14:58:13.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/busses/i2c-amd8111.c	2005-09-26 19:31:40.000000000 +0200
@@ -257,7 +257,7 @@
 		case I2C_SMBUS_BLOCK_DATA_PEC:
 		case I2C_SMBUS_PROC_CALL_PEC:
 		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
+			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n", size);
 			return -1;
 
 		default:
--- linux-2.6.14-rc2.orig/drivers/i2c/busses/i2c-nforce2.c	2005-09-25 14:38:01.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/busses/i2c-nforce2.c	2005-09-26 19:31:40.000000000 +0200
@@ -192,7 +192,7 @@
 		case I2C_SMBUS_BLOCK_DATA_PEC:
 		case I2C_SMBUS_PROC_CALL_PEC:
 		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			dev_err(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
+			dev_err(&adap->dev, "Unexpected software PEC transaction %d\n", size);
 			return -1;
 
 		default:
--- linux-2.6.14-rc2.orig/drivers/message/i2o/debug.c	2005-08-29 20:35:12.000000000 +0200
+++ linux-2.6.14-rc2/drivers/message/i2o/debug.c	2005-09-26 19:31:40.000000000 +0200
@@ -90,7 +90,7 @@
 	};
 
 	if (req_status == I2O_FSC_TRANSPORT_UNKNOWN_FAILURE)
-		printk(KERN_DEBUG "TRANSPORT_UNKNOWN_FAILURE (%0#2x)\n.",
+		printk(KERN_DEBUG "TRANSPORT_UNKNOWN_FAILURE (%0#2x).\n",
 		       req_status);
 	else
 		printk(KERN_DEBUG "TRANSPORT_%s.\n",
--- linux-2.6.14-rc2.orig/drivers/net/wireless/prism54/islpci_mgt.c	2005-08-29 20:34:05.000000000 +0200
+++ linux-2.6.14-rc2/drivers/net/wireless/prism54/islpci_mgt.c	2005-09-26 19:31:41.000000000 +0200
@@ -137,7 +137,7 @@
 						       PCI_DMA_FROMDEVICE);
 			if (!buf->pci_addr) {
 				printk(KERN_WARNING
-				       "Failed to make memory DMA'able\n.");
+				       "Failed to make memory DMA'able.\n");
 				return -ENOMEM;
 			}
 		}
--- linux-2.6.14-rc2.orig/drivers/pci/hotplug/ibmphp_core.c	2005-08-29 20:32:41.000000000 +0200
+++ linux-2.6.14-rc2/drivers/pci/hotplug/ibmphp_core.c	2005-09-26 19:31:41.000000000 +0200
@@ -1077,7 +1077,7 @@
 	if (rc) {
 		err("Adding this card exceeds the limitations of this bus.\n");
 		err("(i.e., >1 133MHz cards running on same bus, or "
-		     ">2 66 PCI cards running on same bus\n.");
+		     ">2 66 PCI cards running on same bus.\n");
 		err("Try hot-adding into another bus\n");
 		rc = -EINVAL;
 		goto error_nopower;
--- linux-2.6.14-rc2.orig/drivers/usb/input/pid.c	2005-09-13 21:21:14.000000000 +0200
+++ linux-2.6.14-rc2/drivers/usb/input/pid.c	2005-09-26 19:31:41.000000000 +0200
@@ -198,7 +198,7 @@
 		}
 
 		effect->id = id;
-		dev_dbg(&pid_private->hid->dev->dev, "effect ID is %d\n.", id);
+		dev_dbg(&pid_private->hid->dev->dev, "effect ID is %d.\n", id);
 		pid_private->effects[id].owner = current->pid;
 		pid_private->effects[id].flags = (1 << FF_PID_FLAGS_USED);
 		spin_unlock_irqrestore(&pid_private->lock, flags);
--- linux-2.6.14-rc2.orig/net/ipv4/netfilter/ipt_addrtype.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.14-rc2/net/ipv4/netfilter/ipt_addrtype.c	2005-09-26 19:31:41.000000000 +0200
@@ -48,7 +48,7 @@
 		      unsigned int hook_mask)
 {
 	if (matchsize != IPT_ALIGN(sizeof(struct ipt_addrtype_info))) {
-		printk(KERN_ERR "ipt_addrtype: invalid size (%u != %Zu)\n.",
+		printk(KERN_ERR "ipt_addrtype: invalid size (%u != %Zu)\n",
 		       matchsize, IPT_ALIGN(sizeof(struct ipt_addrtype_info)));
 		return 0;
 	}
--- linux-2.6.14-rc2.orig/sound/oss/awe_wave.c	2005-08-29 20:33:25.000000000 +0200
+++ linux-2.6.14-rc2/sound/oss/awe_wave.c	2005-09-26 19:31:41.000000000 +0200
@@ -6062,7 +6062,7 @@
 	io1 = pnp_port_start(dev,0);
 	io2 = pnp_port_start(dev,1);
 	io3 = pnp_port_start(dev,2);
-	printk(KERN_INFO "AWE32: A PnP Wave Table was detected at IO's %#x,%#x,%#x\n.",
+	printk(KERN_INFO "AWE32: A PnP Wave Table was detected at IO's %#x,%#x,%#x.\n",
 	       io1, io2, io3);
 	setup_ports(io1, io2, io3);
 

-- 
Jean Delvare
