Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262929AbTCSFlZ>; Wed, 19 Mar 2003 00:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTCSFlZ>; Wed, 19 Mar 2003 00:41:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:45745 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262929AbTCSFlY>;
	Wed, 19 Mar 2003 00:41:24 -0500
Date: Tue, 18 Mar 2003 21:52:28 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, efault@gmx.de
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
Message-Id: <20030318215228.417e0a58.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 05:52:10.0310 (UTC) FILETIME=[AE9F6E60:01C2EDDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> the attached patch (against BK-curr) implements more finegrained timeslice
> distribution, without changing the total balance of timeslices, by
> recalculating the priority of CPU-bound tasks at a finer granularity, and
> by roundrobining tasks. Right now this new granularity is 50 msecs (the
> default timeslice for default priority tasks is 100 msecs).

I've been running this on the problematic desktop for a couple of days now. 
All interactivity problems are 100% solved.  Smooth, fast, responsive,
unjerky, etc.   Congratulations and thanks; it is a big win.

The various starvation situations all appear to be fixed.

> Could people, who can reproduce 'audio skips' kind of problems even with
> BK-curr, give this patch a go?

I do not test for multimedia performance and cannot comment on this.

