Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTHWOHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 10:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTHWOHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 10:07:09 -0400
Received: from [203.145.184.221] ([203.145.184.221]:44811 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263507AbTHWOHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:07:03 -0400
Subject: [PATCH 2.6.0-test4][TRIVIAL][USB] digi_acceleport.c: typo fix
	spin_lock_irqrestore
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 19:59:20 +0530
Message-Id: <1061648960.2787.54.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.0-test4/drivers/usb/serial/digi_acceleport.c	2003-08-23 13:14:37.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/usb/serial/digi_acceleport.c	2003-08-23 19:35:29.000000000 +0530
@@ -218,7 +218,7 @@
 *    interrupt time.
 *  - digi_write_bulk_callback() and digi_read_bulk_callback() are
 *    called directly from interrupts.  Hence spin_lock_irqsave()
-*    and spin_lock_irqrestore() are used in the rest of the code
+*    and spin_unlock_irqrestore() are used in the rest of the code
 *    for any locks they acquire.
 *  - digi_write_bulk_callback() gets the port lock before waking up
 *    processes sleeping on the port write_wait.  It also schedules
@@ -571,7 +571,7 @@
 *
 *  Do spin_unlock_irqrestore and interruptible_sleep_on_timeout
 *  so that wake ups are not lost if they occur between the unlock
-*  and the sleep.  In other words, spin_lock_irqrestore and
+*  and the sleep.  In other words, spin_unlock_irqrestore and
 *  interruptible_sleep_on_timeout are "atomic" with respect to
 *  wake ups.  This is used to implement condition variables.
 */



