Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVDHHvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVDHHvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDHHvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:51:18 -0400
Received: from coderock.org ([193.77.147.115]:4320 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262732AbVDHHu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:50:58 -0400
Subject: [patch 1/8] fix lib/sort regression test
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, didickman@yahoo.com
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:50:46 +0200
Message-Id: <20050408075048.B0E8A1F39E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The regression test in lib/sort.c is currently worthless because the array that is generated for sorting will be all zeros. This patch fixes things so 
that the array that is generated will contain unsorted integers (that are not all identical) as was probably intended.

Signed-off-by Daniel Dickman <didickman@yahoo.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/lib/sort.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN lib/sort.c~bug-lib_sort lib/sort.c
--- kj/lib/sort.c~bug-lib_sort	2005-04-05 12:57:40.000000000 +0200
+++ kj-domen/lib/sort.c	2005-04-05 12:57:40.000000000 +0200
@@ -90,7 +90,7 @@ int cmpint(const void *a, const void *b)
 
 static int sort_test(void)
 {
-	int *a, i, r = 0;
+	int *a, i, r = 1;
 
 	a = kmalloc(1000 * sizeof(int), GFP_KERNEL);
 	BUG_ON(!a);
_
