Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVF1OLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVF1OLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVF1OLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:11:39 -0400
Received: from pih-relay06.plus.net ([212.159.14.133]:49849 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S261675AbVF1OKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:10:10 -0400
Date: Tue, 28 Jun 2005 15:09:59 +0100
From: Ash Milsted <thatistosayiseenem@gawab.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.12-git8 Voluntary preempt hangs at boot
Message-Id: <20050628150959.728ac18a.thatistosayiseenem@gawab.com>
In-Reply-To: <20050628072718.GA3755@elte.hu>
References: <20050627161405.60490ec3.thatistosayiseenem@gawab.com>
	<20050628072718.GA3755@elte.hu>
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this solves the problem. Cheers.

-Ash

On Tue, 28 Jun 2005 09:27:18 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ash Milsted <thatistosayiseenem@gawab.com> wrote:
> 
> > Just tried out VP on 2.6.12-git8 on my UP x86 system - it hangs just 
> > after configuring the cpu, i.e. enabling fast FPU restore, etc.  
> > Disabling ACPI and the local APIC makes no difference. Here's my 
> > current config, which *does* work - I only need to enable VP to break 
> > it. Btw, it also breaks without the CFQv3 and inotify patches.
> 
> i forgot about a dependency, -VP also needs this patch:
> 
>  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/sched-tweak-idle-thread-setup-semantics.patch
> 
> could you check that this patch ontop of -git8 indeed fixes the boot 
> problem for you?
> 
> 	Ingo
