Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTK3BAb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTK3BAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 20:00:31 -0500
Received: from h008.c007.snv.cp.net ([209.228.33.236]:20160 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S264494AbTK3BAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 20:00:30 -0500
X-Sent: 30 Nov 2003 01:00:29 GMT
Message-ID: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana>
From: "Chris Peterson" <chris@potamus.org>
To: <linux-kernel@vger.kernel.org>
Subject: question about preempt_disable()
Date: Sat, 29 Nov 2003 16:59:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought Robert Love's new book "Linux Kernel Development". The book
has been very informative, but I have some unanswered questions about kernel
preemption.

>From what I understand, SMP-safe code is also preempt-safe. The preempt
count is the number of spinlocks held by the current kernel thread. If the
preempt code is greater zero, then the kernel thread cannot be preempted.

My question is: if the code is already SMP-safe and holding the necessary
spinlocks, why is the preempt count necessary? Why must preemption be
disabled and re-enabled as spinlocks are acquired and released? Is it just
an optimization for accessing per-cpu data? Or is it necessary to prevent
priority inversion of kernel threads, when a low priority thread holds
spinlock X and is preempted by a high priority thread that hogs the CPU,
forever spinning in spin_lock(&X)?


chris

