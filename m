Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTEEUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTEEUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:50:09 -0400
Received: from holomorphy.com ([66.224.33.161]:9091 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261362AbTEEUuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:50:06 -0400
Date: Mon, 5 May 2003 14:02:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
Message-ID: <20030505210233.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030504231650.75881288.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504231650.75881288.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 11:16:50PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm1/
> Various random fixups, cleanps and speedups.  Mainly a resync to 2.5.69.

kernel/sched.c: In function `rebalance_tick':
kernel/sched.c:1352: warning: declaration of `this_cpu' shadows a parameter


diff -urpN mm1-2.5.69-1/kernel/sched.c mm1-2.5.69-2/kernel/sched.c
--- mm1-2.5.69-1/kernel/sched.c	2003-05-05 13:32:44.000000000 -0700
+++ mm1-2.5.69-2/kernel/sched.c	2003-05-05 13:37:28.000000000 -0700
@@ -1348,9 +1348,6 @@ static void balance_node(runqueue_t *thi
 
 static void rebalance_tick(runqueue_t *this_rq, int this_cpu, int idle)
 {
-#ifdef CONFIG_NUMA
-	int this_cpu = smp_processor_id();
-#endif
 	unsigned long j = jiffies;
 
 	/*
