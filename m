Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVHESK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVHESK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVHESIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:08:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261858AbVHESHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:07:02 -0400
Date: Fri, 5 Aug 2005 11:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Message-Id: <20050805110532.55428af7.akpm@osdl.org>
In-Reply-To: <20050805152245.GA12650@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<20050804152858.2ef2d72b.akpm@osdl.org>
	<20050805104819.GA20278@elte.hu>
	<200508051626.56910.dominik.karall@gmx.net>
	<20050805152245.GA12650@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Dominik Karall <dominik.karall@gmx.net> wrote:
> 
> > BUG: mono[10011] exited with nonzero preempt_count 1!
> > ---------------------------
> > | preempt count: 00000001 ]
> > | 1 level deep critical section nesting:
> > ----------------------------------------
> > .. [<ffffffff803f791e>] .... _spin_lock+0xe/0x70
> > .....[<0000000000000000>] ..   ( <= 0x0)
> > 
> > If there is anything I should test, let me know!

Thanks, Dominik.

> please enable CONFIG_FRAME_POINTERS!

Seems a bit tricky.  Wouldn't it be best if enabling CONFIG_DEBUG_PREEMPT
autoselected CONFIG_KALLSYMS_ALL, CONFIG_FRAME_POINTER and whatever else
we need?


