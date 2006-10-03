Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWJCQjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWJCQjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWJCQjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:39:07 -0400
Received: from the.earth.li ([193.201.200.66]:21671 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S932261AbWJCQjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:39:03 -0400
Date: Tue, 3 Oct 2006 17:39:02 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export soc_common_drv_pcmcia_remove to allow modular PCMCIA.
Message-ID: <20061003163902.GC29608@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below allows me to build and modprobe a modular sa1100_cs.
Searching around finds others who've had the same problem. Exporting
soc_common_drv_pcmcia_remove solves the problem for me allowing a
modular PCMCIA build.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
Index: linux-2.6.18/drivers/pcmcia/soc_common.c
===================================================================
--- linux-2.6.18.orig/drivers/pcmcia/soc_common.c	2006-10-03 11:32:17.000000000 +0100
+++ linux-2.6.18/drivers/pcmcia/soc_common.c	2006-10-03 11:32:24.000000000 +0100
@@ -824,3 +824,4 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);
-----

J.

-- 
Purple alert! Purple alert! - Holly
