Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUKSXzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUKSXzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKSXr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:47:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15888 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261707AbUKSXrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:47:41 -0500
Date: Fri, 19 Nov 2004 23:47:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: smc91c92_cs silly
Message-ID: <20041119234731.D27784@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes wrong arguments to outw in smc91c92_cs.c

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

--- orig/drivers/net/pcmcia/smc91c92_cs.c	10 Sep 2004 15:42:36 -0000
+++ linux/drivers/net/pcmcia/smc91c92_cs.c	19 Nov 2004 23:42:22 -0000
@@ -2113,7 +2113,7 @@
 	tmp |= TCR_FDUPLX;
     else
 	tmp &= ~TCR_FDUPLX;
-    outw(ioaddr + TCR, tmp);
+    outw(tmp, ioaddr + TCR);
 	
     return 0;
 }

-- 
Russell King

