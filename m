Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTB0VdL>; Thu, 27 Feb 2003 16:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTB0VdL>; Thu, 27 Feb 2003 16:33:11 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:54790 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267039AbTB0Vb5>; Thu, 27 Feb 2003 16:31:57 -0500
Date: Thu, 27 Feb 2003 15:40:27 -0600
From: Art Haas <ahaas@airmail.net>
To: Corey Minyard <minyard@mvista.com>, source@mvista.com,
       linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for ipmi_devintf.c
Message-ID: <20030227214027.GC8116@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers. It is against the
current BK.

Art Haas

===== drivers/char/ipmi/ipmi_devintf.c 1.1 vs edited =====
--- 1.1/drivers/char/ipmi/ipmi_devintf.c	Tue Nov 26 16:06:25 2002
+++ edited/drivers/char/ipmi/ipmi_devintf.c	Thu Feb 27 10:26:14 2003
@@ -105,7 +105,7 @@
 
 static struct ipmi_user_hndl ipmi_hndlrs =
 {
-	ipmi_recv_hndl : file_receive_handler
+	.ipmi_recv_hndl	= file_receive_handler,
 };
 
 static int ipmi_open(struct inode *inode, struct file *file)
@@ -424,12 +424,12 @@
 
 
 static struct file_operations ipmi_fops = {
-	owner:   THIS_MODULE,
-	ioctl:   ipmi_ioctl,
-	open:    ipmi_open,
-	release: ipmi_release,
-	fasync:  ipmi_fasync,
-	poll:    ipmi_poll
+	.owner		= THIS_MODULE,
+	.ioctl		= ipmi_ioctl,
+	.open		= ipmi_open,
+	.release	= ipmi_release,
+	.fasync		= ipmi_fasync,
+	.poll		= ipmi_poll,
 };
 
 #define DEVICE_NAME     "ipmidev"
@@ -468,8 +468,8 @@
 
 static struct ipmi_smi_watcher smi_watcher =
 {
-	new_smi  : ipmi_new_smi,
-	smi_gone : ipmi_smi_gone
+	.new_smi	= ipmi_new_smi,
+	.smi_gone	= ipmi_smi_gone,
 };
 
 static __init int init_ipmi_devintf(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
