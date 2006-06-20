Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWFTJcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWFTJcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFTJcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:32:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46751 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965225AbWFTJcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:32:10 -0400
Date: Tue, 20 Jun 2006 11:31:54 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Standalone inclusion elevator.h
In-Reply-To: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0606201130200.2481@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Patch:
Make it possible to include elevator.h standalone (e.g. as the first file 
of a row of #includes).

(cdemu for example only requires elv_requeue_request and therefore only
needs elevtor.h.)

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

# AS_59-standalone-linux_elevator_h.diff
diff --fast -dpru linux-2.6.17~/include/linux/elevator.h linux-2.6.17+/include/linux/elevator.h
--- linux-2.6.17~/include/linux/elevator.h	2006-06-18 22:51:43.000000000 +0200
+++ linux-2.6.17+/include/linux/elevator.h	2006-06-20 11:18:13.225409000 +0200
@@ -1,6 +1,12 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
+#include <linux/blkdev.h>
+#include <linux/types.h>
+
+struct bio;
+struct request;
+
 typedef int (elevator_merge_fn) (request_queue_t *, struct request **,
 				 struct bio *);
 
#<<eof>>

Jan Engelhardt
-- 
