Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLIL1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLIL1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLIL1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:27:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932090AbVLIL1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:27:07 -0500
Date: Fri, 9 Dec 2005 03:27:01 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051209112701.2500.11232.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] sparc atomic_clear_mask build fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes one build error introduced in sparc with the patch
of Oct 30, resent Nov 4 "[patch 3/5] atomic: atomic_inc_not_zero"
I still can't get sparc to build, but at least it gets further
after I remove this line.  Apparently, this change was agreed to
by Andrew and Nick on Nov 14, but everyone thought someone else
was doing it.

Signed-of-by: Paul Jackson <pj@sgi.com>

--- 2.6.15-rc3-mm1.orig/arch/sparc/lib/atomic32.c	2005-12-04 01:42:17.636291946 -0800
+++ 2.6.15-rc3-mm1/arch/sparc/lib/atomic32.c	2005-12-09 02:52:45.420360103 -0800
@@ -66,7 +66,6 @@ int atomic_add_unless(atomic_t *v, int a
 	return ret != u;
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 /* Atomic operations are already serializing */
 void atomic_set(atomic_t *v, int i)
 {

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
