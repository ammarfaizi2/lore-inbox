Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWINUJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWINUJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWINUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:09:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4310 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751114AbWINUJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:09:36 -0400
Date: Thu, 14 Sep 2006 22:00:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914200040.GB5812@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509B03A.3070504@am.sony.com>
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


* Tim Bird <tim.bird@am.sony.com> wrote:

> > that's not true, and this is the important thing that i believe you 
> > are missing. A dynamic tracepoint is _detached_ from the normal 
> > source code and thus is zero maintainance overhead. You dont have to 
> > maintain it during normal development - only if you need it. You 
> > dont see the dynamic tracepoints in the source code.
> 
> It's only zero maintenance overhead for you.  Someone has to maintain 
> it. The party line for years has been that in-tree maintenance is 
> easier than out-of-tree maintenance.

There's a third option, and that's the one i'm advocating: adding the 
tracepoint rules to the kernel, but in a _detached_ form from the actual 
source code.

yes, someone has to maintain it, but that will be a detached effort, on 
a low-frequency as-needed basis. It doesnt slow down or hinder 
high-frequency fast prototyping work, it does not impact the source code 
visually, and it does not make reading the code harder. Furthermore, 
while a single broken LTT tracepoint prevents the kernel from building 
at all, a single broken dynamic rule just wont be inserted into the 
kernel. All the other rules are still very much intact.

	Ingo
