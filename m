Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUCKTei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCKTbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:31:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:11183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbUCKT2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:28:51 -0500
Date: Thu, 11 Mar 2004 11:28:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311112852.4f56cf34.akpm@osdl.org>
In-Reply-To: <m3lllzawlm.fsf@averell.firstfloor.org>
References: <1ysXv-wm-11@gated-at.bofh.it>
	<m3lllzawlm.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > - The CPU scheduler changes in -mm (sched-domains) have been hanging about
> >   for too long.  I had been hoping that the people who care about SMT and
> >   NUMA performance would have some results by now but all seems to be silent.
> >
> >   I do not wish to merge these up until the big-iron guys can say that they
> >   suit their requirements, with a reasonable expectation that we will not
> >   need to churn this code later in the 2.6 series.
> >
> >   So.  If you have been testing, please speak up.  If you have not been
> >   testing, please do so.
> 
> I tested them on Opteron NUMA systems and they are worse on simple
> tests than the stock scheduler (e.g. the parallelized STREAM test,
> which is a bit silly, but still fairly important)

OK, thanks.

> For SMT there is a patch from Intel pending that teaches x86-64
> to set up the SMT scheduler. They said they got slightly better
> benchmark results. The SMT setup seems to be racy though.

Am I correct in thinking that this patch provides the necessary hooks to
integrate x86_4 into the new functionality which sched-domains provides, or
is the Intel patch independent of sched-domains?

> Some kind of SMT scheduler is definitely needed, we have a serious
> regression compared to 2.4 here right now. I'm not sure this 
> is the right approach though, it seems to be far too complex.

Well that's discouraging.  I really do want to push this thing along a bit.

Yours is the only report of regression of which I am aware.  Is the reason
understood?

And is anyone developing alternative SMT enhancements?
