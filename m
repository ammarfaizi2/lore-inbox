Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWIRQhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWIRQhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWIRQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:37:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42902 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751837AbWIRQhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:37:12 -0400
Date: Mon, 18 Sep 2006 18:28:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: MARKER mechanism, try 2
Message-ID: <20060918162828.GA22910@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <20060918163042.GA15192@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918163042.GA15192@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> It supports 5 modes :
> 
> - marker becomes nothing
> - marker calls printk
> - marker calls a tracer
> - marker puts a symbol (for kprobe)
> - marker puts a symbol and 5 NOPS for a jump probe.

just go for 'nothing' and the 5-NOP variant, and please implement 
support for it from within LTT, via a kprobe - if you want me to support 
this stuff for upstream inclusion. If we support any static tracer mode 
and LTT does not support the kprobe mode then we are back to square 1 
wrt. dependencies ...

	Ingo
