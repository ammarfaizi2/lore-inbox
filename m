Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbSLKGhm>; Wed, 11 Dec 2002 01:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbSLKGhl>; Wed, 11 Dec 2002 01:37:41 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56081
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267032AbSLKGhl>; Wed, 11 Dec 2002 01:37:41 -0500
Subject: Re: [PATCH] epoll: don't printk pointer value
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DF6DE1A.6FD498C9@digeo.com>
References: <20021211063031.GH9882@holomorphy.com>
	 <1039588429.832.6.camel@phantasy>  <3DF6DE1A.6FD498C9@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039589134.832.19.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 01:45:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 01:41, Andrew Morton wrote:

> Guys, it's noise.  Just nuke it.

So I would prefer...

	Robert Love

 fs/eventpoll.c |    2 --
 1 files changed, 2 deletions(-)


diff -urN linux-2.5.51/fs/eventpoll.c linux/fs/eventpoll.c
--- linux-2.5.51/fs/eventpoll.c	2002-12-09 21:45:54.000000000 -0500
+++ linux/fs/eventpoll.c	2002-12-11 01:43:59.000000000 -0500
@@ -1573,8 +1573,6 @@
 	if (IS_ERR(eventpoll_mnt))
 		goto eexit_4;
 
-	printk(KERN_INFO "[%p] eventpoll: successfully initialized.\n", current);
-
 	return 0;
 
 eexit_4:



