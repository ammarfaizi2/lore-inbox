Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWAKBaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWAKBaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWAKBaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:30:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932760AbWAKBaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:30:10 -0500
Date: Tue, 10 Jan 2006 17:31:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Message-Id: <20060110173159.55cce659.akpm@osdl.org>
In-Reply-To: <43C45BDC.1050402@google.com>
References: <43C45BDC.1050402@google.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> OK, I fixed the graphs so you can actually read them now ;-)

They're cute.

> http://test.kernel.org/perf/kernbench.elm3b6.png (x86_64 4x)
> http://test.kernel.org/perf/kernbench.moe.png (NUMA-Q)
> http://test.kernel.org/perf/kernbench.elm3b132.png (4x SMP ia32)
> 
> Both seems significantly slower on -mm (mm is green line)

Well, 1% slower.  -mm has permanent not-for-linus debug things, some of
which are expected to have a performance impact.  I don't know whether
they'd have a 1% impact though.

> If I look at diffprofile between 2.6.15 and 2.6.15-mm1, it just looks
> like we have lots more idle time.

Yes, we do.   It'd be useful to test -git7..

> You got strange scheduler changes in
> there, that you've been carrying for a long time (2.6.14-mm1 at least)? 
> or HZ piddling? See to be mainly getting much more idle time.

Yes, there are CPU scheduler changes, although much fewer than usual. 
Ingo, any suggestions as to a culprit?

