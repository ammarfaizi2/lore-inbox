Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293065AbSCEAkx>; Mon, 4 Mar 2002 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSCEAkm>; Mon, 4 Mar 2002 19:40:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:505
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293065AbSCEAkd>; Mon, 4 Mar 2002 19:40:33 -0500
Date: Mon, 4 Mar 2002 16:41:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020305004130.GK353@matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1015287791.882.25.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015287791.882.25.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:23:10PM -0500, Robert Love wrote:
> The same schedule_tail bug affecting 2.5 affects 2.4 with O(1).  I.e.,
> 2.4.19-pre2-ac2.
> 
> In recent O(1) scheduler releases, an optimization was made that removed
> schedule_tail from UP kernels.  This causes the initial preempt_count of
> a new task, which starts at 1, to never decrement to zero and thus never
> become preemptible.  CONFIG_PREEMPT requires schedule_tail, too.
> 
> Users of 2.4+O(1)+preempt (i.e. -ac) should use this patch:
>

I believe you want to say that O(1)sched is in -ac, and this patch will add
preempt on top of that, not that preempt is already in -ac (unless I missed
something...)

Mike
