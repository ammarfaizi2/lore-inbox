Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUEFTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUEFTNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUEFSwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:52:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29005 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261942AbUEFStT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:19 -0400
Date: Thu, 6 May 2004 11:46:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 1/15] pj-fix-1-unifix
Message-Id: <20040506114629.74bea739.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Randy.Dunlap" <rddunlap@osdl.org>

There is a general desire to reduce the quantity of noisy and/or
outdated kernel boot-time messages...

Suggested by Andi Kleen.

Ulrich's (old) comments:
http://www.nsa.gov/selinux/list-archive/0107/0525.cfm

Certifying Linux (Linux Journal):
http://www.linuxjournal.com/article.php?sid=0131


Index: 2.6.6-rc3-mm2/init/main.c
===================================================================
--- 2.6.6-rc3-mm2.orig/init/main.c	2004-05-05 06:11:32.000000000 -0700
+++ 2.6.6-rc3-mm2/init/main.c	2004-05-05 06:27:12.000000000 -0700
@@ -521,7 +521,6 @@
 	proc_root_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
