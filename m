Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264988AbSJRUSc>; Fri, 18 Oct 2002 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265104AbSJRUSc>; Fri, 18 Oct 2002 16:18:32 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:51955 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S264988AbSJRUSc>;
	Fri, 18 Oct 2002 16:18:32 -0400
Date: Fri, 18 Oct 2002 16:24:26 -0400
From: Adam Kropelin <adam@kroptech.com>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5-BK: cpqarray IDA_LOCK compile fix
Message-ID: <20021018202426.GA32041@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Al,

The following is needed in current BK for cpqarray to build properly.

--Adam

--- linus-2.5/drivers/block/cpqarray.h.orig	Fri Oct 18 16:18:11 2002
+++ linus-2.5/drivers/block/cpqarray.h	Fri Oct 18 16:18:31 2002
@@ -118,7 +118,7 @@
 	unsigned int misc_tflags;
 };
 
-#define IDA_LOCK(i)	(&hba[i]->queue)
+#define IDA_LOCK(i)	(&hba[i]->lock)
 
 #endif
 
