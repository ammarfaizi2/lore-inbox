Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUL3JyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUL3JyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUL3JyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:54:06 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:15544 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261600AbUL3JyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 04:54:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=jFRKOv4CuRPPJAcfh5N3pou3ko5vXtGgmMZxgYTyEI9CTi2p9AvsXzDqlQXO9b7UJC/52Qk+SBzOcd9AnhXR1mzIKyKKeA/34KOsWilXX2d/GXg+vxtyPuNqyCc/QIYOOdUw7RLEXHjhB1sakhOut1JKSAXT2LIz7oU0o63qnms=
Message-ID: <2cd57c9004123001542a4192bb@mail.gmail.com>
Date: Thu, 30 Dec 2004 17:54:01 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] removes redundant sys_delete_module()
Cc: peterc@gelato.unsw.edu.au, akpm@osdl.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb recently splitted out a standalone sys_ni.c file for the
not implemented syscalls.
This patch removes the redundant sys_delete_module() in module.c.

Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>

 module.c |    7 -------
 1 files changed, 7 deletions(-)

diff -Nurp 2.6.10/kernel/module.c 2.6.10-cy/kernel/module.c
--- 2.6.10/kernel/module.c	2004-12-29 01:29:40.000000000 +0800
+++ 2.6.10-cy/kernel/module.c	2004-12-30 17:17:41.000000000 +0800
@@ -681,13 +681,6 @@ static inline int use_module(struct modu
 static inline void module_unload_init(struct module *mod)
 {
 }
-
-asmlinkage long
-sys_delete_module(const char __user *name_user, unsigned int flags)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_MODULE_UNLOAD */
 
 #ifdef CONFIG_OBSOLETE_MODPARM

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
