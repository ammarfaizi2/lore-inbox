Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVLOBIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVLOBIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVLOBIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:08:06 -0500
Received: from fsmlabs.com ([168.103.115.128]:11937 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S965145AbVLOBIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:08:04 -0500
X-ASG-Debug-ID: 1134608881-23806-10-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 14 Dec 2005 17:13:26 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
X-ASG-Orig-Subj: [PATCH] PPC: Remove unecessary BUG_ON
Subject: [PATCH] PPC: Remove unecessary BUG_ON
Message-ID: <Pine.LNX.4.64.0512141706590.1678@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6305
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following a NULL function pointer should trigger an instruction access 
fault.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

diff -r 5dfcc42643e1 arch/powerpc/kernel/idle_64.c
--- a/arch/powerpc/kernel/idle_64.c	Wed Dec 14 15:08:24 2005 +0800
+++ b/arch/powerpc/kernel/idle_64.c	Wed Dec 14 17:06:50 2005 -0800
@@ -84,7 +84,6 @@
 
 void cpu_idle(void)
 {
-	BUG_ON(NULL == ppc_md.idle_loop);
 	ppc_md.idle_loop();
 }
 
