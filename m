Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbULOJeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbULOJeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbULOJeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:34:19 -0500
Received: from holomorphy.com ([207.189.100.168]:39101 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262278AbULOJeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:34:08 -0500
Date: Wed, 15 Dec 2004 01:34:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [cleanup] remove CT_TO_SECS()/CT_TO_USECS()
Message-ID: <20041215093402.GF771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CT_TO_SECS() and CT_TO_USECS() are used nowhere in the tree. This
patch removes them.

Index: mm1-2.6.10-rc3/include/linux/sched.h
===================================================================
--- mm1-2.6.10-rc3.orig/include/linux/sched.h	2004-12-15 01:01:48.000000000 -0800
+++ mm1-2.6.10-rc3/include/linux/sched.h	2004-12-15 01:02:29.000000000 -0800
@@ -88,9 +88,6 @@
 	load += n*(FIXED_1-exp); \
 	load >>= FSHIFT;
 
-#define CT_TO_SECS(x)	((x) / HZ)
-#define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
-
 extern unsigned long total_forks;
 extern int nr_threads;
 extern int last_pid;
