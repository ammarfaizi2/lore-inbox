Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTEFDAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTEFC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:58:39 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:19585 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262297AbTEFC5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:12 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Include <linux/fs.h> in arch/v850/kernel/rte_cb_leds.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030924.60D903760@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:24 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to define `struct file'; apparently some include-file change
removed a previous implicit include.

diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/rte_cb_leds.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_cb_leds.c
--- linux-2.5.69-uc0/arch/v850/kernel/rte_cb_leds.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_cb_leds.c	2003-05-06 11:21:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/rte_cb_leds.c -- Midas lab RTE-CB board LED device support
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/fs.h>
 #include <linux/miscdevice.h>
 
 #include <asm/uaccess.h>
