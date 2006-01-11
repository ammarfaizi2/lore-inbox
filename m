Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWAKBqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWAKBqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWAKBqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:46:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161074AbWAKBqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:46:43 -0500
Date: Tue, 10 Jan 2006 17:48:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: -mm seems significanty slower than mainline on kernbench
Message-Id: <20060110174834.24b6c21e.akpm@osdl.org>
In-Reply-To: <43C4624D.4040604@google.com>
References: <43C45BDC.1050402@google.com>
	<20060110173159.55cce659.akpm@osdl.org>
	<43C4624D.4040604@google.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> Seems to have gone wrong between 2.6.14-rc1-mm1 and 2.6.14-rc2-mm1 ?
> See http://test.kernel.org/perf/kernbench.moe.png for clearest effect.

akpm:/usr/src/25> diff -u pc/2.6.14-rc1-mm1-series pc/2.6.14-rc2-mm1-series| grep sched
+move-tasklist-walk-from-cfq-iosched-to-elevatorc.patch
 sched-consider-migration-thread-with-smp-nice.patch
 sched-better-wake-balancing-3.patch
+sched-modified-nice-support-for-smp-load-balancing.patch
 #sched-rationalise-resched-and-cpu_idle.patch
 #fixup-resched-and-arch-cpu_idle.patch

Try reverting that sucker?
