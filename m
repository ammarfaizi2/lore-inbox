Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWFBHVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWFBHVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFBHVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:21:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43207 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751254AbWFBHVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:21:16 -0400
Date: Fri, 2 Jun 2006 09:21:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: jbeulich@novell.com, jeff@garzik.org, htejun@gmail.com,
       reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602072138.GA10622@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <447FFCAC.76E4.0078.0@novell.com> <20060602070948.GB9721@elte.hu> <20060602002252.aaa5e4e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602002252.aaa5e4e3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Fri, 2 Jun 2006 09:09:48 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > In all other cases (if we go outside of the stack page(s)) we _must_ 
> > fall back to the dump 'scan the stack pages for interesting entries' 
> > method, to get the information out! "Uh oh the unwind info somehow got 
> > corrupted, sorry" is not enough to debug a kernel bug.
> 
> Also, it might be worth doing a two-pass thing.  Pass 1 doesn't print 
> anything - it just figures out whether pass2 will succeed.  If not, 
> fall back without printing anything.

correct, that's what stacktrace.c does for example. In the first lockdep 
queue i switched show_trace() to make use of stacktrace.c, so it can be 
used for printing traces too.

	Ingo
