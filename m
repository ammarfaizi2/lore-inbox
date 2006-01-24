Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWAXBXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWAXBXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWAXBXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:23:49 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62934 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030250AbWAXBXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:23:48 -0500
Subject: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was:
	2.6.15-rt12 bugs)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 20:23:42 -0500
Message-Id: <1138065822.6695.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here Ingo,

The kstop_machine has a legitimate preempt_enable_no_resched.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rt12/kernel/stop_machine.c
===================================================================
--- linux-2.6.15-rt12.orig/kernel/stop_machine.c	2006-01-23 09:15:37.000000000 -0500
+++ linux-2.6.15-rt12/kernel/stop_machine.c	2006-01-23 19:58:26.000000000 -0500
@@ -134,7 +134,7 @@
 {
 	stopmachine_set_state(STOPMACHINE_EXIT);
 	raw_local_irq_enable();
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 }
 
 struct stop_machine_data


