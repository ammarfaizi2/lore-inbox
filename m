Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVKKRKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVKKRKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVKKRKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:10:10 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:3785 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750927AbVKKRKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:10:08 -0500
Date: Sat, 12 Nov 2005 02:09:48 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [-mm PATCH] slob: add kmem_set_shrinker
Message-Id: <20051112020948.798c0199.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
References: <20051110203544.027e992c.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds kmem_set_shrinker() to SLOB.
It is necessary for fixing the build error.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -Npru -X dontdiff mm2-orig/mm/slob.c mm2/mm/slob.c
--- mm2-orig/mm/slob.c	2005-11-11 22:21:20.000000000 +0900
+++ mm2/mm/slob.c	2005-11-11 23:15:02.000000000 +0900
@@ -240,6 +240,11 @@ unsigned int ksize(const void *block)
 	return ((slob_t *)block - 1)->units * SLOB_UNIT;
 }
 
+void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+{
+}
+EXPORT_SYMBOL(kmem_set_shrinker);
+
 struct kmem_cache {
 	unsigned int size, align;
 	const char *name;
