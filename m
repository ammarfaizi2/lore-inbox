Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTAVFKa>; Wed, 22 Jan 2003 00:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTAVFK3>; Wed, 22 Jan 2003 00:10:29 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:50692
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267331AbTAVFK2>; Wed, 22 Jan 2003 00:10:28 -0500
Date: Wed, 22 Jan 2003 00:19:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5][3/18] smp_call_function_on_cpu fs/buffer.c
Message-ID: <Pine.LNX.4.44.0301220018410.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/fs/buffer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 buffer.c
--- linux-2.5.59/fs/buffer.c	17 Jan 2003 11:16:13 -0000	1.1.1.1
+++ linux-2.5.59/fs/buffer.c	22 Jan 2003 02:34:59 -0000
@@ -1418,7 +1418,7 @@
 {
 	preempt_disable();
 	invalidate_bh_lru(NULL);
-	smp_call_function(invalidate_bh_lru, NULL, 1, 1);
+	smp_call_function(invalidate_bh_lru, NULL, 1);
 	preempt_enable();
 }
 

-- 
function.linuxpower.ca

