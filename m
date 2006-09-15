Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWIPABv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWIPABv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIPABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:01:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37045 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932235AbWIPABu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:01:50 -0400
Date: Sat, 16 Sep 2006 01:53:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915235317.GA29929@elte.hu>
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com> <20060915224338.GA22126@elte.hu> <450B382C.9070202@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B382C.9070202@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> > the tracebuffer management portion of LTT is better than the hacks 
> > in SystemTap, and that LTT's visualization tools are better (for 
> > example they do exist :-) - so clearly there's synergy possible.
> 
> Great, because I believe all those involved would like to see this 
> happen. I personally am convinced that none of those involved want to 
> continue wasting their time in parallel.

a reasonable compromise for me would be what i suggested a few mails 
ago:

 nor do i reject all of LTT: as i said before i like the tools, and i
 think its collection of trace events should be turned into systemtap
 markups and scripts. Furthermore, it's ringbuffer implementation looks
 better. So as far as the user is concerned, LTT could (and should) live
 on with full capabilities, but with this crutial difference in how it
 interfaces to the kernel source code.

i.e. could you try to just give SystemTap a chance and attempt to 
integrate a portion of LTT with it ... that shares more of the 
infrastructure and we'd obviously only need "one" markup variant, and 
would have full markup (removal-) flexibility. I'll try to help djprobes 
as much as possible. Hm?

	Ingo
