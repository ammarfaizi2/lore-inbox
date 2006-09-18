Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWIRAGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWIRAGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWIRAGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:06:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32446 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965161AbWIRAGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:06:10 -0400
Date: Mon, 18 Sep 2006 02:05:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <20060917230623.GD8791@elte.hu>
Message-ID: <Pine.LNX.4.64.0609180136340.6761@scrub.home>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
 <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy>
 <20060917230623.GD8791@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Sep 2006, Ingo Molnar wrote:

> what is being proposed here is entirely different from dprobes though: 
> Roman suggests that he doesnt want to implement kprobes on his arch, and 
> he wants LTT to remain an _all-static_ tracer. [...]
> 
> Even if the LTT folks proposed to "compromise" to 50 tracepoints - users 
> of static tracers would likely _not_ be willing to compromise, so there 
> would be a constant (and I say unnecessary) battle going on for the 
> increase of the number of static markers. Static markers, if done for 
> static tracers, have "viral" (Roman: here i mean "auto-spreading", not 
> "disease") properties in that sense - they want to spread to alot larger 
> area of code than they start out from.

1. It's not that I don't want to, but I _can't_ implement kprobes and not 
due to lack of skills, but lack of resources. (There is a subtle but 
important difference.)
2. I don't want LTT to be "all static tracer" at all, I want it to be 
usable as a static tracer, so that on archs where kprobes are available it 
can use them of course. This puts your second paragraph in a new 
perspective, since the userbase and thus the pressure for more and more 
static tracepoints would be different.

bye, Roman
