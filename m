Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSKDIco>; Mon, 4 Nov 2002 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbSKDIco>; Mon, 4 Nov 2002 03:32:44 -0500
Received: from dp.samba.org ([66.70.73.150]:27298 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265978AbSKDIcn>;
	Mon, 4 Nov 2002 03:32:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Fix undeclared NULL in timer.h
Date: Mon, 04 Nov 2002 18:32:50 +1100
Message-Id: <20021104083918.126192C27F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uncovered on a PPC compile: timer.h uses NULL, so needs stddef.h

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22822-2.5.45-bk-module-ppc.pre/include/linux/timer.h .22822-2.5.45-bk-module-ppc/include/linux/timer.h
--- .22822-2.5.45-bk-module-ppc.pre/include/linux/timer.h	2002-10-31 12:37:02.000000000 +1100
+++ .22822-2.5.45-bk-module-ppc/include/linux/timer.h	2002-11-04 18:28:53.000000000 +1100
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/stddef.h>
 
 struct tvec_t_base_s;
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
