Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWBASSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWBASSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBASSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:18:54 -0500
Received: from fmr22.intel.com ([143.183.121.14]:16563 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWBASSx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:18:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 41/44] make thread_info.flags an unsigned long
Date: Wed, 1 Feb 2006 10:17:43 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0595DB4D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 41/44] make thread_info.flags an unsigned long
Thread-Index: AcYnDq5nlgSUChzQS/qIxsRaC5J0oQATMRmw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Akinobu Mita" <mita@miraclelinux.com>, <linux-kernel@vger.kernel.org>
Cc: "Richard Henderson" <rth@twiddle.net>,
       "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
       <linux-ia64@vger.kernel.org>, <linuxsh-dev@lists.sourceforge.net>,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 01 Feb 2006 18:17:45.0225 (UTC) FILETIME=[CC733F90:01C6275B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
--- 2.6-git.orig/include/asm-ia64/thread_info.h
+++ 2.6-git/include/asm-ia64/thread_info.h
@@ -24,7 +24,7 @@
 struct thread_info {
 	struct task_struct *task;	/* XXX not really needed, except for dup_task_struct() */
 	struct exec_domain *exec_domain;/* execution domain */
-	__u32 flags;			/* thread_info flags (see TIF_*) */
+	unsigned long flags;		/* thread_info flags (see TIF_*) */
 	__u32 cpu;			/* current CPU */
 	mm_segment_t addr_limit;	/* user-level address space limit */
 	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */

This leaves a useless hole in the structure.  Tell me again why
this is a good thing?

-Tony
