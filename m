Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbTEFVyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbTEFVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:54:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61626 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262012AbTEFVyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:54:05 -0400
Subject: tg3 - irq #: nobody cared!
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052258580.4495.12.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 15:03:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Not sure if this is the proper fix, but it stops the kernel from
complaining. I saw Andrew suggest something similar for a sound driver.

thanks
-john


--- 1.68/drivers/net/tg3.c	Wed Apr 23 20:02:11 2003
+++ edited/drivers/net/tg3.c	Mon May  5 11:39:08 2003
@@ -2191,7 +2191,7 @@
 
 	spin_unlock_irqrestore(&tp->lock, flags);
 
-	return IRQ_RETVAL(handled);
+	return IRQ_HANDLED;
 }
 
 static void tg3_init_rings(struct tg3 *);



