Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUDIHGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 03:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUDIHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 03:06:41 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41231 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261723AbUDIHGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 03:06:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: torvalds@osdl.org
Subject: [PATCH] trivial 'missing \n' printk fix
Date: Fri, 9 Apr 2004 10:06:31 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VE6WYL99GIPFKQ8LGST1"
Message-Id: <200404091006.31475.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VE6WYL99GIPFKQ8LGST1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

--=20
vda
--------------Boundary-00=_VE6WYL99GIPFKQ8LGST1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="printk_eol.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="printk_eol.patch"

--- linux-2.6.5/arch/i386/kernel/timers/timer_tsc.c.orig	Sun Apr  4 06:37:36 2004
+++ linux-2.6.5/arch/i386/kernel/timers/timer_tsc.c	Fri Apr  9 10:02:03 2004
@@ -232,11 +232,11 @@
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
 			printk(KERN_WARNING "Losing too many ticks!\n");
-			printk(KERN_WARNING "TSC cannot be used as a timesource.  ");
+			printk(KERN_WARNING "TSC cannot be used as a timesource.\n");
 			printk(KERN_WARNING "Possible reasons for this are:\n");
-			printk(KERN_WARNING "  You're running with Speedstep,\n");
-			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
-			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
+			printk(KERN_WARNING "  you're running with Speedstep,\n");
+			printk(KERN_WARNING "  you don't have DMA enabled for your hard disk (see hdparm),\n");
+			printk(KERN_WARNING "  incorrect TSC synchronization on an SMP system (see dmesg).\n");
 			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
 
 			clock_fallback();

--------------Boundary-00=_VE6WYL99GIPFKQ8LGST1--

