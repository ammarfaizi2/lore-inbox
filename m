Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWIOODr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWIOODr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWIOODr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:03:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22437 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751475AbWIOODq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:03:46 -0400
Date: Fri, 15 Sep 2006 16:03:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jes Sorensen <jes@sgi.com>
cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <450AAE39.4040205@sgi.com>
Message-ID: <Pine.LNX.4.64.0609151556270.6761@scrub.home>
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home>
 <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home>
 <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home>
 <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
 <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home>
 <450AAE39.4040205@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Jes Sorensen wrote:

> Roman Zippel wrote:
> > The claim that these tracepoints would be maintainance burden is pretty 
> > much unproven so far. The static tracepoint haters just assume the kernel 
> > will be littered with thousands of unrelated tracepoints, where a good 
> > tracepoint would only document what already happens in that function, so 
> > that the tracepoint would be far from something obscure, which only few 
> > people could understand and maintain.
> 
> How do you propose to handle the case where two tracepoint clients wants
> slightly different data from the same function? I saw this with LTT
> users where someone wanted things in different places in schedule().
> 
> It *is* a nightmare to maintain.

That nightmare would not be with tracepoints itself, but with the users of 
it, so you're missing the point.
Tracepoints can be abused of course, but it's quite a leap to conclude 
from this that they are bad in general.

> You still haven't explained your argument about kprobes not being
> generally available - where?

Huh? What kind of explanation do you want?

$ grep KPROBES arch/*/Kconf*
arch/i386/Kconfig:config KPROBES
arch/ia64/Kconfig:config KPROBES
arch/powerpc/Kconfig:config KPROBES
arch/sparc64/Kconfig:config KPROBES
arch/x86_64/Kconfig:config KPROBES

bye, Roman
