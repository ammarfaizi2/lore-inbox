Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVDHIAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVDHIAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVDHH6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:58:03 -0400
Received: from coderock.org ([193.77.147.115]:7648 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262736AbVDHHvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:09 -0400
Subject: [patch 3/8] string.linux-2.6.10/lib/c: documentation strncpy()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, wharms@bfs.de
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:50:56 +0200
Message-Id: <20050408075057.3C9EE1EE91@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



this clarifys the documentation on the behavier of strncpy().


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/lib/string.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -L lib/c.bak -puN /dev/null /dev/null
diff -puN lib/string.c~comment-lib_string lib/string.c
--- kj/lib/string.c~comment-lib_string	2005-04-05 12:57:42.000000000 +0200
+++ kj-domen/lib/string.c	2005-04-05 12:57:42.000000000 +0200
@@ -85,6 +85,10 @@ EXPORT_SYMBOL(strcpy);
  *
  * The result is not %NUL-terminated if the source exceeds
  * @count bytes.
+ *
+ * In the case where the length of @src is less than  that  of
+ * count, the remainder of @dest will be padded with %NUL.
+ *
  */
 char * strncpy(char * dest,const char *src,size_t count)
 {
_
