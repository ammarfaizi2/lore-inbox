Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWINVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWINVCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWINVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:02:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50333 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750991AbWINVCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:02:44 -0400
Date: Thu, 14 Sep 2006 23:02:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914200040.GB5812@elte.hu>
Message-ID: <Pine.LNX.4.64.0609142226480.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
 <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
 <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu>
 <4509B03A.3070504@am.sony.com> <20060914200040.GB5812@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> > It's only zero maintenance overhead for you.  Someone has to maintain 
> > it. The party line for years has been that in-tree maintenance is 
> > easier than out-of-tree maintenance.
> 
> There's a third option, and that's the one i'm advocating: adding the 
> tracepoint rules to the kernel, but in a _detached_ form from the actual 
> source code.
> 
> yes, someone has to maintain it, but that will be a detached effort, on 
> a low-frequency as-needed basis. It doesnt slow down or hinder 
> high-frequency fast prototyping work, it does not impact the source code 
> visually, and it does not make reading the code harder. Furthermore, 
> while a single broken LTT tracepoint prevents the kernel from building 
> at all, a single broken dynamic rule just wont be inserted into the 
> kernel. All the other rules are still very much intact.

This pretty much contradicts existing experience, most core events are 
rather static - a schedule event is a schedule event no matter how the 
actual scheduler is implemented.
Separate tracepoints are like separate documentation, there are forgotten 
by the developers who could easily keep them uptodate if they were close 
to the source.

bye, Roman
