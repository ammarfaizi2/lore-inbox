Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTBOXbZ>; Sat, 15 Feb 2003 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBOXbZ>; Sat, 15 Feb 2003 18:31:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:3507 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264815AbTBOXbY>;
	Sat, 15 Feb 2003 18:31:24 -0500
Date: Sat, 15 Feb 2003 15:41:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61-mm1
Message-Id: <20030215154154.1fcb9737.akpm@digeo.com>
In-Reply-To: <200302152227.03979.kernel@kolivas.org>
References: <20030214231356.59e2ef51.akpm@digeo.com>
	<200302152227.03979.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2003 23:41:14.0189 (UTC) FILETIME=[BA229FD0:01C2D54B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> I'm getting the same problem as 2.5.60-mm2 during boot:
> 
> bad: scheduling while atomic!
> Call Trace:
>  [<c0112ab1>] do_schedule+0x3d/0x2f4
>  [<c0112fb5>] wait_for_completion+0x8d/0xd0
>  [<c0112dac>] default_wake_function+0x0/0x1c
>  [<c0112dac>] default_wake_function+0x0/0x1c
>  [<c0122219>] create_workqueue+0x125/0x178
>  [<c010508e>] init+0x2a/0x17c
>  [<c0105064>] init+0x0/0x17c
>  [<c0106e5d>] kernel_thread_helper+0x5/0xc

This appears to be due to smalldevfs disagreeing with dcache_rcu over
dcache_lock conventions.

I'll drop out smalldevfs until Adam returns, and has time to look at it,
Thanks.
