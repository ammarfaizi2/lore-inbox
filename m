Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSLKGZ6>; Wed, 11 Dec 2002 01:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSLKGZ5>; Wed, 11 Dec 2002 01:25:57 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:43281
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267029AbSLKGZz>; Wed, 11 Dec 2002 01:25:55 -0500
Subject: Re: [PATCH] epoll: don't printk pointer value
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
In-Reply-To: <20021211063031.GH9882@holomorphy.com>
References: <1039588045.833.3.camel@phantasy>
	 <20021211063031.GH9882@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039588429.832.6.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 01:33:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 01:30, William Lee Irwin III wrote:

> You're still passing current as an argument to the printk.

Ah crap.  That is what I get for not testing it... nothing is too
trivial, boys and girls.

Thanks, Bill.

	Robert Love

 fs/eventpoll.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.51/fs/eventpoll.c linux/fs/eventpoll.c
--- linux-2.5.51/fs/eventpoll.c	2002-12-09 21:45:54.000000000 -0500
+++ linux/fs/eventpoll.c	2002-12-11 01:23:07.000000000 -0500
@@ -1573,7 +1573,7 @@
 	if (IS_ERR(eventpoll_mnt))
 		goto eexit_4;
 
-	printk(KERN_INFO "[%p] eventpoll: successfully initialized.\n", current);
+	printk(KERN_INFO "eventpoll: successfully initialized.\n");
 
 	return 0;
 



