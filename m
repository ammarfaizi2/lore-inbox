Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWIOA1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWIOA1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIOA1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:27:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42143 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750986AbWIOA1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:27:33 -0400
Date: Fri, 15 Sep 2006 02:27:15 +0200 (CEST)
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
In-Reply-To: <20060914234354.GA2754@elte.hu>
Message-ID: <Pine.LNX.4.64.0609150211480.6761@scrub.home>
References: <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home>
 <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home>
 <20060914202452.GA9252@elte.hu> <Pine.LNX.4.64.0609142248360.6761@scrub.home>
 <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net>
 <Pine.LNX.4.64.0609142324181.6761@scrub.home> <20060914221521.GA23371@elte.hu>
 <Pine.LNX.4.64.0609150113450.6761@scrub.home> <20060914234354.GA2754@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

>  int __trace function(char arg1, char arg2)
>  {
>  }
> 
> where kprobes can be used to attach a lightweight tracepoint that does a 
> call, not a break (INT3) instruction. With static tracers we couldnt do 
> this so we'd have to stick with the static tracepoints forever! It's 
> always hard to remove features, so we have to make sure we add the 
> feature that we know is the best long-term solution.

Where is the prove for that? Why can't the same rules apply to dynamic and 
static trace points?
You're also mixing up function tracing with event tracing. Most of the LTT 
trace points log rather high level events, which are rather unlikely to  
disappear. It's more likely that the place where they are generated is 
moved and then it's only advantageous if the marker is moved as well at 
the same time. OTOH if the actual event really is not generated anymore, 
there is also no need for the marker anymore.

bye, Roman
