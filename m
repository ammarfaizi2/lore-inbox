Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUDQFkU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbUDQFkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:40:19 -0400
Received: from holomorphy.com ([207.189.100.168]:31881 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263676AbUDQFj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:39:56 -0400
Date: Fri, 16 Apr 2004 22:39:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [4/5] ppc32 stack bounds checking
Message-ID: <20040417053957.GZ743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040417053538.GA20534@holomorphy.com> <20040417053712.GW743@holomorphy.com> <20040417053805.GX743@holomorphy.com> <20040417053905.GY743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417053905.GY743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: wli-2.6.5-mm6/arch/ppc/kernel/process.c
===================================================================
--- wli-2.6.5-mm6.orig/arch/ppc/kernel/process.c	2004-04-14 23:21:03.000000000 -0700
+++ wli-2.6.5-mm6/arch/ppc/kernel/process.c	2004-04-16 10:40:04.000000000 -0700
@@ -83,7 +83,7 @@
 unsigned long
 task_top(struct task_struct *tsk)
 {
-	return ((unsigned long)tsk) + sizeof(struct task_struct);
+	return ((unsigned long)tsk) + sizeof(struct thread_info);
 }
 
 /* check to make sure the kernel stack is healthy */
