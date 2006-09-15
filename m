Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWION5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWION5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWION5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:57:23 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:746 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751469AbWION5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:57:22 -0400
Date: Fri, 15 Sep 2006 22:57:09 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915135709.GB8723@localhost.usen.ad.jp>
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609151535030.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 03:41:03PM +0200, Roman Zippel wrote:
> > On Fri, Sep 15, 2006 at 08:38:33AM -0400, Karim Yaghmour wrote:
> > I didn't get the "instrumentation is evil" mantra from this thread,
> > rather "static tracepoints are good, so long as someone else is
> > maintaining them". The issue comes down to who ends up maintaining the
> > trace points,
> 
> The claim that these tracepoints would be maintainance burden is pretty 
> much unproven so far. The static tracepoint haters just assume the kernel 
> will be littered with thousands of unrelated tracepoints, where a good 
> tracepoint would only document what already happens in that function, so 
> that the tracepoint would be far from something obscure, which only few 
> people could understand and maintain.
> 
Again, this works fine so long as the number of static tracepoints is
small and manageable, but it seems like there's a division between what
the subsystem developer deems as meaningful and what someone doing the
tracing might want to look at. Static tracepoints are completely
subjective, LTT proved that this was a problem regarding general
code-level intrusiveness when the number of tracepoints in relatively
close locality started piling up based on what people considered
arbitrarily useful, and LTTng doesn't appear to do anything to address
this.

This doesn't really match my definition of a neglible maintenance
burden..
