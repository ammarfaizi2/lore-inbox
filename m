Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWISM34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWISM34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWISM34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:29:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2521 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030213AbWISM3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:29:55 -0400
Date: Tue, 19 Sep 2006 13:29:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919122933.GA11337@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
	Tim Bird <tim.bird@am.sony.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>
References: <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com> <1158345108.29932.120.camel@localhost.localdomain> <20060915181208.GA17581@elte.hu> <Pine.LNX.4.64.0609152046350.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152046350.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 09:10:44PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 15 Sep 2006, Ingo Molnar wrote:
> 
> > > Ar Gwe, 2006-09-15 am 13:08 -0400, ysgrifennodd Frank Ch. Eigler:
> > > > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > > - where 1000-cycle int3-dispatching overheads too high
> > > 
> > > Why are your despatching overheads 1000 cycles ? (and if its due to 
> > > int3 why are you using int 3 8))
> > 
> > this is being worked on actively: there's the "djprobes" patchset, which 
> > includes a simplified disassembler to analyze common target code and can 
> > thus insert much faster, call-a-trampoline-function based tracepoints 
> > that are just as fast as (or faster than) compile-time, static 
> > tracepoints.
> 
> Who is going to implement this for every arch?
> Is this now the official party line that only archs, which implement all 
> of this, can make use of efficient tracing?

Come on, stop trying to be an asshole.  It's always been the case that to
use new functionality you have to add arch code where nessecary.
