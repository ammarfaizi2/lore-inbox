Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWISQpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWISQpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWISQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:45:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1234 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750880AbWISQpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:45:35 -0400
Date: Tue, 19 Sep 2006 18:36:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919163655.GA28735@elte.hu>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45101DBA.7000901@google.com>
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


* Martin Bligh <mbligh@google.com> wrote:

> Andrew Morton wrote:
> >On Tue, 19 Sep 2006 09:04:43 -0700
> >Martin Bligh <mbligh@google.com> wrote:
> >
> >
> >>It seems like all we'd need to do
> >>is "list all references to function, freeze kernel, update all
> >>references, continue"
> >
> >
> >"overwrite first 5 bytes of old function with `jmp new_function'".
> 
> Yes, that's simple. but slower, as you have a double jump. Probably a 
> damned sight faster than int3 though.

modern CPUs will probably even optimize that intermediate jump away in 
their BTB-ish caches. But in any case this would solve the function 
pointer problem too.

	Ingo
