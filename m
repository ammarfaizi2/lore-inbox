Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUIYCuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUIYCuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUIYCuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:50:01 -0400
Received: from holomorphy.com ([207.189.100.168]:35556 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269193AbUIYCtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:49:20 -0400
Date: Fri, 24 Sep 2004 19:49:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 1/8] nuke itimer_ticks and itimer_next
Message-ID: <20040925024917.GM9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925024513.GL9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 07:45:13PM -0700, William Lee Irwin III wrote:
> I split off the most easily mergeable parts of some sched.h header
> cleanups I wrote that better than halved the size of sched.h. In
> particular, these are the parts that don't require large sweeps,
> uninlining, or introducing new headers. Compiletested on x86-64.

Remove itimer_next and itimer_ticks; they are nowhere defined and
referenced nowhere else.


Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 17:37:15.000000000 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 18:38:02.935107528 -0700
@@ -939,8 +939,6 @@
 
 #include <asm/current.h>
 
-extern unsigned long itimer_ticks;
-extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
