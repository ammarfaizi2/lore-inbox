Return-Path: <linux-kernel-owner+w=401wt.eu-S965176AbWL2WAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWL2WAV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWL2WAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:00:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34956 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965173AbWL2WAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:00:20 -0500
Date: Fri, 29 Dec 2006 22:57:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ollie Wild <aaw@google.com>, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] remove MAX_ARG_PAGES
Message-ID: <20061229215714.GA21694@elte.hu>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com> <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com> <20061229200357.GA5940@elte.hu> <20061229204904.GI20596@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229204904.GI20596@flint.arm.linux.org.uk>
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


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Dec 29, 2006 at 09:03:57PM +0100, Ingo Molnar wrote:
> > FYI, i have forward ported your MAX_ARG_PAGES limit removal patch to 
> > 2.6.20-rc2 and have included it in the -rt kernel. It's working great - 
> > i can now finally do a "ls -t patches/*.patch" in my patch repository - 
> > something i havent been able to do for years ;-)
> 
> How do the various autoconf stuff react to this?  Eg, I notice the 
> following in various configure scripts:
> 
> checking the maximum length of command line arguments... 32768

yes, that's how libtool works, it goes from 32K downwards to figure out 
a maximum. I dont see a problem there.

you can find a few other variants at:

  http://www.google.com/codesearch?q=%22checking+the+maximum+length+of+command+line+arguments%22&hl=en&btnG=Search+Code

worst-case the test-command would get a segfault from the default stack 
limit. (8MB on Fedora)

	Ingo
