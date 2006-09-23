Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWIWRod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWIWRod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWIWRod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:44:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:219 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751376AbWIWRoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:44:32 -0400
Date: Sat, 23 Sep 2006 13:44:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -rt] export symbol jiffies_to_timespec
Message-ID: <Pine.LNX.4.58.0609231342150.23264@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

My Atheros wireless nic driver doesn't load without this patch.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rt3/kernel/time.c
===================================================================
--- linux-2.6.18-rt3.orig/kernel/time.c	2006-09-23 13:29:31.000000000 -0400
+++ linux-2.6.18-rt3/kernel/time.c	2006-09-23 13:30:11.000000000 -0400
@@ -613,6 +613,8 @@ jiffies_to_timespec(const unsigned long
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }

+EXPORT_SYMBOL(jiffies_to_timespec);
+
 /* Same for "timeval"
  *
  * Well, almost.  The problem here is that the real system resolution is
