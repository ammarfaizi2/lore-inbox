Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGYNfY>; Thu, 25 Jul 2002 09:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSGYNee>; Thu, 25 Jul 2002 09:34:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5629 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313477AbSGYNd0>; Thu, 25 Jul 2002 09:33:26 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251450.g6PEoNGc010497@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 Fix multiple driver build failures due to missing include
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:50:23 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/aironet4500_card.c linux-2.5.28-ac1/drivers/net/aironet4500_card.c
--- linux-2.5.28/drivers/net/aironet4500_card.c	Thu Jul 25 10:48:34 2002
+++ linux-2.5.28-ac1/drivers/net/aironet4500_card.c	Sun Jul 21 16:38:22 2002
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/aironet4500_core.c linux-2.5.28-ac1/drivers/net/aironet4500_core.c
--- linux-2.5.28/drivers/net/aironet4500_core.c	Thu Jul 25 10:48:27 2002
+++ linux-2.5.28-ac1/drivers/net/aironet4500_core.c	Sun Jul 21 16:37:52 2002
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/tqueue.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/aironet4500_proc.c linux-2.5.28-ac1/drivers/net/aironet4500_proc.c
--- linux-2.5.28/drivers/net/aironet4500_proc.c	Thu Jul 25 10:48:30 2002
+++ linux-2.5.28-ac1/drivers/net/aironet4500_proc.c	Sun Jul 21 16:38:50 2002
@@ -17,6 +17,7 @@
 #include <linux/version.h>
 
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
