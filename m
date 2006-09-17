Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWIQXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWIQXuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWIQXuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:50:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43675 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932149AbWIQXuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:50:01 -0400
Date: Mon, 18 Sep 2006 01:41:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917234152.GA20374@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home> <20060917150953.GB20225@elte.hu> <Pine.LNX.4.64.0609171816390.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171816390.6761@scrub.home>
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

> And yet again, you offer no prove at all and just work from 
> assumptions. You throw in some magic "_full set_" of marker and just 
> assume any change in that will completely break static tracers. [...]

i'm not sure i understand what you are trying to say here. Are you 
saying that if i replaced half of the static markups with function 
attributes (which would still provide equivalent functionality for 
dynamic tracers), or if i removed a few dozen static markups with 
dynamic scripts (which change too would be transparent to users of 
dynamic tracers), that in this case static tracers would /not/ break? 
[if yes then that would be the most puzzling suggestion ever posed in 
this thread]

> You completely ignore that it might be possible to create some rules 
> and educate users that the amount of exported events can't be 
> completely static.

no serious trace user would accept it if for example half of their 
static tracepoints would go away, because for example they were made 
dynamic (or they were made function attributes).

that's the plain meaning of what i said. Were we to accept static 
tracers, we'd be stuck with the full set of static tracepoints for a 
long time, because users of static tracers would not accept a 
significant reduction in the number of tracepoints. (even if those 
"reduced" tracepoints were in fact just moved over to dynamic probes)

Was it truly confusing to you what i said? (in words that i thought were 
more than clear) Please let me know and i'll try to formulate more 
verbosely and more clearly when replying to you. This must be some 
fundamental communication issue between you and me.

	Ingo
