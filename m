Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVAPL6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVAPL6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVAPL6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:58:38 -0500
Received: from verein.lst.de ([213.95.11.210]:46557 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262484AbVAPL6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:58:36 -0500
Date: Sun, 16 Jan 2005 12:58:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: starvik@axis.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] remove bogus softirq_pending() usage in cris
Message-ID: <20050116115828.GA13716@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked by Mikael Starvik.


--- 1.17/arch/cris/kernel/irq.c	2004-10-20 10:37:14 +02:00
+++ edited/arch/cris/kernel/irq.c	2005-01-07 12:26:22 +01:00
@@ -158,11 +158,6 @@
 		local_irq_disable();
         }
         irq_exit();
-
-	if (softirq_pending(cpu))
-                do_softirq();
-
-        /* unmasking and bottom half handling is done magically for us. */
 }
 
 /* this function links in a handler into the chain of handlers for the
