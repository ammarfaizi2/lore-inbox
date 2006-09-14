Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWINUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWINUdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWINUdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:33:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1773 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751148AbWINUdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:33:02 -0400
Date: Thu, 14 Sep 2006 22:24:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914202452.GA9252@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609142038570.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > > also, the other disadvantages i listed very much count too. Static 
> > > > tracepoints are fundamentally limited because:
> > > > 
> > > >   - they can only be added at the source code level
> > > > 
> > > >   - modifying them requires a reboot which is not practical in a
> > > >     production environment
> > > > 
> > > >   - there can only be a limited set of them, while many problems need
> > > >     finegrained tracepoints tailored to the problem at hand
> > > > 
> > > >   - conditional tracepoints are typically either nonexistent or very
> > > >     limited.
> 
> Sorry, but I fail to see the point you're trying to make (beside your 
> personal preferences), none of this is a unsolvable problem, which 
> would prevent making good use of static tracepoints.

those are technical arguments - i'm not sure how you can understand them 
to be "personal preferences". The only personal preference i have is 
that in the end a technically most superior solution should be merged. 
(be that one project or the other, or a hybrid of the two) The analysis 
of which one is a better solution depends on pros and cons - exactly 
like the ones listed above. If they are solvable problems then please 
let me know how you would solve them and when you (or others) would 
solve them, preferably before merging the code. Right now they are 
pretty heavy cons as far as LTT goes, so obviously they have a primary 
impact on the topic at hand (whic is whether to merge LTT or not).

	Ingo
