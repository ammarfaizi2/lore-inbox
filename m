Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVBMPL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVBMPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 10:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVBMPL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 10:11:29 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43767 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261277AbVBMPLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 10:11:25 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050213125920.GA10256@elte.hu>
References: <20050211082841.GA3349@elte.hu>
	 <000601c5101f$8ca3c1e0$c800a8c0@mvista.com> <20050211100405.GA7452@elte.hu>
	 <1108158547.21183.60.camel@localhost.localdomain>
	 <20050213125920.GA10256@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 13 Feb 2005 10:11:19 -0500
Message-Id: <1108307479.21183.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 13:59 +0100, Ingo Molnar wrote:

> yeah - it's "M" already in fs/proc/array.c, but i missed the sched.c
> case.
> 

You also missed the kernel/rt.c case :-)

-- Steve


Index: kernel/rt.c
===================================================================
--- kernel/rt.c	(revision 75)
+++ kernel/rt.c	(working copy)
@@ -207,6 +207,7 @@
 {
 	switch (p->state) {
 	case TASK_RUNNING:		printk("R"); break;
+	case TASK_RUNNING_MUTEX:	printk("M"); break;
 	case TASK_INTERRUPTIBLE:	printk("s"); break;
 	case TASK_UNINTERRUPTIBLE:	printk("D"); break;
 	case TASK_STOPPED:		printk("T"); break;


This is still from the 38-06.



