Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVGFEAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVGFEAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVGFD5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:57:41 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:13465 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262087AbVGFCTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:34 -0400
Subject: [PATCH] [44/48] Suspend2 2.1.9.8 for 2.6.12: 620-userui.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <1120616444451@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 621-swsusp-tidy.patch-old/kernel/power/swsusp.c 621-swsusp-tidy.patch-new/kernel/power/swsusp.c
--- 621-swsusp-tidy.patch-old/kernel/power/swsusp.c	2005-06-20 11:47:31.000000000 +1000
+++ 621-swsusp-tidy.patch-new/kernel/power/swsusp.c	2005-07-04 23:14:19.000000000 +1000
@@ -36,6 +36,8 @@
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
  */
 
+#define KERNEL_POWER_SWSUSP_C
+
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
@@ -51,9 +53,7 @@
 #include <linux/keyboard.h>
 #include <linux/spinlock.h>
 #include <linux/genhd.h>
-#include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>
@@ -71,9 +71,7 @@
 #include <asm/io.h>
 
 #include "power.h"
-
-/* References to section boundaries */
-extern const void __nosave_begin, __nosave_end;
+#include "suspend.h"
 
 /* Variables to be preserved over suspend */
 static int nr_copy_pages_check;

