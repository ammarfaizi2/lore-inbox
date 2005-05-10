Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVEJW63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVEJW63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEJW63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:58:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:15753 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261837AbVEJW6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:58:23 -0400
Date: Wed, 11 May 2005 01:02:16 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
Message-ID: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Documentation/CodingStyle : 
        "Don't put multiple statements on a single line unless you have
         something to hide:
         
         if (condition) do_this;
           do_something_everytime;
        "

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 kernel/module.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc3-mm3-orig/kernel/module.c	2005-05-06 23:21:28.000000000 +0200
+++ linux-2.6.12-rc3-mm3/kernel/module.c	2005-05-11 00:56:54.000000000 +0200
@@ -410,7 +410,8 @@ static int already_uses(struct module *a
 static int use_module(struct module *a, struct module *b)
 {
 	struct module_use *use;
-	if (b == NULL || already_uses(a, b)) return 1;
+	if (b == NULL || already_uses(a, b))
+		return 1;
 
 	if (!strong_try_module_get(b))
 		return 0;
@@ -1731,9 +1732,10 @@ static struct module *load_module(void _
 	kfree(args);
  free_hdr:
 	vfree(hdr);
-	if (err < 0) return ERR_PTR(err);
-	else return ptr;
-
+	if (err < 0)
+		return ERR_PTR(err);
+	else
+		return ptr;
  truncated:
 	printk(KERN_ERR "Module len %lu truncated\n", len);
 	err = -ENOEXEC;



