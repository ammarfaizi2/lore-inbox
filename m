Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266843AbTGGIhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbTGGIhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:37:04 -0400
Received: from lidskialf.net ([62.3.233.115]:7334 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S266843AbTGGIhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:37:00 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Compile nvidia-agp.c as module in 2.5.75
Date: Mon, 7 Jul 2003 09:51:34 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307070951.34172.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needs agp_memory_reserved exported (cannot use the standard calls in 
agp/generic.c it seems).

---CUT HERE--
--- linux-2.5.74.orig/drivers/char/agp/generic.c	2003-07-02 21:45:17.000000000 
+0100
+++ linux-2.5.74/drivers/char/agp/generic.c	2003-07-07 09:45:03.000000000 
+0100
@@ -39,6 +39,7 @@
 
 __u32 *agp_gatt_table; 
 int agp_memory_reserved;
+EXPORT_SYMBOL_GPL(agp_memory_reserved);
 
 /* 
  * Generic routines for handling agp_memory structures -
--- CUT HERE---

