Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTDGXuw (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTDGXa3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:30:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10625
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263894AbTDGXQt (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:16:49 -0400
Date: Tue, 8 Apr 2003 01:35:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080035.h380Ziws009245@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: lock for scc drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/scc.h linux-2.5.67-ac1/include/linux/scc.h
--- linux-2.5.67/include/linux/scc.h	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/scc.h	2003-04-07 20:05:18.000000000 +0100
@@ -244,6 +244,9 @@
 	/* Timer */
 	struct timer_list tx_t;		/* tx timer for this channel */
 	struct timer_list tx_wdog;	/* tx watchdogs */
+	
+	/* Channel lock */
+	spinlock_t	lock;		/* Channel guard lock */
 };
 
 #endif /* defined(__KERNEL__) */
