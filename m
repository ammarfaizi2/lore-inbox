Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRLALbs>; Sat, 1 Dec 2001 06:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284075AbRLALbe>; Sat, 1 Dec 2001 06:31:34 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:15760 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284074AbRLALbL>; Sat, 1 Dec 2001 06:31:11 -0500
Date: Sat, 1 Dec 2001 13:36:03 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] if (foo) kfree(foo) /kernel cleanup
Message-ID: <Pine.LNX.4.33.0112011335010.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN linux-2.5.1-pre4.orig/kernel/sysctl.c linux-2.5.1-pre4.kfree/kernel/sysctl.c
--- linux-2.5.1-pre4.orig/kernel/sysctl.c	Fri Oct  5 21:23:53 2001
+++ linux-2.5.1-pre4.kfree/kernel/sysctl.c	Sat Dec  1 09:06:30 2001
@@ -343,8 +343,7 @@
 		int error = parse_table(name, nlen, oldval, oldlenp,
 					newval, newlen, head->ctl_table,
 					&context);
-		if (context)
-			kfree(context);
+		kfree(context);
 		if (error != -ENOTDIR)
 			return error;
 		tmp = tmp->next;



