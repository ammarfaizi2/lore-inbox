Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbULJQwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbULJQwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULJQwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:52:04 -0500
Received: from holomorphy.com ([207.189.100.168]:2450 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261752AbULJQwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:52:01 -0500
Date: Fri, 10 Dec 2004 08:51:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210165150.GO2714@holomorphy.com>
References: <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203022854.GL32635@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 03:28:54AM +0100, Andrea Arcangeli wrote:
> Ok, I expect this patch to fix the problem completely. The biggest
> difference is that it doesn't affect the exit fast path and it doesn't need
> notification. It's not even slower than your patch since you were
> really polling too. This schedule properly, if you get any PREEMPT=n
> problem I'd really like to know. This is on top of my previous patch so
> it does the checks for the watermarks correctly (those are not obsoleted
> by whatever thing we do in out_of_memory()). This still make use of the
> PF_MEMDIE info but not in kernel/, only in mm/oom_kill.c where it born
> and dies there, so the race is somewhat hidden in there. As you said
> converting PF_MEMDIE to a set_tsk_thread_flag or some other non-racy
> thing is a due change but I'm not doing it in the below patch.

I see some real bugfixes in here. I'll start up a fresh thread with some
of those broken out and cc: the relevant people shortly. It's not really
any "new material", just reorganizing things into smaller patches, in
particular the ones I see needing merging ASAP that aren't controversial.


-- wli
