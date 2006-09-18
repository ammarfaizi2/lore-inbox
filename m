Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965392AbWIRFRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbWIRFRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965394AbWIRFRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:17:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58763 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965392AbWIRFRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:17:20 -0400
Date: Mon, 18 Sep 2006 07:08:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918050843.GA28459@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918024343.GA23149@Krystal> <20060918032120.GA13076@elte.hu> <20060918042652.GB15930@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918042652.GB15930@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4997]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> The following example voids your example : there are ways to implement 
> static markers that *could* have access to those variables. 
> (implementation detail)
> 
> int x = 5;
> 
> #define MARK(a) printk(a, x)

but this is only hiding it syntactically, hence the same 
parameter-access side-effect remains - while in the dynamic probe case 
the variable is accessed within the probe - so the true effect on the 
callsite is different. But, in terms of having access to the 
information, you (and Karim) are right that the static tracer can access 
it too.

	Ingo
