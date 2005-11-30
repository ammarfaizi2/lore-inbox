Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVK3B6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVK3B6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVK3B6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:58:14 -0500
Received: from ns2.suse.de ([195.135.220.15]:61156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbVK3B6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:58:13 -0500
Date: Wed, 30 Nov 2005 02:58:09 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       acpi-devel@lists.sourceforge.net, nando@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, Vojtech Pavlik <vojtech@suse.cz>,
       johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051130015809.GF19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com> <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe> <20051129205108.GQ19515@wotan.suse.de> <1133308505.4627.31.camel@mindpipe> <20051130010646.GD19515@wotan.suse.de> <1133313771.4627.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133313771.4627.39.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then you're likely running 32bit. It doesn't use vsyscall gettimeofday
> > yet, which makes it slower. 64bit would.
> 
> Yes, I am.  So it sounds like vsyscall gettimeofday for i386 is in the
> works?

John Stultz used to have patches for it, but for some reason he never
pushed them into mainline. On i386 it unfortunately needs adding
a test and branch to the syscall path to be 100% ABI compatible, but I 
doubt that was the reason he dropped it.

-Andi
