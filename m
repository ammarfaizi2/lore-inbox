Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWIVG7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIVG7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIVG73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:59:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28854 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750799AbWIVG73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:59:29 -0400
Date: Fri, 22 Sep 2006 08:49:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922064955.GA4167@elte.hu>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921214248.GA10097@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4950]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:

> >   "As an example, LTTng traces the page fault handler, when kprobes 
> >   just can't instrument it."
> > 
> > but tracing a raw pagefault at the arch level is a bad idea anyway, 
> > we want to trace __handle_mm_fault(). That way you can avoid having 
> > to modify every architecture's pagefault handler ...
> 
> Then you lose the ability to trace in-kernel minor page faults.

that's wrong, minor pagefaults go through __handle_mm_fault() just as 
much.

	Ingo
