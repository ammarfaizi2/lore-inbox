Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSLFNK4>; Fri, 6 Dec 2002 08:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSLFNK4>; Fri, 6 Dec 2002 08:10:56 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:32772 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S262506AbSLFNKy>;
	Fri, 6 Dec 2002 08:10:54 -0500
Message-Id: <5.2.0.9.0.20021206141312.00a20b70@mail.science.uva.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 06 Dec 2002 14:15:55 +0100
To: linux-kernel@vger.kernel.org
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: [PATCH] kill warning
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following patch is needed to kill this warning:
   CC      drivers/char/sysrq.o
In file included from drivers/char/sysrq.c:30:
include/linux/suspend.h:76: warning: static declaration for 
`software_suspend' follows non-static

	Rudmer

# diff -u linux-2.5.50-bk5/drivers/char/sysrq.c.orig 
linux-2.5.50-bk5/drivers/char/sysrq.c
--- linux-2.5.50-bk5/drivers/char/sysrq.c.orig  2002-12-06 
14:11:50.000000000 +0100
+++ linux-2.5.50-bk5/drivers/char/sysrq.c       2002-12-06 
14:09:00.000000000 +0100
@@ -21,13 +21,13 @@
  #include <linux/mount.h>
  #include <linux/kdev_t.h>
  #include <linux/major.h>
+#include <linux/suspend.h>
  #include <linux/reboot.h>
  #include <linux/sysrq.h>
  #include <linux/kbd_kern.h>
  #include <linux/quotaops.h>
  #include <linux/smp_lock.h>
  #include <linux/module.h>
-#include <linux/suspend.h>
  #include <linux/writeback.h>
  #include <linux/buffer_head.h>         /* for fsync_bdev() */

