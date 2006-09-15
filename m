Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWIOSbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWIOSbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWIOSbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:31:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31124 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932164AbWIOSbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:31:40 -0400
Date: Fri, 15 Sep 2006 20:23:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, karim@opersys.com,
       Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915182333.GA20149@elte.hu>
References: <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com> <1158345108.29932.120.camel@localhost.localdomain> <20060915182428.GI4577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915182428.GI4577@redhat.com>
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


* Frank Ch. Eigler <fche@redhat.com> wrote:

> > Why are your despatching overheads 1000 cycles ? (and if its due to 
> > int3 why are you using int 3 8))
> 
> Smart teams from IBM and Hitachi have been hammering away at this code 
> for a year or two now, and yet (roughly) here we are.  There have been 
> experiments involving plopping branches instead of int3's at probe 
> locations, but this is self-modifying code involving multiple 
> instructions, and appears to be tricky on SMP/preempt boxes.

i am talking to them about that, and i'm 100% sure the solution is much 
easier than the many (much harder) problems that SystemTap has already 
solved. I think you are way too modest to realize how powerful (and 
important) SystemTap is :-)

	Ingo
