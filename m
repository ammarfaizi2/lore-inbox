Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWIOUBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWIOUBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWIOUBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:01:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751664AbWIOUBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:01:04 -0400
Date: Fri, 15 Sep 2006 12:59:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: karim@opersys.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-Id: <20060915125934.6c82b625.akpm@osdl.org>
In-Reply-To: <450AEDF2.3070504@opersys.com>
References: <20060914033826.GA2194@Krystal>
	<20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu>
	<Pine.LNX.4.64.0609141623570.6761@scrub.home>
	<20060914171320.GB1105@elte.hu>
	<Pine.LNX.4.64.0609141935080.6761@scrub.home>
	<20060914181557.GA22469@elte.hu>
	<4509B03A.3070504@am.sony.com>
	<1158320406.29932.16.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609151339190.6761@scrub.home>
	<1158323938.29932.23.camel@localhost.localdomain>
	<20060915104527.89396eaf.akpm@osdl.org>
	<450AEDF2.3070504@opersys.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 14:16:18 -0400
Karim Yaghmour <karim@opersys.com> wrote:

> > Although IMO this is a bit lame - it is quite possible to go into
> > SexySystemTapGUI, click on a particular kernel file-n-line and have
> > systemtap userspace keep track of that place in the kernel source across
> > many kernel versions: all it needs to do is to remember the file+line and a
> > snippet of the surrounding text, for readjustment purposes.
> 
> Sure, if you're a kernel developer, but as I've explained numberous
> times in this thread, there are far more many users of tracing than
> kernel developers.

Disagree.  I was describing a means by which a set of systemtap trace
points could be described.  A means which would allow those tracepoints to
be maintained without human intervention as the kernel source changes. 
(ie: use a similar algorithm and representation as patch(1)).

Presumably those tracepoints would have been provided by a kernel developer
and delivered to non-developers, just like static tracepoints.

> > (*) I don't buy the performance arguments: kprobes are quick, and I'd
> > expect that the CPU consumption of the destination of the probe is
> > comparable to or higher than the cost of taking the initial trap.
> 
> Please see Mathieu's earlier posting of numbers comparing kprobes to
> static points. Nevertheless, I do not believe that the use of kprobes
> should be pitted against static instrumentation, the two are
> orthogonal.

People have been speeding up kprobes in recent kernels, to avoid the int3
overhead.  I don't recall seeing how effective that has been.
