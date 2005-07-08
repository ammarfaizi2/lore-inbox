Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVGHRIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVGHRIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGHRIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:08:41 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:43364 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262717AbVGHRIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:08:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OYcoIeIBTPFkDdkYo1NF73Rh9bpGSz/M2QdYYu8Uy7AA9VY9IRzKVZbFudzG7KMD82OnHGb4aYg3jQ/CA2uQsoTWMhm4c4MhU5cSuSY2MMzJv2rBy8KPLH8QTkhTztYh/w3cxIXMKcZev/9m1FIJNZti36i6UA1e2tNruOrfM64=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Really __nocast-annotate kmalloc_node().
Date: Fri, 8 Jul 2005 21:15:02 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507082115.02904.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One chunk was lost somewhere between my and Andrew's machine.

Noticed by Victor Fusco.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/slab.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-vanilla/include/linux/slab.h	2005-07-08 13:52:46.000000000 +0400
+++ linux-slab/include/linux/slab.h	2005-07-08 21:02:47.000000000 +0400
@@ -111,7 +111,7 @@ static inline void *kmem_cache_alloc_nod
 {
 	return kmem_cache_alloc(cachep, flags);
 }
-static inline void *kmalloc_node(size_t size, int flags, int node)
+static inline void *kmalloc_node(size_t size, unsigned int __nocast flags, int node)
 {
 	return kmalloc(size, flags);
 }
