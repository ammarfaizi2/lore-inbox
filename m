Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTDVT2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTDVT12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:27:28 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:65152 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263387AbTDVT1E (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:27:04 -0400
Message-Id: <200304221939.h3MJd9Lq004956@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 #if cleanup net/* (6/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:39:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the net/* subtree

--- linux-2.5.68-bk3/net/core/dev.c.dist	2003-04-22 13:57:17.000000000 -0400
+++ linux-2.5.68-bk3/net/core/dev.c	2003-04-22 14:48:28.133679979 -0400
@@ -1365,7 +1365,7 @@
 	if (skb_is_nonlinear(skb) && skb_linearize(skb, GFP_ATOMIC))
 		goto out_kfree;
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	/* Old protocols did not depened on BHs different of NET_BH and
 	   TIMER_BH - they need to be fixed for the new assumptions.
 	 */
--- linux-2.5.68-bk3/net/irda/irlap.c.dist	2003-04-07 13:32:50.000000000 -0400
+++ linux-2.5.68-bk3/net/irda/irlap.c	2003-04-22 14:49:16.615699947 -0400
@@ -1117,7 +1117,7 @@
 		len += sprintf(buf+len, "  win size: %d, ",
 			       self->window_size);
 		len += sprintf(buf+len, "win: %d, ", self->window);
-#if CONFIG_IRDA_DYNAMIC_WINDOW
+#ifdef CONFIG_IRDA_DYNAMIC_WINDOW
 		len += sprintf(buf+len, "line capacity: %d, ",
 			       self->line_capacity);
 		len += sprintf(buf+len, "bytes left: %d\n", self->bytes_left);
--- linux-2.5.68-bk3/net/irda/irlap_event.c.dist	2003-04-22 13:57:17.000000000 -0400
+++ linux-2.5.68-bk3/net/irda/irlap_event.c	2003-04-22 14:48:58.325346802 -0400
@@ -43,7 +43,7 @@
 
 #include <net/irda/irda_device.h>
 
-#if CONFIG_IRDA_FAST_RR
+#ifdef CONFIG_IRDA_FAST_RR
 int sysctl_fast_poll_increase = 50;
 #endif
 
--- linux-2.5.68-bk3/net/sctp/socket.c.dist	2003-04-07 13:33:03.000000000 -0400
+++ linux-2.5.68-bk3/net/sctp/socket.c	2003-04-22 14:49:44.559065634 -0400
@@ -446,7 +446,7 @@
 	 * 							--daisy
 	 */
 
-#if CONFIG_IP_SCTP_ADDIP
+#ifdef CONFIG_IP_SCTP_ADDIP
 	/* Add these addresses to all associations on this endpoint.  */
 	if (retval >= 0) {
 		struct list_head *pos;
@@ -566,7 +566,7 @@
 	 * ADDIP code.
 	 * 							--daisy
 	 */
-#if CONFIG_IP_SCTP_ADDIP
+#ifdef CONFIG_IP_SCTP_ADDIP
 	/* Remove these addresses from all associations on this endpoint.  */
 	if (retval >= 0) {
 		struct list_head *pos;


