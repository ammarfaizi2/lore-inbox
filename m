Return-Path: <linux-kernel-owner+w=401wt.eu-S1752417AbWL2Mel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbWL2Mel (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbWL2Mel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:34:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33230 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbWL2Mek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:34:40 -0500
Date: Fri, 29 Dec 2006 13:31:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-ID: <20061229123127.GA19563@elte.hu>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > Hmm? I'd love it if somebody else wrote the patch and tested it, 
> > because I'm getting sick and tired of this bug ;)
> 
> Who the hell am I kidding? I haven't been able to sleep right for the 
> last few days over this bug. It was really getting to me.
> 
> And putting on the thinking cap, there's actually a fairly simple an 
> nonintrusive patch. [...]

ok, your patch seems to fix the testcase here too on -rc2-rt.

[ Damn, i should have slept a bit more, that would have saved me a ~4
  hour debug and tracing session today to analyze your testcase, just to
  find your patch and your explanation on lkml, right after i sent my
  analysis and workaround patch ;-) At least now we know it from two
  independent tracing results that the suspect code is the same. ]

	Ingo
