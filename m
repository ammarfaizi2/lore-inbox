Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJQBJu>; Wed, 16 Oct 2002 21:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbSJQBJu>; Wed, 16 Oct 2002 21:09:50 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:1157 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261609AbSJQBJt>; Wed, 16 Oct 2002 21:09:49 -0400
Message-ID: <010e01c2757b$920e8ed0$2a060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Michael Hohnbaum" <hohnbaum@us.ibm.com>, <torvalds@transmeta.com>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Cc: "Erich Focht" <efocht@ess.nec.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
References: <1034807518.9367.910.camel@dyn9-47-17-164.beaverton.ibm.com>
Subject: Re: [PATCH] NUMA Scheduler - rev 4
Date: Wed, 16 Oct 2002 20:21:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus, Ingo,
>
> Attached is a small patch which provides NUMA awareness to the
> O(1) scheduler.  This patch retains the identical O(1) scheduler
> behavior for SMP systems.  For multi-node systems it favors
> runqueues on the current node when looking for another runqueue
> to pull tasks from.  It also makes a balance decision at exec().
> This patch is against 2.5.43.
>
> On NUMA systems these two changes have shown performance gains
> in the 5 - 10% range depending on tests.  Some micro-benchmarks
> provided by Erich Focht which stress the memory subsystem show
> a doubling in performance.
>
> Please consider applying this patch.

FYI, to make sure there was no degrade for non numa systems, I just benched
a kernel compile on an IBM 8500R, with/without your patch.  Compile times
were 38.880 (vanilla) and 38.818 (numa sched).

Andrew Theurer

