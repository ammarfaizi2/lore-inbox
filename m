Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWIPJ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWIPJ66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 05:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWIPJ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 05:58:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63658 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751766AbWIPJ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 05:58:57 -0400
Message-ID: <450BCAF1.2030205@sgi.com>
Date: Sat, 16 Sep 2006 11:59:13 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal>
In-Reply-To: <20060915202233.GA23318@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Please Ingo, stop repeating false argument without taking in account people's
> corrections :
> 
> * Ingo Molnar (mingo@elte.hu) wrote:
>> sorry, but i disagree. There _is_ a solution that is superior in every 
>> aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
>>
> I am sorry to have to repeat myself, but this is not true for heavy loads.

Alan pointed out earlier in the thread that the actual kprobe is noise
in this context, and I have seen similar issues on real workloads. Yes
kprobes are probably a little higher overhead in real life, but you have
to way that up against the rest of the system load.

If you want to prove people wrong, I suggest you do some real life
implementation and measure some real workloads with a predefined set of
tracepoints implemented using kprobes and LTT and show us that the
benchmark of the user application suffers in a way that can actually be
measured. Argueing that a syscall takes an extra 50 instructions
because it's traced using kprobes rather than LTT doesn't mean it
actually has any real impact.

"The 'kprobes' are too high overhead that makes them unusable" is one of
these classic myths that the static tracepoint advocates so far have
only been backing up with rhetoric. Give us some hard evidence or stop
repeating this argument please. Just because something is repeated
constantly doesn't transform it into truth.

Jes
