Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbTAVFK6>; Wed, 22 Jan 2003 00:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTAVFK5>; Wed, 22 Jan 2003 00:10:57 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:51716
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267332AbTAVFKz>; Wed, 22 Jan 2003 00:10:55 -0500
Date: Wed, 22 Jan 2003 00:20:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5][4/18] smp_call_function_on_cpu mm/slab.c
Message-ID: <Pine.LNX.4.44.0301220019530.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/mm/slab.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux-2.5.59/mm/slab.c	17 Jan 2003 11:16:41 -0000	1.1.1.1
+++ linux-2.5.59/mm/slab.c	22 Jan 2003 02:36:46 -0000
@@ -1122,7 +1122,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
+	if (smp_call_function(func, arg, 1))
 		BUG();
 }
 

-- 
function.linuxpower.ca

