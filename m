Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVG1Gy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVG1Gy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 02:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVG1Gy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 02:54:26 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25553 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261306AbVG1Gxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:53:33 -0400
Subject: [PATCH] Disable the debug.exception-trace sysctl by default
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 27 Jul 2005 23:53:30 -0700
Message-Id: <1122533610.14066.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8.njm.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

debug.exception-trace causes a large amount of log spew when on, and
it's on by default, which is an irritation.

Here's a patch to turn it off.

--- linux-2.6.12/arch/x86_64/mm/fault.c.~1~	2005-06-28
21:33:27.000000000 -0700
+++ linux-2.6.12/arch/x86_64/mm/fault.c	2005-07-27 23:46:10.000000000
-0700
@@ -284,7 +284,7 @@
 }
 
 int page_fault_trace = 0;
-int exception_trace = 1;
+int exception_trace = 0;
 
 /*
  * This routine handles page faults.  It determines the address,


-- 
Nicholas Miell <nmiell@comcast.net>

