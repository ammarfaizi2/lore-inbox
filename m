Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUJZTj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUJZTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUJZTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:39:27 -0400
Received: from holomorphy.com ([207.189.100.168]:13543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262329AbUJZTjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:39:04 -0400
Date: Tue, 26 Oct 2004 12:38:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: remove itimer_ticks and itimer_next
Message-ID: <20041026193851.GC15367@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two variables are long, long dead. This patch removes them.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: wli-2.6.10-rc1/include/linux/sched.h
===================================================================
--- wli-2.6.10-rc1.orig/include/linux/sched.h	2004-10-22 14:38:20.000000000 -0700
+++ wli-2.6.10-rc1/include/linux/sched.h	2004-10-26 12:17:13.000000000 -0700
@@ -771,8 +771,6 @@
 
 #include <asm/current.h>
 
-extern unsigned long itimer_ticks;
-extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
