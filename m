Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTG1AAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTG1AAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272956AbTG0XCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:24 -0400
Date: Sun, 27 Jul 2003 21:05:06 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272005.h6RK567d029623@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: second block illegal/invalid fixups for isdn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/hysdn/hycapi.c linux-2.6.0-test2-ac1/drivers/isdn/hysdn/hycapi.c
--- linux-2.6.0-test2/drivers/isdn/hysdn/hycapi.c	2003-07-10 21:04:53.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/hysdn/hycapi.c	2003-07-15 18:01:29.000000000 +0100
@@ -591,7 +591,7 @@
 					       " current state\n", card->myid);
 					break;
 				case 0x2002:
-					printk(KERN_ERR "HYSDN Card%d: illegal PLCI\n", card->myid);
+					printk(KERN_ERR "HYSDN Card%d: invalid PLCI\n", card->myid);
 					break;		
 				case 0x2004:
 					printk(KERN_ERR "HYSDN Card%d: out of NCCI\n", card->myid);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/i4l/isdn_ppp.c linux-2.6.0-test2-ac1/drivers/isdn/i4l/isdn_ppp.c
--- linux-2.6.0-test2/drivers/isdn/i4l/isdn_ppp.c	2003-07-10 21:12:10.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/i4l/isdn_ppp.c	2003-07-15 18:01:29.000000000 +0100
@@ -715,7 +715,7 @@
  found:
 	unit = isdn_ppp_if_get_unit(idev->name);	/* get unit number from interface name .. ugly! */
 	if (unit < 0) {
-		printk(KERN_INFO "isdn_ppp_bind: illegal interface name %s.\n", idev->name);
+		printk(KERN_INFO "isdn_ppp_bind: invalid interface name %s.\n", idev->name);
 		retval = -ENODEV;
 		goto err;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/isdn/i4l/isdn_x25iface.c linux-2.6.0-test2-ac1/drivers/isdn/i4l/isdn_x25iface.c
--- linux-2.6.0-test2/drivers/isdn/i4l/isdn_x25iface.c	2003-07-10 21:08:07.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/isdn/i4l/isdn_x25iface.c	2003-07-15 18:01:29.000000000 +0100
@@ -63,7 +63,7 @@
 /* error message helper function */
 static void illegal_state_warn( unsigned state, unsigned char firstbyte) 
 {
-	printk( KERN_WARNING "isdn_x25iface: firstbyte %x illegal in"
+	printk( KERN_WARNING "isdn_x25iface: firstbyte %x invalid in"
 		"current state %d\n",firstbyte, state );
 }
 
@@ -72,7 +72,7 @@
 
 	if( pda  &&  pda -> magic == ISDN_X25IFACE_MAGIC ) return 0;
 	printk( KERN_WARNING
-		"isdn_x25iface_xxx: illegal pointer to proto data\n" );
+		"isdn_x25iface_xxx: invalid pointer to proto data\n" );
 	return 1;
 }
 
@@ -334,7 +334,7 @@
 		       " options not yet supported\n");
 		break;
 	default:
-		printk(KERN_WARNING "isdn_x25iface_xmit: frame with illegal"
+		printk(KERN_WARNING "isdn_x25iface_xmit: frame with invalid"
 		       " first byte %x ignored:\n", firstbyte);
 	}
 	dev_kfree_skb(skb);
