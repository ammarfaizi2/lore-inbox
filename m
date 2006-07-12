Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWGLVTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWGLVTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGLVTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:19:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28627 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932454AbWGLVTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:19:34 -0400
Date: Wed, 12 Jul 2006 23:13:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: andrea@cpushare.com, Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712211358.GA10811@elte.hu>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
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


* Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> And that's where fail-safe and simple design comes in. In this 
> application an oops is better than a jail-break by orders of 
> magnitude. But then that's why you wrote seccomp instead of using 
> ptrace in the first place.

actually, the client side of ptrace isnt all that more complex. I guess 
one of the main problems with using ptrace was that it has no catchy 
name that Andrea could claim for his project and that it couldnt be 
patented ;-)

Andrea could have isolated the 'client side' functionality of ptrace 
(which is often confused with the 'server side' of ptrace - where the 
overwhelming majority of ptrace security holes were located) and he 
could have made it simple to review, to get a comparable 'feeling' of 
security. [User Mode Linux uses the client-side ptrace model to execute 
untrusted code.]

Andrea could also have extended ptrace to solve whatever marginal 
problems he has with ptrace. [in fact such extension of ptrace was 
posted recently, see Roland McGrath's utrace framework!]

But he chose not to do so - and that has nothing to do with being unable 
to improve ptrace - it evidently is improvable. So i see SECCOMP being 
the result of the NIH syndrome.

	Ingo
