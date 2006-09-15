Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWIOOr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWIOOr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWIOOr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:47:27 -0400
Received: from opersys.com ([64.40.108.71]:39175 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751600AbWIOOr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:47:26 -0400
Message-ID: <450ABF59.4010301@opersys.com>
Date: Fri, 15 Sep 2006 10:57:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>	 <20060914171320.GB1105@elte.hu>	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>	 <1158320406.29932.16.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>	 <1158327696.29932.29.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151523050.6761@scrub.home>	 <1158331277.29932.66.camel@localhost.localdomain>	 <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain>
In-Reply-To: <1158332324.29932.82.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> The gdb debug data lets you find each line and also the variable
> assignments (except when highly optimised in some cases). Try
> breakpointing there with kgdb and using "where"... A kgdb script is the
> wrong way to do instrumentation but it does demonstrate the information
> is already out there, automatically generated and self maintaining.
> 
> You do need the gdb -g debug data, but equally if it was static you'd
> need to recompile with the tracepoint because it would be off by
> default, and there is a very small risk in both cases you'll disturb or
> change the code behaviour/flow.
...
> Thats why we have things like systemtap.
> 
> All we appear to lack is systemtap ability to parse debug data so it can
> be told "trace on line 9 of sched.c and record rq and next"

Thanks for the explanation. But I submit to you that both explanations
actually highlight the argument I was making earlier with regards to
dynamic tracing (and gdb info in this case) actually require a non-
expert to chase kernel versions and create appropriate appropriate
scripts/config-info for the post-insertion of instrumentation, with
the risks to kernel developers this may have (ex.: bug report to
lkml from user claiming to have discovered problem in subsystem when,
in fact, trace point by external maintainer was ill-chosen.)

Cheers,

Karim
