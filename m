Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUBPJ4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUBPJ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:56:38 -0500
Received: from gprs154-91.eurotel.cz ([160.218.154.91]:25728 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264444AbUBPJ4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:56:37 -0500
Date: Mon, 16 Feb 2004 10:55:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: kthread, signals and PF_FREEZE (suspend)
Message-ID: <20040216095553.GE276@elf.ucw.cz>
References: <1076890731.5525.31.camel@leto.cs.pocnet.net> <20040216034251.0912E2C0F8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216034251.0912E2C0F8@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The workqueues have PF_IOTHREAD set and I'm only seeing those on my
> > machine that's why it doesn't fail.
> > 
> > But the migration threads for example call signal_pending() directly
> > after schedule() before checking PF_FREEZE and calling refrigerator()
> > (which BTW flushes all signals).
> 
> This will only happen on SMP systems with > 1 cpu though?  I don't
> think suspend works there anyway.
> 
> However, ksoftirqd will die I think: that will hurt if lots of irqs
> come in.
> 
> Pavel, what is the answer here?  Should the refrigerator code be in
> the kthread infrastructure?  Why does the workqueue code set
> PF_IOTHREAD?

I assumed that workqueues may be needed for harddisks to
function... If that's the case, it can't be simply stopped. 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
