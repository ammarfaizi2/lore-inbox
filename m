Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbTFWVVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbTFWVVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:21:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265528AbTFWVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:20:50 -0400
Date: Mon, 23 Jun 2003 14:35:35 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] another minor sparse change adding opnames.
Message-ID: <20030623213535.GA25257@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add more operations to the name list.  Without these additions,
the "and" operator is displayed as a null pointer. 

In the original code, the "&" operator was within the name[] array,
but didnt' have a string assigned to it.  So printf() displayed it as
the string "null".  While I was at it, I added other operation names to
the table.


--- sparse_original/show-parse.c	2003-06-10 11:02:22.000000000 -0700
+++ sparse_test/show-parse.c	2003-06-23 14:29:17.000000000 -0700
@@ -607,7 +607,8 @@
 	static const char *name[] = {
 		['+'] = "add", ['-'] = "sub",
 		['*'] = "mul", ['/'] = "div",
-		['%'] = "mod"
+		['%'] = "mod", ['&'] = "and",
+		['|'] = "lor", ['^'] = "xor"
 	};
 	unsigned int op = expr->op;
 
