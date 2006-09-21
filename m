Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWIUQSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWIUQSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWIUQSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:18:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36758 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750959AbWIUQSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:18:08 -0400
Date: Thu, 21 Sep 2006 18:06:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
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
Message-ID: <20060921160656.GA24774@elte.hu>
References: <20060921160009.GA30115@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921160009.GA30115@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4969]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:

> +config MARK_SYMBOL
> +config MARK_JUMP_CALL
> +config MARK_JUMP_INLINE
> +config MARK_JUMP

same NACK over the proliferation of options as before:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=115881457219562&w=2

Tap, tap, is this thing on? ;)

found one related reply from you that i didnt answer yet:

  "As an example, LTTng traces the page fault handler, when kprobes just
   can't instrument it."

but tracing a raw pagefault at the arch level is a bad idea anyway, we 
want to trace __handle_mm_fault(). That way you can avoid having to 
modify every architecture's pagefault handler ...

but the other points remained unanswered as far as i can see.

	Ingo
