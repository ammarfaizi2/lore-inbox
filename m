Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWIOUO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWIOUO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWIOUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:14:29 -0400
Received: from opersys.com ([64.40.108.71]:1547 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751702AbWIOUO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:14:27 -0400
Message-ID: <450B0BF9.8090407@opersys.com>
Date: Fri, 15 Sep 2006 16:24:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu>	<4509B03A.3070504@am.sony.com>	<1158320406.29932.16.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151339190.6761@scrub.home>	<1158323938.29932.23.camel@localhost.localdomain>	<20060915104527.89396eaf.akpm@osdl.org>	<450AEDF2.3070504@opersys.com> <20060915125934.6c82b625.akpm@osdl.org>
In-Reply-To: <20060915125934.6c82b625.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> People have been speeding up kprobes in recent kernels, to avoid the int3
> overhead.  I don't recall seeing how effective that has been.

I don't want to microdebate this one, but here's the quote from Frank
on the topic of djprobe:
> Smart teams from IBM and Hitachi have been hammering away at this code
> for a year or two now, and yet (roughly) here we are.  There have been
> experiments involving plopping branches instead of int3's at probe
> locations, but this is self-modifying code involving multiple
> instructions, and appears to be tricky on SMP/preempt boxes.

The idea behind this mechanism is neat. But every step along the way
there seem to be ever more complex corner cases where it can't be
used.

Should this mechanism ever be made to work, the need for static
markup would still be felt however.

Karim

