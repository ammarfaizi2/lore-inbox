Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbVGOWdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbVGOWdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbVGOWau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:30:50 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:48168 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263366AbVGOW2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lyj16BVmJVJE6g8qkwwp7utblyG4Z0Syrj4FRkATh7vKb0SJgcoc1q2hK+EQd4bCt/dt7leaN7sDVDuQPCdQDeCln5qYhMdb9W0fLdk1N7JCPmgY8Xt0RxQJLsYd/A7MiPsPumnqJhUQtKX4STtuLNC3/wFgXemH+3pD0OvvLLQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -linus] Really __nocast-annotate kmalloc_node().
Date: Sat, 16 Jul 2005 02:36:02 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507160236.02968.adobriyan@gmail.com>
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
