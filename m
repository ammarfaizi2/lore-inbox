Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWFVSBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWFVSBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWFVSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:01:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:55532 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750921AbWFVSBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:01:43 -0400
Date: Thu, 22 Jun 2006 20:01:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: axboe@suse.de
cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] blkdev.h/elevator.h
Message-ID: <Pine.LNX.4.61.0606222000000.31855@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens, hello Andrew,


given the issue with blkdev.h and elevator.h, I cooked up this one. Is that 
acceptable?

diff --fast -Ndpru linux-2.6.17~/include/linux/elevator.h linux-2.6.17+/include/linux/elevator.h
--- linux-2.6.17~/include/linux/elevator.h	2006-06-18 22:51:43.000000000 +0200
+++ linux-2.6.17+/include/linux/elevator.h	2006-06-22 17:07:20.519988000 +0200
@@ -1,6 +1,10 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
+#ifndef _LINUX_BLKDEV_H
+#    warning "Never use <linux/elevator.h> directly; include <linux/blkdev.h> instead."
+#endif
+
 typedef int (elevator_merge_fn) (request_queue_t *, struct request **,
 				 struct bio *);
 
#<<eof>>


Jan Engelhardt
-- 
