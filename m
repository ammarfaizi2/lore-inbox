Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUEKJHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUEKJHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUEKJGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:06:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:13196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262648AbUEKJEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:04:41 -0400
Date: Tue, 11 May 2004 02:04:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 11/11] adjust default mqueue sizes
Message-ID: <20040511020436.J21045@build.pdx.osdl.net>
References: <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net> <20040511015357.E21045@build.pdx.osdl.net> <20040511015658.F21045@build.pdx.osdl.net> <20040511015833.G21045@build.pdx.osdl.net> <20040511020002.H21045@build.pdx.osdl.net> <20040511020252.I21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511020252.I21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 02:02:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lower default sizes for POSIX mqueue allocation now that rlimits are in
place.

--- 2.6-rlimit/ipc/mqueue.c~mqueue_rlimit	2004-05-10 22:28:43.137833864 -0700
+++ 2.6-rlimit/ipc/mqueue.c	2004-05-10 22:30:44.530379392 -0700
@@ -43,10 +43,10 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
-#define DFLT_MSGMAX 	40	/* max number of messages in each queue */
+#define DFLT_QUEUESMAX	256	/* max number of message queues */
+#define DFLT_MSGMAX 	10	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
-#define DFLT_MSGSIZEMAX 16384	/* max message size */
+#define DFLT_MSGSIZEMAX 8192	/* max message size */
 
 #define NOTIFY_COOKIE_LEN	32
 

