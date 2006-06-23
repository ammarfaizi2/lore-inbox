Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933008AbWFWK4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbWFWK4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbWFWK4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5132 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933008AbWFWKzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:40 -0400
Date: Fri, 23 Jun 2006 12:55:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/lockdep.c: make 3 functions static
Message-ID: <20060623105540.GN9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/lockdep.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm1-full/kernel/lockdep.c.old	2006-06-22 17:39:33.000000000 +0200
+++ linux-2.6.17-mm1-full/kernel/lockdep.c	2006-06-22 17:48:58.000000000 +0200
@@ -444,7 +444,7 @@
 		printk("  ");
 }
 
-void print_lock_type_header(struct lock_type *type, int depth)
+static void print_lock_type_header(struct lock_type *type, int depth)
 {
 	int bit;
 
@@ -516,7 +516,7 @@
 	printk(" } [%d]", nr);
 }
 
-void print_lock_type(struct lock_type *type)
+static void print_lock_type(struct lock_type *type)
 {
 	print_lock_type_header(type, 0);
 	if (!list_empty(&type->locks_after))
@@ -1177,7 +1177,7 @@
  * To make lock name printouts unique, we calculate a unique
  * type->name_version generation counter:
  */
-int count_matching_names(struct lock_type *new_type)
+static int count_matching_names(struct lock_type *new_type)
 {
 	struct lock_type *type;
 	int count = 0;

