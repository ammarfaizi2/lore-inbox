Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIQOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIQOId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWIQOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 10:08:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28317 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751138AbWIQOIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 10:08:32 -0400
Date: Sun, 17 Sep 2006 16:00:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917140009.GA15534@elte.hu>
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060917101356.GA1982@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917101356.GA1982@slug>
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


* Frederik Deweerdt <deweerdt@free.fr> wrote:

> On Sat, Sep 16, 2006 at 09:37:45PM +0200, Ingo Molnar wrote:
> > --------------->
> > Subject: [patch] kprobes: speed INT3 trap handling up on i386
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > speed up kprobes trap handling by special-casing kernel-space
> > INT3 traps (which do not occur otherwise) and doing a kprobes
> > handler check - instead of redirecting over the i386-die-notifier
> > chain.
> > 
> Hi Ingo,
> 
> Not that it would make any difference to the actual kprobe 
> performance, but I think that not using the die-notifier chain makes 
> the DIE_INT3 handling in kprobe_exceptions_notify() useless.

yeah, indeed - i'll add your patch to the kprobes patchset.

	Ingo

