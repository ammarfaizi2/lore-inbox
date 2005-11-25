Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVKYX2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKYX2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 18:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVKYX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 18:28:14 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:17657 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932444AbVKYX2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 18:28:13 -0500
Subject: [PATCH -rt] export tsc_c3_compensate for x86_64
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 18:28:04 -0500
Message-Id: <1132961284.24417.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

The tsc_c3_compensate needs to be exported for the x86_64 arch.

-- Steve

Index: linux-2.6.14-rt15/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.14-rt15.orig/arch/x86_64/kernel/time.c	2005-11-25 10:14:09.000000000 -0500
+++ linux-2.6.14-rt15/arch/x86_64/kernel/time.c	2005-11-25 17:43:16.000000000 -0500
@@ -268,6 +268,7 @@
 	u64 cycles = ((u64)nsecs * tsc_khz)/1000000;
 	tsc_c3_offset += cycles;
 }
+EXPORT_SYMBOL_GPL(tsc_c3_compensate);
 
 static inline u64 tsc_read_c3_time(void)
 {


