Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbSISXIX>; Thu, 19 Sep 2002 19:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273733AbSISXIX>; Thu, 19 Sep 2002 19:08:23 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:31848 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S273724AbSISXIW>; Thu, 19 Sep 2002 19:08:22 -0400
Date: Fri, 20 Sep 2002 09:15:27 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
cc: Gustavo Lozano <glozano@noldata.com>
Subject: [PATCH 2.(2|4)] agpgart_fe printk is too terse
Message-ID: <Pine.LNX.4.05.10209200909290.23877-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Appended patch against 2.4.20-pre4 fixes a (IMHO) way-too-terse printk in
drivers/char/agp/agpgart_fe.c

Motivation is that when scrounging through syslog etc finding an entry
that simply says "memory : <value>" leaves rather too much to the
imagination (not to mention being interesting to grep out of the
source).

This applies to 2.2 also (but has already been applied to 2.5).

Thanks,
Neale.

--- linux-2.4.20-pre4/drivers/char/agp/agpgart_fe.c	Mon Aug 13 03:38:48 2001
+++ linux-2.4.20-pre4-ntb/drivers/char/agp/agpgart_fe.c	Fri Sep 20 08:57:40 2002
@@ -301,7 +301,7 @@
 	agp_memory *memory;
 
 	memory = agp_allocate_memory(pg_count, type);
-   	printk(KERN_DEBUG "memory : %p\n", memory);
+   	printk(KERN_DEBUG "agp_allocate_memory: %p\n", memory);
 	if (memory == NULL) {
 		return NULL;
 	}

