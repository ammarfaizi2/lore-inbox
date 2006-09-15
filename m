Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWIOPNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWIOPNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWIOPNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:13:47 -0400
Received: from opersys.com ([64.40.108.71]:61447 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751622AbWIOPNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:13:47 -0400
Message-ID: <450AC57B.9080309@opersys.com>
Date: Fri, 15 Sep 2006 11:23:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158333863.29932.91.camel@localhost.localdomain>
In-Reply-To: <1158333863.29932.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> b has been done, its called kprobes. We just need better tools for the
> dynamic probes.

As long as there needs to be the updating of an outside piece of something
then "b" hasn't been done. Especially with regards to what this means
to figuring out which of kernel or instrumentation-script is broken when
you get bug reports on lkml.

> and you can maintain "Karim's probe list" which is the dynamic probe set
> which matches your old static probes, only of course its now much more
> flexible.

Sorry, the issue isn't about my probe list. The issue is that there
needs to be a way of pointing important events without having to
modify things at 3 or 4 different places. The only way this can be
done is if it's in the tree -- regardless of the mechanism. This
isn't about static tracers vs. dynamic tracers, it's about statically
marking code. What goes underneath is secondary. And if the static
markup -- with even the SystemTap people are interested in -- is
but a hook for further selecting the appropriate instrumentation
mechanism, then that's fine too.

Karim
