Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTB1VFY>; Fri, 28 Feb 2003 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTB1VFX>; Fri, 28 Feb 2003 16:05:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:28073 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261963AbTB1VFW>;
	Fri, 28 Feb 2003 16:05:22 -0500
Date: Fri, 28 Feb 2003 13:12:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030228131206.22fc077c.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 21:15:33.0056 (UTC) FILETIME=[87625400:01C2DF6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> this is the latest HT scheduler patch, against 2.5.63-BK.

It's looking pretty good Ingo.

- The "tbench starves everything else" problem is fixed.

- The mm_struct leak is fixed

- As far as I can tell, the scheduler update no longer causes the
  large "contest io_load" changes, wherein the streaming write made
  lots more progress at the expense of the kernel compile.

- The longstanding problem wherein a kernel build makes my X desktop
  unusable is 90% fixed - it is still possible to trigger stalls, but
  they are less severe, and you actually have to work at it a bit to
  make them happen.

Thanks.
