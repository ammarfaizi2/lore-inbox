Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDIP1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDIP1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDIP1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:27:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29610 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750772AbWDIP13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:27:29 -0400
Date: Sun, 9 Apr 2006 17:27:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/19] kconfig: fix typo in change count initialization
Message-ID: <Pine.LNX.4.64.0604091727190.23120@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/confdata.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -325,7 +325,7 @@ int conf_read(const char *name)
 				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
 	}
 
-	sym_change_count = conf_warnings && conf_unsaved;
+	sym_change_count = conf_warnings || conf_unsaved;
 
 	return 0;
 }
