Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVDHIA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVDHIA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVDHH71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:59:27 -0400
Received: from coderock.org ([193.77.147.115]:13280 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262732AbVDHHv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:26 -0400
Subject: [patch 7/8] lib/sha1.c: fix sparse warning
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:10 +0200
Message-Id: <20050408075111.4B9271F3A4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix

lib/sha1.c:44:10: warning: cast to restricted type

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/lib/sha1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN lib/sha1.c~sparse-lib_sha1 lib/sha1.c
--- kj/lib/sha1.c~sparse-lib_sha1	2005-04-05 12:58:04.000000000 +0200
+++ kj-domen/lib/sha1.c	2005-04-05 12:58:04.000000000 +0200
@@ -41,7 +41,7 @@ void sha_transform(__u32 *digest, const 
 	__u32 a, b, c, d, e, t, i;
 
 	for (i = 0; i < 16; i++)
-		W[i] = be32_to_cpu(((const __u32 *)in)[i]);
+		W[i] = be32_to_cpu(((const __be32 *)in)[i]);
 
 	for (i = 0; i < 64; i++)
 		W[i+16] = rol32(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 1);
diff -L lib/sha1.c.orig -puN /dev/null /dev/null
_
