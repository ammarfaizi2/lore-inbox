Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965586AbWIRIoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965586AbWIRIoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965588AbWIRIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:44:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26602 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965586AbWIRIoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:44:08 -0400
Message-ID: <450E5C2F.8030808@sgi.com>
Date: Mon, 18 Sep 2006 10:43:27 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home> <450D8C58.5000506@yahoo.com.au> <Pine.LNX.4.64.0609172027120.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609172027120.6761@scrub.home>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 18 Sep 2006, Nick Piggin wrote:
> 
>> But equally nobody can demand that a feature go into the upstream
>> kernel. Especially not if there is a more flexible alternative
>> already available that just requires implementing for their arch.
> 
> I completely agree with you under the condition that these alternatives 
> were mutually exclusive or conflicting with each other.

Roman,

I don't get this, you are arguing that we should put it in because it
doesn't do any damage. First of all it does, by adding a lot of clutter
all over the place. Second, if we take that argument, then we should
allow anybody to put in anything they want, are you also suggesting we
put devfs back in?

Point is that the Linux kernel gets so many proposals, some are good
some are bad and some while maybe looking like a good idea at the
beginning, show out later to be a bad idea - LTT falls into this
category. *However*, it doesn't mean the knowledge and tools that were
developed with LTT are bad or useless.

To take another related project, look at relayfs. There was so much
noise about it when it was initially pushed, yuck I even remember how it
was suggested that printk should be implemented via relayfs. But look at
it now, there is no fs/relayfs/* these days. The kernel moved on, used
the knowledge optained and provided the feature in a better way -
exactly like it is being proposed to do for trace points, by using
dynamic probes.

Jes
