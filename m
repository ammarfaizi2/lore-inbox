Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbSIYDfc>; Tue, 24 Sep 2002 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbSIYDXV>; Tue, 24 Sep 2002 23:23:21 -0400
Received: from dp.samba.org ([66.70.73.150]:44416 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261892AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 6/20: streq
Date: Wed, 25 Sep 2002 13:01:03 +1000
Message-Id: <20020925032201.A38102C12D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: streq implementation
Author: Rusty Russell
Status: Trivial
Depends: Misc/strcspn.patch.gz

D: I can't believe that after all these years I still make the "sense
D: of strcmp" mistake.  So it's time to reintroduce my favorite macro.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24879-linux-2.5.38/include/linux/string.h .24879-linux-2.5.38.updated/include/linux/string.h
--- .24879-linux-2.5.38/include/linux/string.h	2002-09-24 21:23:55.000000000 +1000
+++ .24879-linux-2.5.38.updated/include/linux/string.h	2002-09-24 21:24:33.000000000 +1000
@@ -16,6 +16,7 @@ extern char * strpbrk(const char *,const
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
+#define streq(a,b) (strcmp((a),(b)) == 0)
 
 /*
  * Include machine specific inline routines

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
