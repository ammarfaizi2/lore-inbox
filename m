Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbUKCWya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUKCWya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUKCWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:51:25 -0500
Received: from [203.2.177.22] ([203.2.177.22]:32006 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261952AbUKCWsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:48:14 -0500
Subject: [PATCH] 2.6 X.25: Remove unused header files.
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099521943.3060.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 04 Nov 2004 09:45:43 +1100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2004 22:48:01.0102 (UTC) FILETIME=[2BE976E0:01C4C1F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unused header files from X.25

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>


diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/af_x25.c linux-2.6.8.1/net/x25/af_x25.c
--- linux-2.6.8.1-vanilla/net/x25/af_x25.c	2004-08-14 20:56:22.000000000 +1000
+++ linux-2.6.8.1/net/x25/af_x25.c	2004-10-29 11:05:12.794679312 +1000
@@ -34,28 +34,19 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/sockios.h>
 #include <linux/net.h>
-#include <linux/stat.h>
-#include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/tcp.h>
-#include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/fcntl.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <net/x25.h>
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/sysctl_net_x25.c linux-2.6.8.1/net/x25/sysctl_net_x25.c
--- linux-2.6.8.1-vanilla/net/x25/sysctl_net_x25.c	2004-08-14 20:55:32.000000000 +1000
+++ linux-2.6.8.1/net/x25/sysctl_net_x25.c	2004-10-29 10:28:27.051003320 +1000
@@ -5,7 +5,6 @@
  * Added /proc/sys/net/x25 directory entry (empty =) ). [MS]
  */
 
-#include <linux/mm.h>
 #include <linux/sysctl.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_dev.c linux-2.6.8.1/net/x25/x25_dev.c
--- linux-2.6.8.1-vanilla/net/x25/x25_dev.c	2004-08-14 20:55:24.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_dev.c	2004-10-29 10:23:05.201931816 +1000
@@ -18,29 +18,10 @@
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/stat.h>
-#include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <linux/fcntl.h>
-#include <linux/termios.h>	/* For TIOCINQ/OUTQ */
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/notifier.h>
-#include <linux/proc_fs.h>
 #include <linux/if_arp.h>
 #include <net/x25.h>
 
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_facilities.c linux-2.6.8.1/net/x25/x25_facilities.c
--- linux-2.6.8.1-vanilla/net/x25/x25_facilities.c	2004-08-14 20:55:33.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_facilities.c	2004-10-29 10:13:09.996416808 +1000
@@ -19,24 +19,10 @@
  *					  negotiation.
  */
 
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/system.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <net/x25.h>
 
 /*
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_in.c linux-2.6.8.1/net/x25/x25_in.c
--- linux-2.6.8.1-vanilla/net/x25/x25_in.c	2004-08-14 20:56:23.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_in.c	2004-10-29 09:50:11.513977992 +1000
@@ -24,25 +24,11 @@
  */
 
 #include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <net/ip.h>			/* For ip_rcv */
 #include <net/tcp.h>
-#include <asm/system.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <net/x25.h>
 
 static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_link.c linux-2.6.8.1/net/x25/x25_link.c
--- linux-2.6.8.1-vanilla/net/x25/x25_link.c	2004-08-14 20:54:48.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_link.c	2004-10-29 12:07:59.326079504 +1000
@@ -21,25 +21,12 @@
  *	2000-09-04	Henner Eisen	  dev_hold() / dev_put() for x25_neigh.
  */
 
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <net/sock.h>
-#include <asm/system.h>
 #include <asm/uaccess.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <linux/init.h>
 #include <net/x25.h>
 
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_out.c linux-2.6.8.1/net/x25/x25_out.c
--- linux-2.6.8.1-vanilla/net/x25/x25_out.c	2004-08-14 20:54:49.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_out.c	2004-10-29 12:10:00.113716992 +1000
@@ -22,24 +22,11 @@
  *					needed cleaned seq-number fields.
  */
 
-#include <linux/errno.h>
-#include <linux/types.h>
 #include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <asm/system.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <net/x25.h>
 
 static int x25_pacsize_to_bytes(unsigned int pacsize)
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_subr.c linux-2.6.8.1/net/x25/x25_subr.c
--- linux-2.6.8.1-vanilla/net/x25/x25_subr.c	2004-08-14 20:54:52.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_subr.c	2004-10-29 12:26:28.652436264 +1000
@@ -21,25 +21,11 @@
  *	jun/24/01	Arnaldo C. Melo	  use skb_queue_purge, cleanups
  */
 
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/tcp.h>
-#include <asm/system.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <net/x25.h>
 
 /*
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_timer.c linux-2.6.8.1/net/x25/x25_timer.c
--- linux-2.6.8.1-vanilla/net/x25/x25_timer.c	2004-08-14 20:54:48.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_timer.c	2004-10-29 12:27:28.340362320 +1000
@@ -20,24 +20,10 @@
  */
 
 #include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/tcp.h>
-#include <asm/system.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
 #include <net/x25.h>
 
 static void x25_heartbeat_expiry(unsigned long);


