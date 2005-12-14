Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVLNTeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLNTeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVLNTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:34:50 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:16322 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932242AbVLNTet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:34:49 -0500
Subject: Re: kernel-2.6.15-rc5-rt2 - compilation error
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, art <art@usfltd.com>
In-Reply-To: <200512141157.AA15073854@usfltd.com>
References: <200512141157.AA15073854@usfltd.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 14:33:11 -0500
Message-Id: <1134588791.13138.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

x86_64 wont compile without PREEMPT_RT. It must regardless of PREEMPT_RT
have RWSEM_GENERIC_SPINLOCK.

-- Steve

Index: linux-2.6.15-rc5-rt2/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt2.orig/arch/x86_64/Kconfig	2005-12-14 13:50:24.000000000 -0500
+++ linux-2.6.15-rc5-rt2/arch/x86_64/Kconfig	2005-12-14 14:08:02.000000000 -0500
@@ -240,13 +240,8 @@
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
-	depends on PREEMPT_RT
 	default y
 
-config RWSEM_XCHGADD_ALGORITHM
-	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
-	bool
-
 config K8_NUMA
        bool "Old style AMD Opteron NUMA detection"
        depends on NUMA



