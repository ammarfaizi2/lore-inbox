Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUIYPpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUIYPpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 11:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUIYPpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 11:45:49 -0400
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:58245 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269353AbUIYPpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 11:45:44 -0400
Date: Sat, 25 Sep 2004 17:45:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@linuxmail.org, Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040925154527.GA8212@elf.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com> <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com> <1096069216.3591.16.camel@desktop.cunninghams> <20040925014546.200828E71E@voldemort.scrye.com> <1096113235.5937.3.camel@desktop.cunninghams> <415562FE.3080709@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415562FE.3080709@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>What causes memory to be so fragmented? 
> >
> >
> >Normal usage; the pattern of pages being freed and allocated inevitably
> >leads to fragmentation. The buddy allocator does a good job of
> >minimising it, but what is really needed is a run-time defragmenter. I
> >saw mention of this recently, but it's probably not that practical to
> >implement IMHO.
> 
> Well, by this stage it looks like memory is already pretty well shrunk
> as much as it is going to be, which means that even a pretty capable
> defragmenter won't be able to do anything.

True, defragmenter would not help.

Anyway, conversion from order-8 allocation should be pretty easy, but
I never seen that failure case and this is first report... So I'm not
doing that work just yet. [There's big chunk of changes waiting in
-mm, that needs to be merged because any other work should be done.]

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
