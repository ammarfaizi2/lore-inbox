Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317901AbSFSPJK>; Wed, 19 Jun 2002 11:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317904AbSFSPJJ>; Wed, 19 Jun 2002 11:09:09 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:28294 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317901AbSFSPJJ>; Wed, 19 Jun 2002 11:09:09 -0400
Date: Wed, 19 Jun 2002 17:08:57 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] include <linux/tqueue.h> in pcmcia drivers...
Message-ID: <20020619150857.GB16023@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pcmcia drivers haven't been updated to include the new
tqueue.h header when using tq_structs.

I noticed the breakage when compiling i82365.c for my laptop, and 
took the time to modify all the drivers in that directory.

Stelian.

===== drivers/pcmcia/hd64465_ss.c 1.4 vs edited =====
--- 1.4/drivers/pcmcia/hd64465_ss.c	Tue Feb  5 16:24:35 2002
+++ edited/drivers/pcmcia/hd64465_ss.c	Wed Jun 19 16:34:38 2002
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <asm/errno.h>
 #include <linux/irq.h>
+#include <linux/tqueue.h>
 
 #include <asm/io.h>
 #include <asm/hd64465.h>
===== drivers/pcmcia/i82092.c 1.4 vs edited =====
--- 1.4/drivers/pcmcia/i82092.c	Sat Mar 23 23:55:21 2002
+++ edited/drivers/pcmcia/i82092.c	Wed Jun 19 16:35:04 2002
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>
 
 #include <pcmcia/cs_types.h>
 #include <pcmcia/ss.h>
===== drivers/pcmcia/i82365.c 1.11 vs edited =====
--- 1.11/drivers/pcmcia/i82365.c	Tue Feb  5 16:23:06 2002
+++ edited/drivers/pcmcia/i82365.c	Wed Jun 19 16:33:03 2002
@@ -46,6 +46,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
===== drivers/pcmcia/tcic.c 1.6 vs edited =====
--- 1.6/drivers/pcmcia/tcic.c	Tue Feb  5 16:23:06 2002
+++ edited/drivers/pcmcia/tcic.c	Wed Jun 19 16:36:04 2002
@@ -49,6 +49,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
