Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWIOJ30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWIOJ30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIOJ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:29:26 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:56475 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750796AbWIOJ3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:29:25 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@mbligh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu>
	<Pine.LNX.4.64.0609141623570.6761@scrub.home>
	<20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org>
	<20060914203430.GB9252@elte.hu>
From: Jes Sorensen <jes@sgi.com>
Date: 15 Sep 2006 05:29:24 -0400
In-Reply-To: <20060914203430.GB9252@elte.hu>
Message-ID: <yq03bateavf.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> * Martin Bligh <mbligh@mbligh.org> wrote:

>> I don't think anyone is saying that static tracepoints do not have
>> their limitations, or that dynamic tracepointing is useless. But
>> that's not the point ... why can't we have one infrastructure that
>> supports both? Preferably in a fairly simple, consistent way.

Ingo> primarily because i fail to see any property of static tracers
Ingo> that are not met by dynamic tracers. So to me dynamic tracers
Ingo> like SystemTap are a superset of static tracers.

Ingo> So my position is that what we should concentrate on is to make
Ingo> the life of dynamic tracers easier (be that a handful of
Ingo> generic, parametric hooks that gather debuginfo information and
Ingo> add NOPs for easy patching), while realizing that static tracers
Ingo> have no advantage over dynamic tracers.

The parallel that springs to mind here is C++ kernel components 'I
promise to only use the good parts', then next week someone else adds
another pile in a worse place. Once the points are in we will never
get rid of them, look at how long it took to get rid of devfs :( In
addition it is guaranteed that people will not be able to agree on
which points to put where, despite the claim that there will be only
30 points - sorry, I am not buying that, we have plenty of evidence to
show the opposite.

I looked at the old LTT code a while ago and it was pretty appalling,
maybe LTTng is better, but I can't say the old code gave me a warm
fuzzy feeling.

Jes
