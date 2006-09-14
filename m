Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWINXkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWINXkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWINXkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:40:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26527 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932135AbWINXj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:39:59 -0400
Date: Fri, 15 Sep 2006 01:39:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Daniel Walker <dwalker@mvista.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914221521.GA23371@elte.hu>
Message-ID: <Pine.LNX.4.64.0609150113450.6761@scrub.home>
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home>
 <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home>
 <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home>
 <20060914202452.GA9252@elte.hu> <Pine.LNX.4.64.0609142248360.6761@scrub.home>
 <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net>
 <Pine.LNX.4.64.0609142324181.6761@scrub.home> <20060914221521.GA23371@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> > OTOH I would also like to know what's going in my m68k kernel without 
> > having to implement some rather complex infrastructure, which I don't 
> > need otherwise. There hasn't been a single argument so far, why we 
> > can't have both.
> 
> the argument is very simple: LTT creates strong coupling, it is almost a 
> set of 350+ system-calls, moved into the heart of the kernel. Once moved 
> in, it's very hard to remove it. "Why did you remove that trace 
> information, you broke my LTT script!"

You are changing the topic. Nobody said the current LTT tracepoints have 
to be merged as is. You generalize from a work in progress to static trace 
points in general.

> While with SystemTap the coupling is alot smaller.

What guarantees we don't have similiar problems with dynamic tracepoints?
As soon as any tracing is merged, users will have some kind of expectation 
and thus you can expect "Why did you change this source? It broke my 
SystemTap script!" here as well.

bye, Roman
